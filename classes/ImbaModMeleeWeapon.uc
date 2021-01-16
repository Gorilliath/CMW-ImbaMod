class ImbaModMeleeWeapon extends AOCMeleeWeapon;


var bool bRequiresComboAnimFix;

var float fStaminaGainOnHit;			// Amount of stamina rewarded for successfully damaging an opponent with this weapon
var float fStaminaGainOnRiposteParry;	// Amount of stamina rewarded for successfully parrying an attack during riposte (Not including iFeintStaminaCost refund)
var float fMissAdditionalStaminaCost;	// Amount of stamina contributing to the stamina cost for missing an attack (Added to iFeintStaminaCost)
var float fComboMinimumStamina;			// Minimum amount of stamina required to combo (Isn't actually consumed; it's just a requirement)

var bool bParryWasDuringRiposte;
var bool bFeintCostWasRefunded;


simulated state ParryRelease
{
    simulated function BeginFire(byte FireModeNum)
    {
        super.BeginFire(FireModeNum);

        if (AOCOwner.IsLocallyControlled()) {

            // Riposte can be cancelled with a parry
            if (bSuccessfulParry && bParryHitCounter && FireModeNum == Attack_Parry) {
                ClearTimer('PlayRiposteAnimation');
                ClearTimer('OnStateAnimationEnd');
                AOCOwner.ConsumeStamina(iFeintStaminaCost);
                ActivateParry();
                if (WorldInfo.NetMode != NM_Standalone && (Worldinfo.NetMode != NM_ListenServer || !AOCOwner.IsLocallyControlled())) {
                    ServerActivateParry();
                }

                bParryWasDuringRiposte = true;
            }
        }
    }

    simulated function SuccessfulParry(EAttack Type, int Dir)
    {
        // If the parry was during riposte resolve rewards
        if (bParryWasDuringRiposte) {

            // If the stamina cost for parrying during riposte has not been refunded
            if (!bFeintCostWasRefunded) {
                
                // Refund the cost
                AOCOwner.ConsumeStamina(- iFeintStaminaCost);

                // Record that it has been refunded
                bFeintCostWasRefunded = true;
            }

            // Reward the parry with the weapon's bonus stamina gain
            AOCOwner.ConsumeStamina(- fStaminaGainOnRiposteParry);
        }

        super.SuccessfulParry(Type, Dir);
    }

    simulated event EndState(Name NextStateName)
    {
        super.EndState(NextStateName);
        AOCOwner.StateVariables.bIsParrying = false;
        AOCOwner.StateVariables.bIsActiveShielding = false;

        // Every parry invokes the global stamina regen cooldown
        ImbaModPawn(AOCOwner).StartStaminaRegenCooldown();
    }

}

