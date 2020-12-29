class ImbaModMeleeWeapon extends AOCMeleeWeapon;


var bool bRequiresComboAnimFix;


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
			}
		}
	}

	simulated event EndState(Name NextStateName)
	{
		super.EndState(NextStateName);
		AOCOwner.StateVariables.bIsParrying = false;
		AOCOwner.StateVariables.bIsActiveShielding = false;

		// Every parry invokes the global stamina regen cooldown
		AOCOwner.bRegenStamina = false;
		ClearTimer('ResumeOwnerStaminaRegen');
		SetTimer(ImbaModPawn(AOCOwner).fStaminaRegenCooldown, false, 'ResumeOwnerStaminaRegen');
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
}

simulated function float GetStaminaLossForMiss()
{
	return iFeintStaminaCost + 10;
}

// Only exists to allow timers to call the wrapped foreign function
simulated function ResumeOwnerStaminaRegen()
{
	AOCOwner.ResumeStaminaRegen();
}


DefaultProperties
{
	bRequiresComboAnimFix = false;

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