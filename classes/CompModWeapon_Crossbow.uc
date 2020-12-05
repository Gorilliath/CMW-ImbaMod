/**
* Copyright 2010-2012, Torn Banner Studios, All rights reserved
*
* Original Author: Michael Bao
*
* Crossbow.
*/
class CompModWeapon_Crossbow extends CompModRangeWeapon;

/** Whether or not we're currently aiming so we can get out of it if necessary */
var bool bAiming;
var bool bGoBackToHold;

simulated function Fire()
{
	super.Fire();
	MakeNoise(1.0);
}

simulated state WeaponEquipping
{
	simulated function ActivateReload()
	{
	}

	reliable server function ServerActivateReload()
	{
	}
}

simulated state WeaponPuttingDown
{
	simulated function ActivateReload()
	{
	}

	reliable server function ServerActivateReload()
	{
	}
}

function int AddAmmo( int Amount )
{
	local int ret;
	ret =  super(AOCWeapon).AddAmmo(Amount);
	if (WorldInfo.NetMode == NM_STANDALONE || (Worldinfo.NetMode == NM_ListenServer && AOCOwner.IsLocallyControlled()))
		NotifyAmmoConsume();

	if (ret == 0)
	{
//		bLoaded = false;
		AOCWepAttachment.bHasAmmo = false;
		AOCowner.bWeaponHasAmmoLeft = false;
	}
	else if (Amount > 0)
	{
		AOCPlayerController(AOCOwner.Controller).NotifyPickupAmmo(Amount);
//		bLoaded = true;
		//AOCWepAttachment.bHasAmmo = true;
		//AOCOWner.bWeaponHasAmmoLeft = true;
	}

	return ret;
}



/** No windup state so proceed directly to fire */
/** Windup state. Getting ready to fire.
 *  Go into hold if necessary.
 */
simulated state Windup
{
	/** When finished with windup go to the next state */
	simulated function OnStateAnimationEnd()
	{
		GotoState('Release');
	}

	/** Play appropriate reload animation animation
	 *  No reload animation
	 */
	simulated event BeginState(Name PreviousStateName)
	{
		OnStateAnimationEnd();
	}
}

/** Default Active/Idle state.
 */
simulated state Active
{
	/** Initialize the weapon as being active and ready to go. */
	simulated event BeginState(Name PreviousStateName)
	{
		super.BeginState(PreviousStateName);
		bAiming=false;
		AOCOwner.ResetFOV();
	}
}

/** Release state. User releasing weapon. Ranged weapon firing state.
 */
simulated state Release
{
	/** Play appropriate attack animation */
	simulated event BeginState(Name PreviousStateName)
	{

		if (bAiming)
		{
			ReleaseProjectileTime = WorldInfo.TimeSeconds;
			AOCWepAttachment.bHasAmmo = false;
			AOCOwner.bWeaponHasAmmoLeft = false;
			super.BeginState(PreviousStateName);
		}
		else
			GotoState(PreviousStateName);
	}

	/** When finished with release go to the next state */
	simulated function OnStateAnimationEnd()
	{
		GotoState('Hold');
	}
}

simulated function ForceOutOfReloadSwitch()
{
}

/** Reload state.
 *  Make sure that we aren't able to look around while performing reload.
 */
simulated state Reload
{
	simulated event EndState(Name NextStateName)
	{
		AOCPlayerController(AOCOwner.Controller).bForceIgnoreRotation = false;
		AOCOwner.bForceNullUpDownAim = false;
		super.EndState(NextStateName);
	}

	/** Play appropriate reload animation animation */
	simulated event BeginState(Name PreviousStateName)
	{
		super.BeginState(PreviousStateName);
		AOCOwner.bForceNullUpDownAim = true;
		AOCOwner.StateVariables.bCanDodge = false;
		AOCOwner.StateVariables.bCanJump = false;
		AOCOwner.StateVariables.bCanSprint = false;
		AOCOwner.DisableSprint();

		// NO ROTATION
		AOCPlayerController(AOCOwner.Controller).bForceIgnoreRotation = true;

		if (PreviousStateName == 'Hold')
			bGoBackToHold = true;
		else
			bGoBackToHold = false;
	}

	/** Play recovery animation */
	simulated function PlayStateAnimation()
	{
		local AnimationInfo AnimInfo;
		AnimInfo = ReloadAnimations[0];
		AnimInfo.fBlendOutTime = 0.5f;
		AOCOwner.ReplicateCompressedAnimation(AnimInfo, EWST_Reload, 0);
	}

	/** Cancel Reload */
	simulated function DoFeintAttack()
	{
		// TODO: Stop all animation
		AOCOwner.RemoveDebuff(EDEBF_ANIMATION);
		GotoState('Active');
	}

	simulated function OnStateAnimationEnd()
	{
		if (AmmoCount > 0)
		{
			bLoaded = true;
			AOCWepAttachment.bHasAmmo = true;
			AOCOwner.bWeaponHasAmmoLeft = true;
		}
		else
			AOCWeaponAttachment(AOCOwner.CurrentWeaponAttachment).DetachArrow();

		if (!bGoBackToHold)
			GotoState('Active');
		else
			GotoState('IronSightWindup');
	}
}