simulated state Release
{
    simulated function BeginFire(byte FireModeNum)
    {
        super.BeginFire(FireModeNum);

        // Riposte can be cancelled with a parry
        if (FireModeNum == Attack_Parry && bParryHitCounter) {
            AttackQueue = Attack_Null;
            ClearTimer('OnStateAnimationEnd');
            AOCOwner.ConsumeStamina(iFeintStaminaCost);
            ActivateParry();
            if (WorldInfo.NetMode != NM_Standalone && (Worldinfo.NetMode != NM_ListenServer || !AOCOwner.IsLocallyControlled())) {
                ServerActivateParry();
            }

            bParryWasDuringRiposte = true;
        }
    }

    simulated function PlayStateAnimation()
    {
        local AnimationInfo Info;

        // If it's a weapon which requires the combo animation fix (default causes a spasmodic spaghetti calamity) and the weapon is comboing
        if (bRequiresComboAnimFix && bIsInCombo)
        {
            // add to number of combos performed
            iComboCount++;
            AOCOwner.OnComboIncreased();

            if (CurrentFireMode != Attack_Sprint && !AOCOwner.bIsCrouching && AOCOwner.Physics != PHYS_Falling)
            {
                if (VSize(AOCOwner.Velocity) > 2.0f && !Info.bUseRMM)
                    AOCOwner.Lunge(,,true);
                else if (VSize(AOCOwner.Velocity) <= 2.f && !Info.bUseRMM)
                    Info.bFullBody = false;
            }

            // pass this information down to the weapon attachment
            AOCWepAttachment.ComboCount = iComboCount;

            // pass in proper animation, let pawn determine which node to use on the AnimTree
            if (bJustPlayedCombo || ePreviousAttack == Attack_Stab)
            {
                // odd sequential attacks should be the normal attack animation
                AOCOwner.ReplicateCompressedAnimation(ReleaseAnimations[CurrentFireMode], EWST_Release, CurrentFireMode);
                bJustPlayedCombo = false;
            }
            else
            {
                // even sequential attacks should be the combo attack animation
                Info = ReleaseAnimations[CurrentFireMode];
                Info.bCombo = true;
                AOCOwner.ReplicateCompressedAnimation(Info, EWST_Release, CurrentFireMode);
                bJustPlayedCombo = true;
            }
        }
        else
            super.PlayStateAnimation(); // default handle for playing animation is fine if we are not doing a combo
    }

    simulated function EndState( name NextStateName )
    {
        local float CurrentStamina;
        local float StaminaLoss;

        CurrentStamina = AOCOwner.Stamina;

        if (AOCOwner.IsLocallyControlled() || AOCOwner.bIsBot)
        {
            if (bHitPawn)
            {
                //Inform Pawn that the attack was successful
                if(CurrentFireMode >= Attack_Slash && CurrentFireMode <= Attack_Sprint)
                {
                    AOCOwner.OnActionSucceeded(EPlayerAction(CurrentFireMode + EACT_AttackSlash));
                }
                else if(CurrentFireMode == Attack_Shove)
                {
                    if(AOCOwner.StateVariables.bShieldEquipped)
                    {
                        AOCOwner.OnActionSucceeded(EACT_ShieldBash);
                    }
                    else
                    {
                        AOCOwner.OnActionSucceeded(EACT_Kick);
                    }
                }
                ComboHitCount++;

                AOCowner.NotifyScoreHit();
            }
            else
            {
                //Inform Pawn that the attack failed
                if(CurrentFireMode >= Attack_Slash && CurrentFireMode <= Attack_Sprint)
                {
                    AOCOwner.OnActionFailed(EPlayerAction(CurrentFireMode + EACT_AttackSlash));
                }
                else if(CurrentFireMode == Attack_Shove)
                {
                    if(AOCOwner.StateVariables.bShieldEquipped)
                    {
                        AOCOwner.OnActionFailed(EACT_ShieldBash);
                    }
                    else
                    {
                        AOCOwner.OnActionFailed(EACT_Kick);
                    }
                }

                // Handle missed attacks
                if (CurrentFireMode != Attack_Parry &&          // Missing a parry shouldn't cost stamina
                    NextStateName != 'Flinch'       &&          // An attack being flinched shouldn't count as a miss
                    NextStateName != 'Parry'        &&          // A riposte which hit no pawns and was stopped with a parry shouldn't count as a miss
                    NextStateName != 'ParryRelease' &&          // ^
                    CurrentFireMode != Attack_Shove &&          // Kicks have a stamina cost regardless of hitting, so misses shouldn't be punished further
                    !AOCWepAttachment.bHitDestructibleObject    // Hitting objective material but no pawns shouldn't cost stamina
                ) {
                    MissCount++;
                    AOCOwner.RemoveDebuff(EDEBF_ATTACK);

                    StaminaLoss = GetStaminaLossForMiss();

                    AOCOwner.S_ConsumeStamina(StaminaLoss);
                    CurrentStamina -= StaminaLoss;
                }

                ComboHitCount = 0;
            }
        }
        else
        {
            if (!bHitPawn && bIsInCombo)
            {
                // Calculate stamina loss on server, if it hasn't been updated yet
                StaminaLoss = GetStaminaLossForMiss();

                CurrentStamina = min(CurrentStamina, BeginAttackStamina - StaminaLoss);
            }
        }

        AOCOwner.FinishSprintAttack();
        AOCWepAttachment.GotoState('');
        bParryHitCounter = false;
        
        // Deal with super.super
        //super.EndState(NextStateName);
        AOCOwner.FinishLunge();
        AOCOwner.ResetSprintSpeed();
        NumVerticalReversals = 0;
        NumHorizontalReversals = 0;

        // put weapon out of attack state
        AOCWepAttachment.bUseAlternativeTracers = false;

        // Check if we still have enough stamina to perform combo
        if (bIsInCombo && CurrentStamina - fComboMinimumStamina < 0)
        {
            GotoState('Recovery');
        }
    }

    simulated function HandleCombo(EAttack ComboAttack)
    {
        local bool bHasEnoughStamina;
        
        if (CurrentFireMode == Attack_Shove || CurrentFireMode == Attack_Parry || CurrentFireMode == Attack_Sprint || (CurrentFireMode == Attack_Stab && ComboAttack == Attack_Stab))
            return;

        if (!bCanCombo)
            return;

        if (ComboAttack == Attack_Parry)
            return;

        if (ComboAttack == Attack_AltOverhead)
            ComboAttack = Attack_Overhead;
        else if (ComboAttack == Attack_AltSlash)
            ComboAttack = Attack_Slash;

        if(ComboAttack == CurrentFireMode && iIdenticalCombo >= 3)
        {
            return;
        }

        if (bWasHit)
            return;

        // notify that we're in a combo now if we're not aborting the attack -- double check we're allowed to combo
        if (iComboCount < MaxComboCount)
        {
            bHasEnoughStamina = AOCPawn(Owner).HasEnoughStamina(fComboMinimumStamina);
            if (bHasEnoughStamina)
            {
                bIsInCombo = true;
                // record next attack
                eNextAttack = ComboAttack;

                AOCOwner.PlayerHUDStartCombo();
                
                if(iComboCount == 1)
                {
                    AOCOwner.OnComboStarted();
                }
            }
            else
            {
                bPlayNoComboGrunt = true;
            }
        }
        else
        {
            bIsInCombo = false;
        }
    }
}

