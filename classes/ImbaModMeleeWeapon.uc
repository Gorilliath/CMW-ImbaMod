class ImbaModMeleeWeapon extends AOCMeleeWeapon;


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
}

DefaultProperties
{
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