simulated state Flinch
{
	/** When finished with flinch go to the next state */
	simulated function OnStateAnimationEnd()
	{
		GotoState('Active');
	}
}

/** IronSight state.
 *  Allows user to aim. Plays animation.
 */
simulated state IronSightWindup
{
	simulated function ActivateHitAnim(EDirection Direction, bool bSameTeam)
	{
		CancelRangedAttack();
		super.ActivateHitAnim(Direction, bSameTeam);
	}

	/** Play Windup animation */
	simulated function PlayStateAnimation()
	{
		AOCOwner.ReplicateCompressedAnimation(WindupAnimations[CurrentFireMode], EWST_Windup, CurrentFireMode);
	}

	/** When finished with windup go to the next state */
	simulated function OnStateAnimationEnd()
	{
		GotoState('Hold');
	}

	/** Play appropriate attack animation */
	simulated event BeginState(Name PreviousStateName)
	{
		CurrentAnimations = WindupAnimations;

		AOCOwner.ToggleSprint(false);

		CurrentFireMode = Attack_Slash;
		// change state variables here
		//AOCOwner.StateVariables.bCanJump = false;
		AOCOwner.StateVariables.bIsAttacking = true;
		AOCOwner.StateVariables.bCanSprint = false;
		// make sure user loses stamina if he attacks after he spawns
		AOCOwner.bSprintConsumeStamina = true;

		bAiming = true;

		PlayStateAnimation();
	}

	/** Cancel windup */
	simulated function BeginFire(byte FireModeNum)
	{
		if (EAttack(FireModeNum) == Attack_Parry)
		{
			CurrentFireMode = Attack_Slash;
			bAiming = false;
			bRetIdle = true;
			GotoState('Recovery');
		}
	}
}

/** Introduce the hold state which may be used by a ranged weapon to wait for the optimal time to release.
 */
simulated state Hold
{
	/** Play appropriate attack animation */
	simulated event BeginState(Name PreviousStateName)
	{
		CurrentFireMode = Attack_Slash;
		PlayStateAnimation();
		//ZoomIn();

		if (AmmoCount == 0)
			SwitchWeaponNoAmmo();
	}

	/** If we decide to do an attack during the release animation, perform a combo - a parry or shield raise will end the combo */
	simulated function BeginFire(byte FireModeNum)
	{
		if (EAttack(FireModeNum) == Attack_Overhead || EAttack(FireModeNum) == Attack_Parry)
		{
			CurrentFireMode = Attack_Slash;
			bAiming = false;
			CompleteState(true);
		}
	}

	/** Play hold idle animation */
	simulated function PlayStateAnimation()
	{
		AOCOwner.ReplicateCompressedAnimation(HoldAnimations[CurrentFireMode], EWST_Hold, CurrentFireMode);
	}

	/** Release weapon back into idle. */
	simulated function ReleaseWeapon()
	{
	}

	/** The user released the mouse button and we should fire */
	simulated function EndFire(byte FireModeNum)
	{
		if (bLoaded && EAttack(FireModeNum) == Attack_Slash)
		{
			super.EndFire(FireModeNum);
		}
		else if (!bLoaded && EAttack(FireModeNum) == Attack_Slash)
		{
			CurrentFireMode = Attack_Slash;
			bAiming = false;
			CompleteState(true);
		}
	}
	simulated event EndState(Name NextStateName)
	{
		// TODO: Stop all animation
		// zoom out just in case
		//ZoomOut();
		AOCOwner.StateVariables.bIsAttacking = false;
		AOCOwner.RemoveDebuff(EDEBF_ANIMATION);

		super.EndState(NextStateName);
	}

	simulated function ZoomOut()
	{
		if (PlayerController(AOCOwner.Controller) != none)
			PlayerController(AOCOwner.Controller).DesiredFOV = PlayerController(AOCOwner.Controller).DefaultFOV;
	}

	simulated function ZoomIn()
	{
		if (PlayerController(AOCOwner.Controller) != none && bLoaded)
		{
			if (PlayerController(AOCOwner.Controller).DesiredFOV == PlayerController(AOCOwner.Controller).DefaultFOV)
				PlayerController(AOCOwner.Controller).DesiredFOV *= 70.0f/95.f;
			AOCOwner.OnActionSucceeded(EACT_Focus);
		}
		else
		{
			CurrentFireMode = Attack_Slash;
			bAiming = false;
			CompleteState(true);
		}
	}
}