simulated state AlternateRecovery
{
    simulated function HandleCombo(EAttack ComboAttack)
    {
        local bool bHasEnoughStamina;
        if (CurrentFireMode == Attack_Shove || CurrentFireMode == Attack_Parry || CurrentFireMode == Attack_Sprint || (CurrentFireMode == Attack_Stab && ComboAttack == Attack_Stab))
            return;

        if (!bCanCombo)
            return;

        if (ComboAttack == Attack_Parry)
            return;
            
        // notify that we're in a combo now if we're not aborting the attack -- double check we're allowed to combo
        if (iComboCount < MaxComboCount)
        {
            bHasEnoughStamina = AOCPawn(Owner).HasEnoughStamina(fComboMinimumStamina);
            if (bHasEnoughStamina)
            {
                bIsInCombo = true;
                // record next attack
                eNextAttack = ComboAttack;

                AOCOwner.PlayerHUDStartCombo();
            }
        }

        //not able to complete the combo...put the crosshair into a state of recovery
        if(eNextAttack != ComboAttack)
            AOCOwner.PlayerHUDStartRecovery();
    }
}

simulated state Active
{
    simulated event BeginState(Name PreviousStateName)
    {
        super.BeginState(PreviousStateName);
        
        // Reset riposte-parry variables
        bParryWasDuringRiposte = false;
        bFeintCostWasRefunded = false;
    }
}


simulated function float GetStaminaLossForMiss()
{
    return iFeintStaminaCost + fMissAdditionalStaminaCost;
}


DefaultProperties
{
    bRequiresComboAnimFix = false;

    fStaminaGainOnHit = 5.0;
    fStaminaGainOnRiposteParry = 20.0;
    fMissAdditionalStaminaCost = 10.0;
    fComboMinimumStamina = 1.0;

    bParryWasDuringRiposte = false;
    bFeintCostWasRefunded = false;

    bCanParry = true;
    bCanCombo = true;
    bJustPlayedCombo = false;
    bWantsToCombo = false
    bIsInCombo = false;
    iComboCount = 1;
    iIdenticalCombo = 1;
    ePreviousAttack = Attack_Null
    iParryCameFromTransition = -1

    FiringStatesArray(0)=Windup
    FiringStatesArray(1)=Windup
    FiringStatesArray(2)=Windup
    FiringStatesArray(3)=Windup
    FiringStatesArray(4)=Release
    FiringStatesArray(5)=Windup

    WeaponFireTypes(0)=EWFT_Custom
    WeaponFireTypes(1)=EWFT_Custom
    WeaponFireTypes(2)=EWFT_Custom
    WeaponFireTypes(3)=EWFT_Custom
    WeaponFireTypes(4)=EWFT_Custom
    WeaponFireTypes(5)=EWFT_Custom

    ShotCost(0)=0
    ShotCost(1)=0
    ShotCost(2)=0
    ShotCost(3)=0
    ShotCost(4)=0
    ShotCost(5)=0

    ImpactBloodTemplates(0)=ParticleSystem'CHV_PlayerParticles.Character.P_BloodSlash'
    ImpactBloodTemplates(1)=ParticleSystem'CHV_PlayerParticles.Character.P_BloodSlash'
    ImpactBloodTemplates(2)=ParticleSystem'CHV_PlayerParticles.Character.P_BloodSlash'

    BloodSprayTemplates(0)=ParticleSystem'CHV_PlayerParticles.Character.P_BloodSlash'
    BloodSprayTemplates(1)=ParticleSystem'CHV_PlayerParticles.Character.P_BloodSlash'
    BloodSprayTemplates(2)=ParticleSystem'CHV_PlayerParticles.Character.P_BloodSlash'

    AttackQueue=Attack_Null
    bAllowedToParry=true

    SprintAttackLunge=500.0f
    SprintAttackLungeZ=250.0f
    bAttachShieldDefault=true
    bParryAttackQueueNoMore=false
    TimeLeftInRelease=0.f
    TimeStartRelease=0.f
    bManualAllowQueue=false
    bAllowAttackOutOfShield=false
    bCanParryHitCounter=true

    PrimaryAttackCam=none
    SecondaryAttackCam=none
    TertiaryAttackCam=none
    ComboPrimaryAttackCam=none
    ComboSecondaryAttackCam=none
    ComboTertiaryAttackCAm=none

    PrimaryAttackCamWindup=none
    SecondaryAttackCamWindup=none
    TertiaryAttackCamWindup=none

    ComboPrimaryAttackCamWindup=none
    ComboSecondaryAttackCamWindup=none
    ComboTertiaryAttackCAmWindup=none

    bIgnoreAlternate=false
    bWasHit=false
    bPlayNoComboGrunt=false
    bCanPanicParry=false

    ComboToParryStaminaCost = 5
    ComboToParryBlendTime = 0.15f;
}