/**
* Copyright 2010-2012, Torn Banner Studios, All rights reserved
*
* Original Author: Michael Bao
*
* Weapon: Javelin (Throwing Mode)
*/

class CompModWeapon_JavelinThrow extends AOCWeapon_JavelinThrow;


DefaultProperties
{
	FiringStatesArray(3)= Windup
	ShotCost(3)=1

	CurrentWeaponType = EWEP_Javelin
	// set maximum ammo
	AmmoCount=8
	MaxAmmoCount=8
	AIRange=5000

	HorizontalRotateSpeed = 60000
	VerticalRotateSpeed = 50000

	WeaponProjectiles(0)=class'AOCProj_Javelin'
	WeaponProjectiles(3)=class'AOCProj_Javelin'

	AttachmentClass=class'CompModWeaponAttachment_JavelinThrow'
	// should never be part of inventory attachment
	InventoryAttachmentClass=class'AOCInventoryAttachment_Javelin'
	PermanentAttachmentClass(0)=class'AOCInventoryAttachment_JavelinQuiver'
	PermanentAttachmentClass(1)=class'AOCInventoryAttachment_JavelinQuiver'
	AllowedShieldClass=class'AOCShield_Buckler'
	bHaveShield=true

	ImpactBloodTemplates(0)=ParticleSystem'CHV_Particles_01.Player.Impact.P_1HSwordHit'
	ImpactBloodTemplates(1)=ParticleSystem'CHV_Particles_01.Player.Impact.P_1HSwordHit'
	ImpactBloodTemplates(2)=ParticleSystem'CHV_Particles_01.Player.Impact.P_1HSwordHit'

	BloodSprayTemplates(0)=ParticleSystem'CHV_Particles_01.Player.P_OnWeaponBlood'
	BloodSprayTemplates(1)=ParticleSystem'CHV_Particles_01.Player.P_OnWeaponBlood'
	BloodSprayTemplates(2)=ParticleSystem'CHV_Particles_01.Player.P_OnWeaponBlood'

	CurrentGenWeaponType=EWT_Javelin
	bRetIdle = false
	bRetIdleOriginal=false
	bPlayOnWeapon=false
	bEquipShield=false
	bCanParry=False
	bCanSwitchShield=false
	bUseDirParryHitAnims=true

	WeaponIdentifier="javelin"

	ProjectileSpawnLocation=ProjJavelinPoint

	ImpactSounds(ESWINGSOUND_Stab)={(
		light=SoundCue'A_Impacts_Melee.Light_stab_Average',
		medium=SoundCue'A_Impacts_Melee.Medium_stab_Average',
		heavy=SoundCue'A_Impacts_Melee.Heavy_stab_small',
		wood=SoundCue'A_Phys_Mat_Impacts.Dagesse_Wood',
		mud=SoundCue'A_Phys_Mat_Impacts.Dagesse_Dirt',
		foliage=SoundCue'A_Phys_Mat_Impacts.Dagesse_Dirt',
		dirt=SoundCue'A_Phys_Mat_Impacts.Dagesse_Dirt',
		metal=SoundCue'A_Phys_Mat_Impacts.Dagesse_metal',
		stone=SoundCue'A_Phys_Mat_Impacts.Dagesse_Stone')}

	ImpactSounds(ESWINGSOUND_Shove)={(
		light=SoundCue'A_Impacts_Melee.Light_Kick_Small',
		medium=SoundCue'A_Impacts_Melee.Medium_Kick_Small',
		heavy=SoundCue'A_Impacts_Melee.Heavy_Kick_Small',
		wood=SoundCue'A_Phys_Mat_Impacts.Kick_Wood',
		dirt=SoundCue'A_Phys_Mat_Impacts.Kick_Dirt',
		metal=SoundCue'A_Phys_Mat_Impacts.Kick_Metal',
		stone=SoundCue'A_Phys_Mat_Impacts.Kick_Stone')}

	ImpactSounds(ESWINGSOUND_Overhead)={(
		light=SoundCue'A_Impacts_Melee.Light_Blunt_Average',
		medium=SoundCue'A_Impacts_Melee.Medium_Blunt_Average',
		heavy=SoundCue'A_Impacts_Melee.Heavy_Blunt_Average',
		wood=SoundCue'A_Phys_Mat_Impacts.Dagesse_Wood',
		mud=SoundCue'A_Phys_Mat_Impacts.Dagesse_Dirt',
		foliage=SoundCue'A_Phys_Mat_Impacts.Dagesse_Dirt',
		dirt=SoundCue'A_Phys_Mat_Impacts.Dagesse_Dirt',
		metal=SoundCue'A_Phys_Mat_Impacts.Dagesse_metal',
		stone=SoundCue'A_Phys_Mat_Impacts.Dagesse_Stone')}

	ParriedSound=SoundCue'A_Phys_Mat_Impacts.Broaddagger_Blocked'
	ParrySound=SoundCue'A_Phys_Mat_Impacts.Buckler_Blocking'

	StrafeModify=0.75f
	bCanDodge=false
	bUseIdleForTopHalf=true
	AlternativeMode=class'CompModWeapon_JavelinMelee'
	bAlternativeFireStopped=false
	bHasFired=false
	bIgnoreShieldReplacement=true
	bIsReadyToSwitch = false
	bCanPickupStickies = true

	/*
	 * Formerly in UDKNewWeapon.ini - [AOC.AOCWeapon_JavelinThrow]
	 */
	ConfigProjectileBaseDamage[0]=(Damage=0,InitialSpeed=0,MaxSpeed=0,AmmoCount=0,InitialGravityScale=0,Drag=0,PitchCorrection=0.0)
	ConfigProjectileBaseDamage[1]=(Damage=0,InitialSpeed=0,MaxSpeed=0,AmmoCount=0,InitialGravityScale=0,Drag=0,PitchCorrection=0.0)
	ConfigProjectileBaseDamage[2]=(Damage=0,InitialSpeed=0,MaxSpeed=0,AmmoCount=0,InitialGravityScale=0,Drag=0,PitchCorrection=0.0)
	ConfigProjectileBaseDamage[3]=(Damage=0,InitialSpeed=0,MaxSpeed=0,AmmoCount=0,InitialGravityScale=0,Drag=0,PitchCorrection=0.0)
	ConfigProjectileBaseDamage[4]=(Damage=70,InitialSpeed=2700.0,MaxSpeed=3200.0,AmmoCount=5,InitialGravityScale=0.8,Drag=0.000003,PitchCorrection=0)
	ConfigProjectileBaseDamage[5]=(Damage=0,InitialSpeed=0,MaxSpeed=0,AmmoCount=0,InitialGravityScale=0,Drag=0,PitchCorrection=0.0)
	iFeintStaminaCost=0
	WeaponFontSymbol="z"
	WeaponReach=100
	SprintAttackSpeedBonus=1.2
	SprintAttackDamageBonus=20
	WeaponLargePortrait="UI_WeaponImages_SWF.weapon_select_javelin"
	WeaponSmallPortrait="UI_WeaponImages_SWF.icon_weapon_select_javelin_png"
	HorizontalRotateSpeed=75000.0
	VerticalRotateSpeed=65000.0
	AttackHorizRotateSpeed=75000.0
	SprintAttackHorizRotateSpeed=20000.0
	SprintAttackVerticalRotateSpeed=20000.0
	BattleCryAnim=(AnimationName=3p_javelin_battlecry,ComboAnimation=,AssociatedSoundCue=,bFullBody=true,bCombo=false,bLoop=false,bForce=false,UniqueShieldSound=none,fModifiedMovement=0.0,fAnimationLength=0.0,fBlendInTime=0.00,fBlendOutTime=0.00,bLastAnimation=true)
	WindupAnimations(0)=(AnimationName=3p_javelin_throwwindup,ComboAnimation=,AssociatedSoundCue=SoundCue'A_Combat_Locomotion.Jav_Reload',bFullBody=False,bCombo=False,bLoop=False,bForce=false,fModifiedMovement=1.0,fAnimationLength=0.6,fBlendInTime=0.10,fBlendOutTime=0.10,bLastAnimation=false)
	WindupAnimations(1)=(AnimationName=,ComboAnimation=,AssociatedSoundCue=SoundCue'A_Combat_Locomotion.Jav_Reload',bFullBody=False,bCombo=False,bLoop=False,bForce=false,fModifiedMovement=0.0,fAnimationLength=0.3,fBlendInTime=0.00,fBlendOutTime=0.00,bLastAnimation=false)
	WindupAnimations(2)=(AnimationName=,ComboAnimation=,AssociatedSoundCue=SoundCue'A_Combat_Locomotion.Jav_Reload',bFullBody=False,bCombo=False,bLoop=False,bForce=false,fModifiedMovement=0.7,fAnimationLength=0.0,fBlendInTime=0.00,fBlendOutTime=0.00,bLastAnimation=false)
	WindupAnimations(3)=(AnimationName=3p_javelin_sprintthrowstart,ComboAnimation=,AssociatedSoundCue=SoundCue'A_Footsteps.Archer_Dirt_Jump',bFullBody=True,bCombo=False,bLoop=False,bForce=false,UniqueShieldSound=none,fModifiedMovement=1.0,fAnimationLength=0.0,fBlendInTime=0.00,fBlendOutTime=0.00,bLastAnimation=false)
	WindupAnimations(4)=(AnimationName=3p_javelin_parryib,ComboAnimation=,AssociatedSoundCue=SoundCue'A_Combat_Locomotion.warhammer_Parry',bFullBody=False,bCombo=False,bLoop=False,bForce=false,fModifiedMovement=1.0,fAnimationLength=0.125,fBlendInTime=0.00,fBlendOutTime=0.00,bLastAnimation=false)
	WindupAnimations(5)=(AnimationName=3p_javelin_shovestart,ComboAnimation=,AssociatedSoundCue=SoundCue'A_Combat_Locomotion.warhammer_windup',bFullBody=True,bCombo=False,bLoop=False,UniqueShieldSound=none,fModifiedMovement=1.0,fAnimationLength=0.3,fBlendInTime=0.00,fBlendOutTime=0.00,bLastAnimation=false)
	ReleaseAnimations(0)=(AnimationName=3p_javelin_throwrelease,ComboAnimation=3p_1hsharp_slash011release,AssociatedSoundCue=SoundCue'A_Combat_Locomotion.jav_attack_01',bFullBody=false,bCombo=False,bLoop=False,bForce=false,UniqueShieldSound=none,fModifiedMovement=0.6,fAnimationLength=0.25,fBlendInTime=0.05,fBlendOutTime=0.1,bLastAnimation=false,bAttachArrow=2)
	ReleaseAnimations(1)=(AnimationName=3p_javelin_swingrelease,ComboAnimation=3p_1hsharp_slash021release,AssociatedSoundCue=SoundCue'A_Combat_Locomotion.jav_Attack_02',bFullBody=true,bCombo=False,bLoop=False,bForce=false,UniqueShieldSound=none,fModifiedMovement=0.0,fAnimationLength=0.0,fBlendInTime=0.00,fBlendOutTime=0.00,bLastAnimation=false)
	ReleaseAnimations(2)=(AnimationName=3p_javelin_stabrelease,ComboAnimation=3p_1hsharp_stabrelease,AssociatedSoundCue=SoundCue'A_Combat_Locomotion.jav_Attack_03',bFullBody=true,bCombo=False,bLoop=False,bForce=false,UniqueShieldSound=none,fModifiedMovement=1.0,fAnimationLength=0.0,fBlendInTime=0.00,fBlendOutTime=0.00,bLastAnimation=false)
	ReleaseAnimations(3)=(AnimationName=3p_javelin_sprintthrowrelease,ComboAnimation=,AssociatedSoundCue=SoundCue'A_Combat_Locomotion.jav_sprint_attack',bFullBody=True,bCombo=False,bLoop=False,bForce=false,UniqueShieldSound=none,fModifiedMovement=1.0,fAnimationLength=0.0,fBlendInTime=0.00,fBlendOutTime=0.00,bLastAnimation=false)
	ReleaseAnimations(4)=(AnimationName=3p_javelin_parryup,ComboAnimation=,AssociatedSoundCue=SoundCue'A_Combat_Locomotion.jav_Parry',bFullBody=False,bCombo=False,bLoop=True,bForce=false,UniqueShieldSound=none,fModifiedMovement=1.0,fAnimationLength=0.0,fBlendInTime=0.00,fBlendOutTime=0.00,bLastAnimation=false)
	ReleaseAnimations(5)=(AnimationName=3p_javelin_shoverelease_new,ComboAnimation=,AssociatedSoundCue=,bFullBody=True,bCombo=False,bLoop=False,bForce=false,UniqueShieldSound=none,fModifiedMovement=0.0,fAnimationLength=0.2,fBlendInTime=0.00,fBlendOutTime=0.00,bLastAnimation=false,bUseRMM=true)
	ReleaseAnimations(6)=(AnimationName=,ComboAnimation=,AssociatedSoundCue=,bFullBody=false,bCombo=false,bLoop=false,bForce=false,UniqueShieldSound=none,fModifiedMovement=1.0,fAnimationLength=0.0,fBlendInTime=0.00,fBlendOutTime=0.00,bLastAnimation=false)
	ReleaseAnimations(7)=(AnimationName=,ComboAnimation=,AssociatedSoundCue=,bFullBody=false,bCombo=false,bLoop=false,bForce=false,UniqueShieldSound=none,fModifiedMovement=1.0,fAnimationLength=0.0,fBlendInTime=0.00,fBlendOutTime=0.00,bLastAnimation=false)
	ReleaseAnimations(8)=(AnimationName=3p_javelin_equipup,ComboAnimation=,AssociatedSoundCue=SoundCue'A_Combat_Locomotion.jav_draw',bFullBody=false,bCombo=false,bLoop=false,bForce=false,UniqueShieldSound=none,fModifiedMovement=1.0,fAnimationLength=0.3,fBlendInTime=0.00,fBlendOutTime=0.01,bLastAnimation=false)
	ReleaseAnimations(9)=(AnimationName=3p_javelin_equipdown,ComboAnimation=,AssociatedSoundCue=SoundCue'A_Combat_Locomotion.jav_sheath',bFullBody=false,bCombo=false,bLoop=false,bForce=false,UniqueShieldSound=none,fModifiedMovement=1.0,fAnimationLength=0.5,fBlendInTime=0.00,fBlendOutTime=0.01,bLastAnimation=false)
	RecoveryAnimations(0)=(AnimationName=3p_javelin_throwrecover,ComboAnimation=,AssociatedSoundCue=,bFullBody=false,bCombo=false,bLoop=false,bForce=false,UniqueShieldSound=none,fModifiedMovement=1.0,fAnimationLength=0.3,fBlendInTime=0.00,fBlendOutTime=0.0,bLastAnimation=true)
	RecoveryAnimations(1)=(AnimationName=3p_javelin_swingrecover,ComboAnimation=,AssociatedSoundCue=,bFullBody=false,bCombo=false,bLoop=false,bForce=false,UniqueShieldSound=none,fModifiedMovement=1.0,fAnimationLength=0.0,fBlendInTime=0.00,fBlendOutTime=0.0,bLastAnimation=true)
	RecoveryAnimations(2)=(AnimationName=3p_javelin_stabrecover,ComboAnimation=3p_1hsharp_stabrecover,AssociatedSoundCue=,bFullBody=false,bCombo=false,bLoop=false,bForce=false,UniqueShieldSound=none,fModifiedMovement=1.0,fAnimationLength=0.0,fBlendInTime=0.00,fBlendOutTime=0.0,bLastAnimation=true)
	RecoveryAnimations(3)=(AnimationName=3p_javelin_sprintthrowrecover,ComboAnimation=,AssociatedSoundCue=,bFullBody=true,bCombo=false,bLoop=false,bForce=false,UniqueShieldSound=none,fModifiedMovement=1.0,fAnimationLength=0.0,fBlendInTime=0.00,fBlendOutTime=0.0,bLastAnimation=true)
	RecoveryAnimations(4)=(AnimationName=3p_javelin_parryrecover,ComboAnimation=,AssociatedSoundCue=,bFullBody=false,bCombo=false,bLoop=false,bForce=false,UniqueShieldSound=none,fModifiedMovement=1.0,fAnimationLength=0.5,fBlendInTime=0.00,fBlendOutTime=0.0,bLastAnimation=true)
	RecoveryAnimations(5)=(AnimationName=3p_javelin_shoverecover,ComboAnimation=,AssociatedSoundCue=,bFullBody=false,bCombo=false,bLoop=false,bForce=false,UniqueShieldSound=none,fModifiedMovement=1.0,fAnimationLength=0.5,fBlendInTime=0.10,fBlendOutTime=0.0,bLastAnimation=true)
	RecoveryAnimations(6)=(AnimationName=,ComboAnimation=,AssociatedSoundCue=,bFullBody=false,bCombo=false,bLoop=false,bForce=false,UniqueShieldSound=none,fModifiedMovement=1.0,fAnimationLength=0.0,fBlendInTime=0.00,fBlendOutTime=0.0,bLastAnimation=true)
	RecoveryAnimations(7)=(AnimationName=,ComboAnimation=,AssociatedSoundCue=,bFullBody=false,bCombo=false,bLoop=false,bForce=false,UniqueShieldSound=none,fModifiedMovement=1.0,fAnimationLength=0.0,fBlendInTime=0.00,fBlendOutTime=0.0,bLastAnimation=true)
	RecoveryAnimations(8)=(AnimationName=,ComboAnimation=,AssociatedSoundCue=,bFullBody=false,bCombo=false,bLoop=false,bForce=false,UniqueShieldSound=none,fModifiedMovement=1.0,fAnimationLength=0.0,fBlendInTime=0.00,fBlendOutTime=0.0,bLastAnimation=true)
	RecoveryAnimations(9)=(AnimationName=,ComboAnimation=,AssociatedSoundCue=,bFullBody=false,bCombo=false,bLoop=false,bForce=false,UniqueShieldSound=none,fModifiedMovement=1.0,fAnimationLength=0.0,fBlendInTime=0.00,fBlendOutTime=0.0,bLastAnimation=true)
	ReloadAnimations[0]=(AnimationName=3p_javelin_throwreload,ComboAnimation=,AssociatedSoundCue=,bFullBody=false,bCombo=false,bLoop=false,bForce=false,fModifiedMovement=0.7,fAnimationLength=0.60,fBlendInTime=0.0,fBlendOutTime=0.1,bLastAnimation=false,bAttachArrow=2)
	ReloadAnimations[1]=(AnimationName=3p_javelin_throwreload,ComboAnimation=,AssociatedSoundCue=,bFullBody=false,bCombo=false,bLoop=false,bForce=false,fModifiedMovement=1.0,fAnimationLength=.60,fBlendInTime=0.0,fBlendOutTime=0.1,bLastAnimation=false,bAttachArrow=1)
	ReloadAnimations[2]=(AnimationName=3p_javelin_throwreload,ComboAnimation=,AssociatedSoundCue=,bFullBody=false,bCombo=false,bLoop=false,bForce=false,fModifiedMovement=1.0,fAnimationLength=0.60,fBlendInTime=0.0,fBlendOutTime=0.1,bLastAnimation=false,bAttachArrow=1)
	ReloadAnimations[3]=(AnimationName=3p_javelin_throwreload,ComboAnimation=,AssociatedSoundCue=,bFullBody=false,bCombo=false,bLoop=false,bForce=false,fModifiedMovement=1.0,fAnimationLength=0.60,fBlendInTime=0.0,fBlendOutTime=0.1,bLastAnimation=false,bAttachArrow=1)
	HoldAnimations[0]=(AnimationName=3p_javelin_throwwindupidle,ComboAnimation=,AssociatedSoundCue=,bFullBody=False,bCombo=False,bLoop=True,bForce=false,UniqueShieldSound=none,fModifiedMovement=1.0,fAnimationLength=0.0,fBlendInTime=0.00,fBlendOutTime=0.00,bLastAnimation=false)
	HoldAnimations[1]=(AnimationName=3p_javelin_throwwindupidle,ComboAnimation=,AssociatedSoundCue=,bFullBody=False,bCombo=False,bLoop=True,bForce=false,UniqueShieldSound=none,fModifiedMovement=1.0,fAnimationLength=0.0,fBlendInTime=0.00,fBlendOutTime=0.00,bLastAnimation=false)
	StateAnimations(0)=(AnimationName=3p_javelin_parried,ComboAnimation=,AssociatedSoundCue=,bFullBody=false,bCombo=false,bLoop=false,bForce=false,UniqueShieldSound=none,fModifiedMovement=1.0,fAnimationLength=1.00,fBlendInTime=0.00,fBlendOutTime=0.08,bLastAnimation=true)
	StateAnimations(1)=(AnimationName=3p_javelin_dazed,ComboAnimation=,AssociatedSoundCue=,bFullBody=false,bCombo=false,bLoop=false,bForce=false,UniqueShieldSound=none,fModifiedMovement=1.0,fAnimationLength=0.2,fBlendInTime=0.00,fBlendOutTime=0.00,bLastAnimation=true)
	StateAnimations(2)=(AnimationName=3p_javelin_dazed,ComboAnimation=,AssociatedSoundCue=,bFullBody=false,bCombo=false,bLoop=false,bForce=false,UniqueShieldSound=none,fModifiedMovement=1.0,fAnimationLength=0.9,fBlendInTime=0.00,fBlendOutTime=0.00,bLastAnimation=true)
	StateAnimations(3)=(AnimationName=3p_javelin_hitFR,ComboAnimation=,AssociatedSoundCue=,bFullBody=false,bCombo=false,bLoop=false,bForce=false,UniqueShieldSound=none,fModifiedMovement=1.0,fAnimationLength=0.9,fBlendInTime=0.00,fBlendOutTime=0.00,bLastAnimation=true)
	StateAnimations(4)=(AnimationName=3p_javelin_hitBL,ComboAnimation=,AssociatedSoundCue=,bFullBody=false,bCombo=false,bLoop=false,bForce=false,UniqueShieldSound=none,fModifiedMovement=1.0,fAnimationLength=0.4,fBlendInTime=0.00,fBlendOutTime=0.08,bLastAnimation=false)
	TurnInfo(0)=(AnimationName=3p_javelin_turnL,ComboAnimation=,AssociatedSoundCue=,bFullBody=true,bCombo=false,bLoop=true,bForce=false,UniqueShieldSound=none,fModifiedMovement=1.0,fAnimationLength=0.0,fBlendInTime=0.00,fBlendOutTime=0.0,bLastAnimation=false,bLowerBody=true)
	TurnInfo(1)=(AnimationName=3p_javelin_turnR,ComboAnimation=,AssociatedSoundCue=,bFullBody=true,bCombo=false,bLoop=true,bForce=false,UniqueShieldSound=none,fModifiedMovement=1.0,fAnimationLength=0.0,fBlendInTime=0.00,fBlendOutTime=0.0,bLastAnimation=false)
	SwapToAnimation=(AnimationName=3p_javelin_stabtothrow,ComboAnimation=,AssociatedSoundCue=SoundCue'A_Combat_Locomotion.jav_draw',bFullBody=false,bCombo=false,bLoop=false,bForce=false,UniqueShieldSound=none,fModifiedMovement=1.0,fAnimationLength=0.40,fBlendInTime=0.10,fBlendOutTime=0.01,bLastAnimation=false)
	DazedAnimations(0)=(AnimationName=3p_javelin_dazedB01,ComboAnimation=,AssociatedSoundCue=,bFullBody=false,bCombo=false,bLoop=false,bForce=false,UniqueShieldSound=none,fModifiedMovement=1.0,fAnimationLength=1.1,fBlendInTime=0.00,fBlendOutTime=0.00,bLastAnimation=true)
	DazedAnimations(1)=(AnimationName=3p_javelin_dazedR01,ComboAnimation=,AssociatedSoundCue=,bFullBody=false,bCombo=false,bLoop=false,bForce=false,UniqueShieldSound=none,fModifiedMovement=1.0,fAnimationLength=1.1,fBlendInTime=0.00,fBlendOutTime=0.00,bLastAnimation=true)
	DazedAnimations(2)=(AnimationName=3p_javelin_dazedF01,AlternateAnimation=3p_javelin_parrydazed,ComboAnimation=,AssociatedSoundCue=,bFullBody=false,bCombo=false,bLoop=false,bForce=false,UniqueShieldSound=none,fModifiedMovement=1.0,fAnimationLength=1.1,fBlendInTime=0.00,fBlendOutTime=0.00,bLastAnimation=true)
	DazedAnimations(3)=(AnimationName=3p_javelin_dazedL01,ComboAnimation=,AssociatedSoundCue=,bFullBody=false,bCombo=false,bLoop=false,bForce=false,UniqueShieldSound=none,fModifiedMovement=1.0,fAnimationLength=1.1,fBlendInTime=0.00,fBlendOutTime=0.00,bLastAnimation=true)
	DazedAnimations(4)=(AnimationName=3p_javelin_dazedBL,ComboAnimation=,AssociatedSoundCue=,bFullBody=false,bCombo=false,bLoop=false,bForce=false,UniqueShieldSound=none,fModifiedMovement=1.0,fAnimationLength=1.1,fBlendInTime=0.00,fBlendOutTime=0.00,bLastAnimation=true)
	DazedAnimations(5)=(AnimationName=3p_javelin_dazedBR,ComboAnimation=,AssociatedSoundCue=,bFullBody=false,bCombo=false,bLoop=false,bForce=false,UniqueShieldSound=none,fModifiedMovement=1.0,fAnimationLength=1.1,fBlendInTime=0.00,fBlendOutTime=0.00,bLastAnimation=true)
	DazedAnimations(6)=(AnimationName=3p_javelin_dazedFL,ComboAnimation=,AssociatedSoundCue=,bFullBody=false,bCombo=false,bLoop=false,bForce=false,UniqueShieldSound=none,fModifiedMovement=1.0,fAnimationLength=1.1,fBlendInTime=0.00,fBlendOutTime=0.00,bLastAnimation=true)
	DazedAnimations(7)=(AnimationName=3p_javelin_dazedFR,ComboAnimation=,AssociatedSoundCue=,bFullBody=false,bCombo=false,bLoop=false,bForce=false,UniqueShieldSound=none,fModifiedMovement=1.0,fAnimationLength=1.1,fBlendInTime=0.00,fBlendOutTime=0.00,bLastAnimation=true)
	DirHitAnimation(0)=(AnimationName=ADD_3p_javelin_hitFL,ComboAnimation=,AssociatedSoundCue=,bFullBody=false,bCombo=false,bLoop=false,bForce=false,UniqueShieldSound=none,fModifiedMovement=1.0,fAnimationLength=0.4,fBlendInTime=0.00,fBlendOutTime=0.1,bLastAnimation=false,bUseSlotSystem=true)
	DirHitAnimation(1)=(AnimationName=ADD_3p_javelin_hitFR,ComboAnimation=,AssociatedSoundCue=,bFullBody=false,bCombo=false,bLoop=false,bForce=false,UniqueShieldSound=none,fModifiedMovement=1.0,fAnimationLength=0.4,fBlendInTime=0.00,fBlendOutTime=0.1,bLastAnimation=false,bUseSlotSystem=true)
	DirHitAnimation(2)=(AnimationName=ADD_3p_javelin_hitBL,ComboAnimation=,AssociatedSoundCue=,bFullBody=false,bCombo=false,bLoop=false,bForce=false,UniqueShieldSound=none,fModifiedMovement=1.0,fAnimationLength=0.4,fBlendInTime=0.00,fBlendOutTime=0.1,bLastAnimation=false,bUseSlotSystem=true)
	DirHitAnimation(3)=(AnimationName=ADD_3p_javelin_hitBR,ComboAnimation=,AssociatedSoundCue=,bFullBody=false,bCombo=false,bLoop=false,bForce=false,UniqueShieldSound=none,fModifiedMovement=1.0,fAnimationLength=0.4,fBlendInTime=0.00,fBlendOutTime=0.1,bLastAnimation=false,bUseSlotSystem=true)
	DirParryHitAnimations(0)=(AnimationName=3p_javelin_parried,ComboAnimation=,AssociatedSoundCue=,bFullBody=false,bCombo=false,bLoop=false,bForce=false,UniqueShieldSound=none,fModifiedMovement=1.0,fAnimationLength=0.2,fBlendInTime=0.00,fBlendOutTime=0.00,bLastAnimation=true,bUseAltNode=true)
	DirParryHitAnimations(1)=(AnimationName=3p_javelin_parried,ComboAnimation=,AssociatedSoundCue=,bFullBody=false,bCombo=false,bLoop=false,bForce=false,UniqueShieldSound=none,fModifiedMovement=1.0,fAnimationLength=0.2,fBlendInTime=0.00,fBlendOutTime=0.00,bLastAnimation=true,bUseAltNode=true)
	DirParryHitAnimations(2)=(AnimationName=3p_javelin_parried,ComboAnimation=,AssociatedSoundCue=,bFullBody=false,bCombo=false,bLoop=false,bForce=false,UniqueShieldSound=none,fModifiedMovement=1.0,fAnimationLength=0.2,fBlendInTime=0.00,fBlendOutTime=0.00,bLastAnimation=true,bUseAltNode=true)
	DirParryHitAnimations(3)=(AnimationName=3p_javelin_parried,ComboAnimation=,AssociatedSoundCue=,bFullBody=false,bCombo=false,bLoop=false,bForce=false,UniqueShieldSound=none,fModifiedMovement=1.0,fAnimationLength=0.2,fBlendInTime=0.00,fBlendOutTime=0.00,bLastAnimation=true,bUseAltNode=true)
	// Range Weapon ConfigProjectileBaseDamage Info
	// 0 - Bodkin
	// 1 - Broadhead
	// 2 - Fire
	// 3 - Steel
	// 4 - Javelin
	// 5 - Default
	// NOTE: Javelin sprint damage bonus found in DefaultWeapon.ini
	// The ones that aren't used shouldn't need to be set but I do it just to be safe.
}