DefaultProperties
{
	bWeaponProjCamEnabled=false
	CurrentWeaponType = EWEP_Crossbow
	// set maximum ammo
	AmmoCount=12
	MaxAmmoCount=25
	AIRange=5000
	bRetIdle=true;
	bRetIdleOriginal=true
	AttachmentClass=class'CompModWeaponAttachment_Crossbow'
	InventoryAttachmentClass=class'AOCInventoryAttachment_Crossbow'
	PermanentAttachmentClass(0)=class'AOCInventoryAttachment_CrossbowQuiverAgatha'
	PermanentAttachmentClass(1)=class'AOCInventoryAttachment_CrossbowQuiverMason'
	bHaveShield=false
	WeaponIdleAnim(0)=3p_crossbow_idle01
	WeaponIdleAnim(1)=3p_crossbow_idle02

	CurrentGenWeaponType=EWT_Crossbow
	WeaponIdentifier="crossbow"

	bHold(0)=0

	FiringStatesArray(0)=IronSightWindup
	FiringStatesArray(1)=IronSightWindup

	bAiming=false
	bLoaded=true

	ProjectileSpawnLocation=ProjCrossbowPoint
	StrafeModify=0.75f
	bCanDodge=false

	WeaponProjectiles(0)=class'CompModProj_SteelBolt'

	fSpread = 3500.0f
	bGoBackToHold=false

	fReasonableRefireRate=2.0f

	bNeverFlinch=false

	/*
	 * Formerly in UDKNewWeapon.ini - [AOC.AOCWeapon_Crossbow]
	 */
	ConfigProjectileBaseDamage[0]=(Damage=0,InitialSpeed=0,MaxSpeed=0,AmmoCount=0,InitialGravityScale=0,Drag=0,PitchCorrection=0.0)
	ConfigProjectileBaseDamage[1]=(Damage=0,InitialSpeed=0,MaxSpeed=0,AmmoCount=0,InitialGravityScale=0,Drag=0,PitchCorrection=0.0)
	ConfigProjectileBaseDamage[2]=(Damage=0,InitialSpeed=0,MaxSpeed=0,AmmoCount=0,InitialGravityScale=0,Drag=0,PitchCorrection=0.0)
	ConfigProjectileBaseDamage[3]=(Damage=61,InitialSpeed=7000.0,MaxSpeed=7500.0,AmmoCount=12,InitialGravityScale=0.3,Drag=0.000002,PitchCorrection=0)
	ConfigProjectileBaseDamage[4]=(Damage=0,InitialSpeed=0,MaxSpeed=0,AmmoCount=0,InitialGravityScale=0,Drag=0.000001,PitchCorrection=60.0)
	ConfigProjectileBaseDamage[5]=(Damage=0,InitialSpeed=0,MaxSpeed=0,AmmoCount=0,InitialGravityScale=0,Drag=0.000001,PitchCorrection=60.0)
	iFeintStaminaCost=0
	WeaponFontSymbol="+"
	WeaponReach=100
	WeaponLargePortrait="UI_WeaponImages_SWF.weapon_select_crossbow"
	WeaponSmallPortrait="UI_WeaponImages_SWF.icon_weapon_select_crossbow_png"
	HorizontalRotateSpeed=75000.0
	VerticalRotateSpeed=65000.0
	AttackHorizRotateSpeed=40000.0
	SprintAttackHorizRotateSpeed=20000.0
	SprintAttackVerticalRotateSpeed=20000.0
	BattleCryAnim=(AnimationName=3p_crossbow_battlecry,ComboAnimation=,AssociatedSoundCue=,bFullBody=true,bCombo=false,bLoop=false,bForce=false,UniqueShieldSound=none,fModifiedMovement=0.0,fAnimationLength=0.0,fBlendInTime=0.00,fBlendOutTime=0.00,bLastAnimation=true)
	WindupAnimations(0)=(AnimationName=3p_crossbow_aim,ComboAnimation=,AssociatedSoundCue=,bFullBody=False,bCombo=False,bLoop=False,bForce=false,UniqueShieldSound=none,fModifiedMovement=1.0,fAnimationLength=0.5,fBlendInTime=0.00,fBlendOutTime=0.00,bLastAnimation=false,bUseAltNode=true)
	ReleaseAnimations(0)=(AnimationName=3p_crossbow_aimrelease,ComboAnimation=,AssociatedSoundCue=SoundCue'A_Combat_Locomotion.crossbow_Attack_01',bFullBody=False,bCombo=False,bLoop=False,bForce=false,fModifiedMovement=1.0,fAnimationLength=0.0,fBlendInTime=0.00,fBlendOutTime=0.00,bLastAnimation=false,bPlayOnWeapon=true,bUseAltNode=true,bAttachArrow=0)
	ReleaseAnimations(1)=(AnimationName=,ComboAnimation=,AssociatedSoundCue=SoundCue'A_Combat_Locomotion.crossbow_Attack_01',bFullBody=False,bCombo=False,bLoop=False,bForce=false,fModifiedMovement=1.0,fAnimationLength=0.0,fBlendInTime=0.00,fBlendOutTime=0.00,bLastAnimation=false)
	ReleaseAnimations(2)=(AnimationName=,ComboAnimation=,AssociatedSoundCue=SoundCue'A_Combat_Locomotion.Broadsword_Attack_03',bFullBody=False,bCombo=False,bLoop=False,bForce=false,UniqueShieldSound=none,fModifiedMovement=0.0,fAnimationLength=0.653,fBlendInTime=0.00,fBlendOutTime=0.00,bLastAnimation=false)
	ReleaseAnimations(3)=(AnimationName=,ComboAnimation=,AssociatedSoundCue=SoundCue'A_Combat_Locomotion.broadsword_sprint_attack',bFullBody=True,bCombo=False,bLoop=False,bForce=false,UniqueShieldSound=none,fModifiedMovement=1.0,fAnimationLength=0.0,fBlendInTime=0.00,fBlendOutTime=0.00,bLastAnimation=false)
	ReleaseAnimations(4)=(AnimationName=,ComboAnimation=,AssociatedSoundCue=SoundCue'A_Combat_Locomotion.broadsword_sprint_attack',bFullBody=True,bCombo=False,bLoop=False,bForce=false,UniqueShieldSound=none,fModifiedMovement=1.0,fAnimationLength=0.0,fBlendInTime=0.00,fBlendOutTime=0.00,bLastAnimation=false)
	ReleaseAnimations(5)=(AnimationName=,ComboAnimation=,AssociatedSoundCue=,bFullBody=True,bCombo=False,bLoop=False,bForce=false,UniqueShieldSound=none,fModifiedMovement=1.0,fAnimationLength=0.0,fBlendInTime=0.00,fBlendOutTime=0.00,bLastAnimation=false)
	ReleaseAnimations(6)=(AnimationName=,ComboAnimation=,AssociatedSoundCue=,bFullBody=false,bCombo=false,bLoop=false,bForce=false,UniqueShieldSound=none,fModifiedMovement=1.0,fAnimationLength=0.0,fBlendInTime=0.00,fBlendOutTime=0.00,bLastAnimation=false)
	ReleaseAnimations(7)=(AnimationName=,ComboAnimation=,AssociatedSoundCue=,bFullBody=false,bCombo=false,bLoop=false,bForce=false,UniqueShieldSound=none,fModifiedMovement=1.0,fAnimationLength=0.0,fBlendInTime=0.00,fBlendOutTime=0.00,bLastAnimation=false)
	ReleaseAnimations(8)=(AnimationName=3p_crossbow_equipup,ComboAnimation=,AssociatedSoundCue=SoundCue'A_Combat_Locomotion.longbow_draw',bFullBody=false,bCombo=false,bLoop=false,bForce=false,UniqueShieldSound=none,fModifiedMovement=1.0,fAnimationLength=0.5,fBlendInTime=0.00,fBlendOutTime=0.01,bLastAnimation=false)
	ReleaseAnimations(9)=(AnimationName=3p_crossbow_equipdown,ComboAnimation=,AssociatedSoundCue=SoundCue'A_Combat_Locomotion.longbow_sheath',bFullBody=false,bCombo=false,bLoop=false,bForce=false,UniqueShieldSound=none,fModifiedMovement=1.0,fAnimationLength=0.2,fBlendInTime=0.00,fBlendOutTime=0.01,bLastAnimation=false)
	ReloadAnimations[0]=(AnimationName=3p_crossbow_reload,ComboAnimation=,AssociatedSoundCue=SoundCue'A_Combat_Locomotion.crossbow_Reload',bFullBody=true,bCombo=false,bLoop=false,bForce=false,fModifiedMovement=0.0,fAnimationLength=3,fBlendInTime=0.1,fBlendOutTime=0.20,bLastAnimation=true,bPlayOnWeapon=true,bAttachArrow=1)
	RecoveryAnimations(0)=(AnimationName=3p_crossbow_aimrecover,ComboAnimation=,AssociatedSoundCue=,bFullBody=False,bCombo=False,bLoop=False,bForce=false,UniqueShieldSound=none,fModifiedMovement=1.0,fAnimationLength=0.5,fBlendInTime=0.00,fBlendOutTime=0.00,bLastAnimation=false,bUseAltNode=true)
	HoldAnimations[0]=(AnimationName=3p_crossbow_aimidle,ComboAnimation=,AssociatedSoundCue=,bFullBody=False,bCombo=False,bLoop=True,bForce=false,UniqueShieldSound=none,fModifiedMovement=0.75,fAnimationLength=0.0,fBlendInTime=0.10,fBlendOutTime=0.10,bLastAnimation=false,bPlayOnWeapon=false,bUseAltNode=true)
	StateAnimations(0)=(AnimationName=3p_crossbow_Fhit01,ComboAnimation=,AssociatedSoundCue=,bFullBody=false,bCombo=false,bLoop=false,bForce=false,UniqueShieldSound=none,fModifiedMovement=1.0,fAnimationLength=0.8,fBlendInTime=0.00,fBlendOutTime=0.08,bLastAnimation=true)
	StateAnimations(1)=(AnimationName=3p_crossbow_Fhit01,ComboAnimation=,AssociatedSoundCue=,bFullBody=true,bCombo=false,bLoop=false,bForce=false,UniqueShieldSound=none,fModifiedMovement=1.0,fAnimationLength=0.2,fBlendInTime=0.00,fBlendOutTime=0.00,bLastAnimation=true)
	StateAnimations(2)=(AnimationName=3p_crossbow_Fhit01,ComboAnimation=,AssociatedSoundCue=,bFullBody=true,bCombo=false,bLoop=false,bForce=false,UniqueShieldSound=none,fModifiedMovement=1.0,fAnimationLength=0.9,fBlendInTime=0.00,fBlendOutTime=0.00,bLastAnimation=true)
	StateAnimations(3)=(AnimationName=3p_crossbow_Fhit01,ComboAnimation=,AssociatedSoundCue=,bFullBody=true,bCombo=false,bLoop=false,bForce=false,UniqueShieldSound=none,fModifiedMovement=1.0,fAnimationLength=0.9,fBlendInTime=0.00,fBlendOutTime=0.00,bLastAnimation=true)
	StateAnimations(4)=(AnimationName=3p_crossbow_Fhit01,ComboAnimation=,AssociatedSoundCue=,bFullBody=false,bCombo=false,bLoop=false,bForce=false,UniqueShieldSound=none,fModifiedMovement=1.0,fAnimationLength=0.4,fBlendInTime=0.00,fBlendOutTime=0.08,bLastAnimation=false)
	TurnInfo(0)=(AnimationName=3p_crossbow_turnL,ComboAnimation=,AssociatedSoundCue=,bFullBody=false,bCombo=false,bLoop=true,bForce=false,UniqueShieldSound=none,fModifiedMovement=1.0,fAnimationLength=0.0,fBlendInTime=0.00,fBlendOutTime=0.0,bLastAnimation=false,bLowerBody=true)
	TurnInfo(1)=(AnimationName=3p_crossbow_turnR,ComboAnimation=,AssociatedSoundCue=,bFullBody=false,bCombo=false,bLoop=true,bForce=false,UniqueShieldSound=none,fModifiedMovement=1.0,fAnimationLength=0.0,fBlendInTime=0.00,fBlendOutTime=0.0,bLastAnimation=false)
	DazedAnimations(0)=(AnimationName=3p_crossbow_dazedB01,ComboAnimation=,AssociatedSoundCue=,bFullBody=false,bCombo=false,bLoop=false,bForce=false,UniqueShieldSound=none,fModifiedMovement=1.0,fAnimationLength=1.1,fBlendInTime=0.00,fBlendOutTime=0.00,bLastAnimation=true)
	DazedAnimations(1)=(AnimationName=3p_crossbow_dazedR01,ComboAnimation=,AssociatedSoundCue=,bFullBody=false,bCombo=false,bLoop=false,bForce=false,UniqueShieldSound=none,fModifiedMovement=1.0,fAnimationLength=1.1,fBlendInTime=0.00,fBlendOutTime=0.00,bLastAnimation=true)
	DazedAnimations(2)=(AnimationName=3p_crossbow_dazedF01,ComboAnimation=,AssociatedSoundCue=,bFullBody=false,bCombo=false,bLoop=false,bForce=false,UniqueShieldSound=none,fModifiedMovement=1.0,fAnimationLength=1.1,fBlendInTime=0.00,fBlendOutTime=0.00,bLastAnimation=true)
	DazedAnimations(3)=(AnimationName=3p_crossbow_dazedL01,ComboAnimation=,AssociatedSoundCue=,bFullBody=false,bCombo=false,bLoop=false,bForce=false,UniqueShieldSound=none,fModifiedMovement=1.0,fAnimationLength=1.1,fBlendInTime=0.00,fBlendOutTime=0.00,bLastAnimation=true)
	DazedAnimations(4)=(AnimationName=3p_crossbow_dazedBL,ComboAnimation=,AssociatedSoundCue=,bFullBody=false,bCombo=false,bLoop=false,bForce=false,UniqueShieldSound=none,fModifiedMovement=1.0,fAnimationLength=1.1,fBlendInTime=0.00,fBlendOutTime=0.00,bLastAnimation=true)
	DazedAnimations(5)=(AnimationName=3p_crossbow_dazedBR,ComboAnimation=,AssociatedSoundCue=,bFullBody=false,bCombo=false,bLoop=false,bForce=false,UniqueShieldSound=none,fModifiedMovement=1.0,fAnimationLength=1.1,fBlendInTime=0.00,fBlendOutTime=0.00,bLastAnimation=true)
	DazedAnimations(6)=(AnimationName=3p_crossbow_dazedFL,ComboAnimation=,AssociatedSoundCue=,bFullBody=false,bCombo=false,bLoop=false,bForce=false,UniqueShieldSound=none,fModifiedMovement=1.0,fAnimationLength=1.1,fBlendInTime=0.00,fBlendOutTime=0.00,bLastAnimation=true)
	DazedAnimations(7)=(AnimationName=3p_crossbow_dazedFR,ComboAnimation=,AssociatedSoundCue=,bFullBody=false,bCombo=false,bLoop=false,bForce=false,UniqueShieldSound=none,fModifiedMovement=1.0,fAnimationLength=1.1,fBlendInTime=0.00,fBlendOutTime=0.00,bLastAnimation=true)
	DirHitAnimation(0)=(AnimationName=ADD_3p_crossbow_hitFL,ComboAnimation=,AssociatedSoundCue=,bFullBody=false,bCombo=false,bLoop=false,bForce=false,UniqueShieldSound=none,fModifiedMovement=1.0,fAnimationLength=0.4,fBlendInTime=0.00,fBlendOutTime=0.1,bLastAnimation=false,bUseSlotSystem=true)
	DirHitAnimation(1)=(AnimationName=ADD_3p_crossbow_hitFR,ComboAnimation=,AssociatedSoundCue=,bFullBody=false,bCombo=false,bLoop=false,bForce=false,UniqueShieldSound=none,fModifiedMovement=1.0,fAnimationLength=0.4,fBlendInTime=0.00,fBlendOutTime=0.1,bLastAnimation=false,bUseSlotSystem=true)
	DirHitAnimation(2)=(AnimationName=ADD_3p_crossbow_hitBL,ComboAnimation=,AssociatedSoundCue=,bFullBody=false,bCombo=false,bLoop=false,bForce=false,UniqueShieldSound=none,fModifiedMovement=1.0,fAnimationLength=0.4,fBlendInTime=0.00,fBlendOutTime=0.1,bLastAnimation=false,bUseSlotSystem=true)
	DirHitAnimation(3)=(AnimationName=ADD_3p_crossbow_hitBR,ComboAnimation=,AssociatedSoundCue=,bFullBody=false,bCombo=false,bLoop=false,bForce=false,UniqueShieldSound=none,fModifiedMovement=1.0,fAnimationLength=0.4,fBlendInTime=0.00,fBlendOutTime=0.1,bLastAnimation=false,bUseSlotSystem=true)
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
