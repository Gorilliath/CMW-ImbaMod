/**
* Copyright 2010-2012, Torn Banner Studios, All rights reserved
*
* Original Author: Michael Bao
*
* Sling.
* Different from other ranged weapons:
* - Blunt damage
* - Infinite Ammo
* - 'Charge': Once in hold state, you do more damage and fly faster the longer you hold it. [Crosshairs will go from large to small]
*/
class CompModWeapon_Sling extends CompModRangeWeapon;

var float    TimeToFullyCharge; // UDKNewWeapon.ini under [AOCWeapon_Sling]
var float           StartChargeTime;
var float    BonusSpeed;        // How much bonus speed you can gain from charging

/** Attack queuing */
var EAttack AttackQueue;
var bool bWantToFire;

simulated function ResetFOV()
{
	if (PlayerController(AOCOwner.Controller) != none)
		PlayerController(AOCOwner.Controller).DesiredFOV = PlayerController(AOCOwner.Controller).DefaultFOV;
}

// Sling has infinite ammo
function ConsumeAmmo( byte FireModeNum )
{
	if (!ConfigProjectileBaseDamage[GetProjectileType()].bInfiniteAmmo)
	{
		super.ConsumeAmmo(FireModeNum);
	}
}

simulated state Active
{
	/** Initialize the weapon as being active and ready to go. */
	simulated event BeginState(Name PreviousStateName)
	{
		super.BeginState(PreviousStateName);

		if (AmmoCount > 0)
		{
			bLoaded = true;
		}

		if (AttackQueue != Attack_Null)
		{
			CurrentFireMode = AttackQueue;
			BeginFire(AttackQueue);
			AttackQueue = Attack_Null;
		}
	}
}

simulated function ActuallyPerformCompleteState(); // To Fire for Min Fire Time

simulated state Hold
{
	simulated function ActuallyPerformCompleteState()
	{
		CompleteState(false);
	}

	simulated event BeginState(Name PreviousStateName)
	{
		super.BeginState(PreviousStateName);

		// Mark Time
		StartChargeTime = AOCOWner.WorldInfo.TimeSeconds;

		if (bWantToFire)
		{
			bWantToFire = false;
			CompleteState(false);
		}
	}

	/** Handle the ending of the state - go to the appropriate next state */
	simulated function CompleteState(bool bReturnToIdle)
	{
		local float TimerTime;
		if (WorldInfo.TimeSeconds - StartChargeTime < ConfigProjectileBaseDamage[GetProjectileType()].MinimumFireTime && !bReturnToIdle)
		{
			TimerTime = ConfigProjectileBaseDamage[GetProjectileType()].MinimumFireTime - (WorldInfo.TimeSeconds - StartChargeTime);
			if (TimerTime > 0.05f)
			{
				SetTimer(TimerTime, false, 'ActuallyPerformCompleteState');
				return;
			}
		}
		// throwing knife shouldn't go into recovery
		bRetIdle = bRetIdleOriginal;
		//`log("COMPLETE STATE"@bReturnToIdle);
		if (bReturnToIdle)
		{
			bRetIdle = bRetIdleOriginal;
			GotoState('Recovery');
		}
		else
		{
			// calculate how much time went buy in hold
			UnClock(ElapsedHoldTime);
			GotoState('Release');
		}
	}

	/** Cancel Fire.
	 */
	simulated function BeginFire(byte FireModeNum)
	{
		if (FireModeNum == Attack_Parry)
			GotoState('Recovery');
	}

	simulated function ZoomOut()
	{
		if (PlayerController(AOCOwner.Controller) != none)
			PlayerController(AOCOwner.Controller).DesiredFOV = PlayerController(AOCOwner.Controller).DefaultFOV;
	}

	simulated function ZoomIn()
	{
		if (PlayerController(AOCOwner.Controller) != none)
		{
			if (PlayerController(AOCOwner.Controller).DesiredFOV == PlayerController(AOCOwner.Controller).DefaultFOV)
			{
				PlayerController(AOCOwner.Controller).DesiredFOV *= 70.0f / 95.f;
			}
			AOCOwner.OnActionSucceeded(EACT_Focus);
		}
	}
}

simulated state Recovery
{
	/** Skip state and go straight to reload */
	simulated event BeginState(Name PreviousStateName)
	{
		bLoaded=true; // loaded without going to the recovery state
		super.BeginState(PreviousStateName);
	}

	simulated function ZoomOut()
	{
		if (PlayerController(AOCOwner.Controller) != none)
			PlayerController(AOCOwner.Controller).DesiredFOV = PlayerController(AOCOwner.Controller).DefaultFOV;
	}

	simulated function ZoomIn()
	{
		if (PlayerController(AOCOwner.Controller) != none)
		{
			if (PlayerController(AOCOwner.Controller).DesiredFOV == PlayerController(AOCOwner.Controller).DefaultFOV)
			{
				PlayerController(AOCOwner.Controller).DesiredFOV *= 70.0f / 95.f;
			}
			AOCOwner.OnActionSucceeded(EACT_Focus);
		}
	}
}

/** Release state. Fire the projectile.
 */
simulated state Release
{
	simulated function OnStateAnimationEnd()
	{
		GotoState('Reload');
	}

	/** Play appropriate attack animation */
	simulated event BeginState(Name PreviousStateName)
	{
		if (AOCOwner == none)
			CacheWeaponReferences();
		CurrentAnimations = ReleaseAnimations;
		// no longer need to update abilities...should carry over from windup
		PlayStateAnimation();
		ReleaseProjectileTime = WorldInfo.TimeSeconds;

		AOCPRI(AOCOwner.PlayerReplicationInfo).NumAttacks += 1;

		if (Role == ROLE_Authority)
			AOCOwner.PauseHealthRegeneration();
	}

	simulated event EndState(Name NextStateName)
	{
		super.EndState(NextStateName);
		if (CurrentFireMode == Attack_Slash)
		{
			// Change damage based on how long we've held.
			StartChargeTime = AOCOwner.WorldInfo.TimeSeconds - StartChargeTime;
			if (Role < ROLE_Authority || WorldInfo.NetMode == NM_STANDALONE || (AOCOwner.bIsBot && Role == ROLE_Authority) || (Worldinfo.NetMode == NM_ListenServer && AOCOwner.IsLocallyControlled()))
			{
				Fire();
			}
			ConsumeAmmo(0); // consume ammo for 0'th fire type - only one type of range firing
			// after consuming ammo, we are not loaded anymore
			bLoaded = false;
			AOCWepAttachment.DetachArrow();

			if (AmmoCount == 0)
				SwitchWeaponNoAmmo();

			AttackQueue = Attack_Null;
		}
	}

	simulated function ZoomOut()
	{
		if (PlayerController(AOCOwner.Controller) != none)
			PlayerController(AOCOwner.Controller).DesiredFOV = PlayerController(AOCOwner.Controller).DefaultFOV;
	}

	simulated function ZoomIn()
	{
		if (PlayerController(AOCOwner.Controller) != none)
		{
			if (PlayerController(AOCOwner.Controller).DesiredFOV == PlayerController(AOCOwner.Controller).DefaultFOV)
			{
				PlayerController(AOCOwner.Controller).DesiredFOV *= 70.0f / 95.f;
			}
			AOCOwner.OnActionSucceeded(EACT_Focus);
		}
	}
}

simulated state Windup
{
	simulated function BeginFire(byte FireModeNum)
	{
		if (FireModeNum == Attack_Parry)
			GotoState('Recovery');
		else if (FireModeNum == Attack_Slash)
			bWantToFire = false;

	}

	/** The user released the mouse button and we should fire */
	simulated function EndFire(byte FireModeNum)
	{
		bWantToFire = true;
	}

	simulated function ZoomOut()
	{
		if (PlayerController(AOCOwner.Controller) != none)
			PlayerController(AOCOwner.Controller).DesiredFOV = PlayerController(AOCOwner.Controller).DefaultFOV;
	}

	simulated function ZoomIn()
	{
		if (PlayerController(AOCOwner.Controller) != none)
		{
			if (PlayerController(AOCOwner.Controller).DesiredFOV == PlayerController(AOCOwner.Controller).DefaultFOV)
				PlayerController(AOCOwner.Controller).DesiredFOV *= 70.f / 95.f;
			AOCOwner.OnActionSucceeded(EACT_Focus);
		}
	}
}


simulated state Reload
{
	/** If we decide to do an attack during the windup animation, take note of it and handle during release state */
	simulated function BeginFire(byte FireModeNum)
	{
		if (EAttack(FireModeNum) == Attack_Slash)
		{
			AttackQueue = EAttack(FireModeNum);
		}
	}

	/** The user released the mouse button and we should fire */
	simulated function EndFire(byte FireModeNum)
	{
		if (AttackQueue != Attack_Null && FireModeNum == Attack_Slash)
			bWantToFire = true;
	}

	simulated function ZoomOut()
	{
		if (PlayerController(AOCOwner.Controller) != none)
			PlayerController(AOCOwner.Controller).DesiredFOV = PlayerController(AOCOwner.Controller).DefaultFOV;
	}

	simulated function ZoomIn()
	{
		if (PlayerController(AOCOwner.Controller) != none)
		{
			if (PlayerController(AOCOwner.Controller).DesiredFOV == PlayerController(AOCOwner.Controller).DefaultFOV)
				PlayerController(AOCOwner.Controller).DesiredFOV *= 70.0f / 95.f;
			AOCOwner.OnActionSucceeded(EACT_Focus);
		}
	}
}

simulated function SpawnProjectile( Vector RealStartLoc, float Pitch, float Yaw, float Roll )
{
	local float OldDamage;
	local float OldSpeed;
	local float OldMaxSpeed;
	local float MinDamage;
	MinDamage = ConfigProjectileBaseDamage[GetProjectileType()].MinDamage;
	// Modify numbers as necesssary (damage, initial speed, max speed);
	OldDamage = ConfigProjectileBaseDamage[GetProjectileType()].Damage;
	OldSpeed = ConfigProjectileBaseDamage[GetProjectileType()].InitialSpeed;
	OldMaxSpeed = ConfigProjectileBaseDamage[GetProjectileType()].MaxSpeed;
	ConfigProjectileBaseDamage[GetProjectileType()].Damage = MinDamage + ( OldDamage - MinDamage) * FClamp(StartChargeTime / TimeToFullyCharge, 0.1f, 1.f);
	ConfigProjectileBaseDamage[GetProjectileType()].InitialSpeed += BonusSpeed * FClamp(StartChargeTime / TimeToFullyCharge, 0.1f, 1.f);
	ConfigProjectileBaseDamage[GetProjectileType()].MaxSpeed += BonusSpeed * FClamp(StartChargeTime / TimeToFullyCharge, 0.1f, 1.f);
	super.SpawnProjectile(RealStartLoc, Pitch, Yaw, Roll);
	ConfigProjectileBaseDamage[GetProjectileType()].Damage = OldDamage;
	ConfigProjectileBaseDamage[GetProjectileType()].InitialSpeed = OldSpeed;
	ConfigProjectileBaseDamage[GetProjectileType()].MaxSpeed = OldMaxSpeed;
}



DefaultProperties
{
	bWeaponProjCamEnabled=false
	CurrentWeaponType = EWEP_Sling
	// set maximum ammo
	AmmoCount=99
	MaxAmmoCount=99
	AIRange=5000

	WeaponProjectiles(0)=class'AOCProj_Pebble'

	AttachmentClass=class'AOCWeaponAttachment_Sling'
	// should never be part of inventory attachment
	InventoryAttachmentClass=class'AOCInventoryAttachment_Sling'

	CurrentGenWeaponType=EWT_Throwing
	WeaponIdentifier="sling"
	WeaponIdleAnim=''

	WeaponIdleAnim=''

	FiringStatesArray(2)=none
	FiringStatesArray(3)=none
	FiringStatesArray(4)=none
	FiringStatesArray(5)=none

	ProjectileSpawnLocation=ProjPoint
	bRetIdle=true
	bRetIdleOriginal=true

	bWantToFire=false
	AttackQueue=Attack_Null

	bNeverFlinch=false

	/*
	 * Formerly in UDKNewWeapon.ini - [AOC.AOCWeapon_Sling]
	 */
	// Range Weapon ConfigProjectileBaseDamage Info
	// 0 - Bodkin
	// 1 - Broadhead
	// 2 - Fire
	// 3 - Steel
	// 4 - Javelin
	// 5 - Default
	// NOTE: Javelin sprint damage bonus found in DefaultWeapon.ini
	// The ones that aren't used shouldn't need to be set but I do it just to be safe.
	TimeToFullyCharge=2.f
	BonusSpeed=1000.f
	ConfigProjectileBaseDamage[0]=(Damage=0,InitialSpeed=0,MaxSpeed=0,AmmoCount=0,InitialGravityScale=0,Drag=0,PitchCorrection=0.0)
	ConfigProjectileBaseDamage[1]=(Damage=0,InitialSpeed=0,MaxSpeed=0,AmmoCount=0,InitialGravityScale=0,Drag=0,PitchCorrection=0.0)
	ConfigProjectileBaseDamage[2]=(Damage=0,InitialSpeed=0,MaxSpeed=0,AmmoCount=0,InitialGravityScale=0,Drag=0,PitchCorrection=0.0)
	ConfigProjectileBaseDamage[3]=(Damage=0,InitialSpeed=0,MaxSpeed=0,AmmoCount=0,InitialGravityScale=0,Drag=0,PitchCorrection=0.0)
	ConfigProjectileBaseDamage[4]=(Damage=0,InitialSpeed=0,MaxSpeed=0,AmmoCount=0,InitialGravityScale=0,Drag=0,PitchCorrection=0.0)
	ConfigProjectileBaseDamage[5]=(Damage=0,InitialSpeed=0.0,MaxSpeed=0.0,AmmoCount=0,InitialGravityScale=0,Drag=0,PitchCorrection=0)
	ConfigProjectileBaseDamage[6]=(MinDamage=30.0f,Damage=35,InitialSpeed=4000.0,MaxSpeed=4500.0,AmmoCount=999,InitialGravityScale=0.6,Drag=0.0000045,PitchCorrection=0,bInfiniteAmmo=true,MinimumFireTime=0.3)
	ConfigProjectileBaseDamage[7]=(MinDamage=25.0f,Damage=49,InitialSpeed=5000.0,MaxSpeed=5500.0,AmmoCount=25,InitialGravityScale=0.65,Drag=0.0000055,PitchCorrection=0,bInfiniteAmmo=false,MinimumFireTime=0.6)
	iFeintStaminaCost=0
	WeaponFontSymbol="K"
	WeaponLargePortrait="UI_WeaponImages_SWF.weapon_select_sling"
	WeaponSmallPortrait="UI_WeaponImages_SWF.icon_weapon_select_sling_png"
	HorizontalRotateSpeed=75000.0
	VerticalRotateSpeed=65000.0
	WeaponReach=100
	AttackHorizRotateSpeed=50000.0
	SprintAttackHorizRotateSpeed=20000.0
	SprintAttackVerticalRotateSpeed=20000.0
	BattleCryAnim=(AnimationName=3p_sling_battlecry,ComboAnimation=,AssociatedSoundCue=,bFullBody=true,bCombo=false,bLoop=false,bForce=false,UniqueShieldSound=none,fModifiedMovement=0.0,fAnimationLength=0.0,fBlendInTime=0.00,fBlendOutTime=0.00,bLastAnimation=true)
	WindupAnimations(0)=(AnimationName=3p_sling_throwwindup,ComboAnimation=,AssociatedSoundCue=SoundCue'A_Combat_Locomotion.Sling_attack_ready',bFullBody=False,bCombo=False,bLoop=False,bForce=false,fModifiedMovement=1.0,fAnimationLength=0.5,fBlendInTime=0.00,fBlendOutTime=0.00,bLastAnimation=false,bPlayOnWeapon=true)
	WindupAnimations(1)=(AnimationName=3p_sling_slash02downtoup,ComboAnimation=,AssociatedSoundCue=SoundCue'A_Combat_Locomotion.doubleaxe_windup',bFullBody=False,bCombo=False,bLoop=False,bForce=false,fModifiedMovement=1.0,fAnimationLength=0.0,fBlendInTime=0.00,fBlendOutTime=0.00,bLastAnimation=false)
	WindupAnimations(2)=(AnimationName=3p_sling_stabdowntoup,ComboAnimation=,AssociatedSoundCue=SoundCue'A_Combat_Locomotion.doubleaxe_windup',bFullBody=False,bCombo=False,bLoop=False,bForce=false,fModifiedMovement=1.0,fAnimationLength=0.0,fBlendInTime=0.00,fBlendOutTime=0.00,bLastAnimation=false)
	ReleaseAnimations(0)=(AnimationName=3p_sling_throwrelease,ComboAnimation=,AssociatedSoundCue=SoundCue'A_Combat_Locomotion.sling_attack_01',bFullBody=False,bCombo=False,bLoop=False,bForce=false,UniqueShieldSound=none,fModifiedMovement=1.0,fAnimationLength=0.0,fBlendInTime=0.00,fBlendOutTime=0.00,bLastAnimation=false,bPlayOnWeapon=true)
	ReleaseAnimations(1)=(AnimationName=3p_sling_slash02release,ComboAnimation=3p_sling_slash021release,AssociatedSoundCue=SoundCue'A_Combat_Locomotion.Broadsword_Attack_02',bFullBody=False,bCombo=False,bLoop=False,bForce=false,UniqueShieldSound=none,fModifiedMovement=1.0,fAnimationLength=0.0,fBlendInTime=0.00,fBlendOutTime=0.00,bLastAnimation=false)
	ReleaseAnimations(2)=(AnimationName=3p_sling_stabrelease,ComboAnimation=3p_sling_stabrelease,AssociatedSoundCue=SoundCue'A_Combat_Locomotion.Broadsword_Attack_03',bFullBody=False,bCombo=False,bLoop=False,bForce=false,UniqueShieldSound=none,fModifiedMovement=1.0,fAnimationLength=0.0,fBlendInTime=0.00,fBlendOutTime=0.00,bLastAnimation=false)
	ReleaseAnimations(3)=(AnimationName=3p_sling_sattackrelease_new,ComboAnimation=,AssociatedSoundCue=SoundCue'A_Combat_Locomotion.broadsword_sprint_attack',bFullBody=True,bCombo=False,bLoop=False,bForce=false,UniqueShieldSound=none,fModifiedMovement=1.0,fAnimationLength=0.0,fBlendInTime=0.00,fBlendOutTime=0.00,bLastAnimation=false)
	ReleaseAnimations(4)=(AnimationName=3p_sling_parryup,ComboAnimation=,AssociatedSoundCue=SoundCue'A_Combat_Locomotion.Broadsword_Parry',bFullBody=False,bCombo=False,bLoop=False,bForce=false,UniqueShieldSound=none,fModifiedMovement=1.0,fAnimationLength=0.375,fBlendInTime=0.00,fBlendOutTime=0.00,bLastAnimation=false)
	ReleaseAnimations(5)=(AnimationName=3p_sling_shoverelease_new,ComboAnimation=,AssociatedSoundCue=,bFullBody=True,bCombo=False,bLoop=False,bForce=false,UniqueShieldSound=none,fModifiedMovement=1.0,fAnimationLength=0.2,fBlendInTime=0.00,fBlendOutTime=0.00,bLastAnimation=false,bUseRMM=true)
	ReleaseAnimations(6)=(AnimationName=,ComboAnimation=,AssociatedSoundCue=,bFullBody=false,bCombo=false,bLoop=false,bForce=false,UniqueShieldSound=none,fModifiedMovement=1.0,fAnimationLength=0.0,fBlendInTime=0.00,fBlendOutTime=0.00,bLastAnimation=false)
	ReleaseAnimations(7)=(AnimationName=,ComboAnimation=,AssociatedSoundCue=,bFullBody=false,bCombo=false,bLoop=false,bForce=false,UniqueShieldSound=none,fModifiedMovement=1.0,fAnimationLength=0.0,fBlendInTime=0.00,fBlendOutTime=0.00,bLastAnimation=false)
	ReleaseAnimations(8)=(AnimationName=3p_sling_equipup,ComboAnimation=,AssociatedSoundCue=SoundCue'A_Combat_Locomotion.mace_draw',bFullBody=false,bCombo=false,bLoop=false,bForce=false,UniqueShieldSound=none,fModifiedMovement=1.0,fAnimationLength=0.5,fBlendInTime=0.00,fBlendOutTime=0.01,bLastAnimation=false)
	ReleaseAnimations(9)=(AnimationName=3p_sling_equipdown,ComboAnimation=,AssociatedSoundCue=SoundCue'A_Combat_Locomotion.mace_sheath',bFullBody=false,bCombo=false,bLoop=false,bForce=false,UniqueShieldSound=none,fModifiedMovement=1.0,fAnimationLength=0.2,fBlendInTime=0.00,fBlendOutTime=0.01,bLastAnimation=false)
	RecoveryAnimations(0)=(AnimationName=3p_sling_throwuptodown,ComboAnimation=3p_sling_slash011recover,AssociatedSoundCue=,bFullBody=false,bCombo=false,bLoop=false,bForce=false,UniqueShieldSound=none,fModifiedMovement=1.0,fAnimationLength=0.8,fBlendInTime=0.00,fBlendOutTime=0.0,bLastAnimation=true)
	RecoveryAnimations(1)=(AnimationName=3p_sling_slash02recover,ComboAnimation=3p_sling_slash021recover,AssociatedSoundCue=,bFullBody=false,bCombo=false,bLoop=false,bForce=false,UniqueShieldSound=none,fModifiedMovement=1.0,fAnimationLength=0.0,fBlendInTime=0.00,fBlendOutTime=0.0,bLastAnimation=true)
	RecoveryAnimations(2)=(AnimationName=3p_sling_stabrecover,ComboAnimation=3p_sling_stabrecover,AssociatedSoundCue=,bFullBody=false,bCombo=false,bLoop=false,bForce=false,UniqueShieldSound=none,fModifiedMovement=1.0,fAnimationLength=0.0,fBlendInTime=0.00,fBlendOutTime=0.0,bLastAnimation=true)
	RecoveryAnimations(3)=(AnimationName=3p_sling_sattackrecover_new,ComboAnimation=,AssociatedSoundCue=,bFullBody=true,bCombo=false,bLoop=false,bForce=false,UniqueShieldSound=none,fModifiedMovement=0.0,fAnimationLength=0.0,fBlendInTime=0.00,fBlendOutTime=0.0,bLastAnimation=true)
	RecoveryAnimations(4)=(AnimationName=3p_sling_parryrecover,ComboAnimation=,AssociatedSoundCue=,bFullBody=false,bCombo=false,bLoop=false,bForce=false,UniqueShieldSound=none,fModifiedMovement=1.0,fAnimationLength=0.5,fBlendInTime=0.00,fBlendOutTime=0.0,bLastAnimation=true)
	RecoveryAnimations(5)=(AnimationName=3p_sling_shoverecover,ComboAnimation=,AssociatedSoundCue=,bFullBody=false,bCombo=false,bLoop=false,bForce=false,UniqueShieldSound=none,fModifiedMovement=1.0,fAnimationLength=0.5,fBlendInTime=0.10,fBlendOutTime=0.0,bLastAnimation=true)
	RecoveryAnimations(6)=(AnimationName=,ComboAnimation=,AssociatedSoundCue=,bFullBody=false,bCombo=false,bLoop=false,bForce=false,UniqueShieldSound=none,fModifiedMovement=1.0,fAnimationLength=0.0,fBlendInTime=0.00,fBlendOutTime=0.0,bLastAnimation=true)
	RecoveryAnimations(7)=(AnimationName=,ComboAnimation=,AssociatedSoundCue=,bFullBody=false,bCombo=false,bLoop=false,bForce=false,UniqueShieldSound=none,fModifiedMovement=1.0,fAnimationLength=0.0,fBlendInTime=0.00,fBlendOutTime=0.0,bLastAnimation=true)
	RecoveryAnimations(8)=(AnimationName=,ComboAnimation=,AssociatedSoundCue=,bFullBody=false,bCombo=false,bLoop=false,bForce=false,UniqueShieldSound=none,fModifiedMovement=1.0,fAnimationLength=0.0,fBlendInTime=0.00,fBlendOutTime=0.0,bLastAnimation=true)
	RecoveryAnimations(9)=(AnimationName=,ComboAnimation=,AssociatedSoundCue=,bFullBody=false,bCombo=false,bLoop=false,bForce=false,UniqueShieldSound=none,fModifiedMovement=1.0,fAnimationLength=0.0,fBlendInTime=0.00,fBlendOutTime=0.0,bLastAnimation=true)
	HoldAnimations[0]=(AnimationName=3p_sling_throwupidle,ComboAnimation=,AssociatedSoundCue=,bFullBody=false,bCombo=false,bLoop=true,bForce=false,fModifiedMovement=1.0,fAnimationLength=0.0,fBlendInTime=0.0,fBlendOutTime=0.00,bLastAnimation=false,bPlayOnWeapon=true)
	ReloadAnimations[0]=(AnimationName=3p_sling_throwrecover,ComboAnimation=,AssociatedSoundCue=,bFullBody=false,bCombo=false,bLoop=false,bForce=false,fModifiedMovement=1.0,fAnimationLength=.75,fBlendInTime=0.0,fBlendOutTime=0.00,bLastAnimation=false)
	StateAnimations(0)=(AnimationName=3p_sling_parried,ComboAnimation=,AssociatedSoundCue=,bFullBody=false,bCombo=false,bLoop=false,bForce=false,UniqueShieldSound=none,fModifiedMovement=1.0,fAnimationLength=0.8,fBlendInTime=0.00,fBlendOutTime=0.08,bLastAnimation=true)
	StateAnimations(1)=(AnimationName=3p_sling_dazed,ComboAnimation=,AssociatedSoundCue=,bFullBody=false,bCombo=false,bLoop=false,bForce=false,UniqueShieldSound=none,fModifiedMovement=1.0,fAnimationLength=0.2,fBlendInTime=0.00,fBlendOutTime=0.00,bLastAnimation=true)
	StateAnimations(2)=(AnimationName=3p_sling_dazedB01,ComboAnimation=,AssociatedSoundCue=,bFullBody=false,bCombo=false,bLoop=false,bForce=false,UniqueShieldSound=none,fModifiedMovement=1.0,fAnimationLength=0.9,fBlendInTime=0.00,fBlendOutTime=0.00,bLastAnimation=true)
	StateAnimations(3)=(AnimationName=3p_sling_dazedF01,ComboAnimation=,AssociatedSoundCue=,bFullBody=false,bCombo=false,bLoop=false,bForce=false,UniqueShieldSound=none,fModifiedMovement=1.0,fAnimationLength=0.9,fBlendInTime=0.00,fBlendOutTime=0.00,bLastAnimation=true)
	StateAnimations(4)=(AnimationName=3p_sling_hitFL,ComboAnimation=,AssociatedSoundCue=,bFullBody=false,bCombo=false,bLoop=false,bForce=false,UniqueShieldSound=none,fModifiedMovement=1.0,fAnimationLength=0.4,fBlendInTime=0.00,fBlendOutTime=0.08,bLastAnimation=false)
	TurnInfo(0)=(AnimationName=3p_sling_turnL,ComboAnimation=,AssociatedSoundCue=,bFullBody=true,bCombo=false,bLoop=true,bForce=false,UniqueShieldSound=none,fModifiedMovement=1.0,fAnimationLength=0.0,fBlendInTime=0.00,fBlendOutTime=0.0,bLastAnimation=false,bLowerBody=true)
	TurnInfo(1)=(AnimationName=3p_sling_turnR,ComboAnimation=,AssociatedSoundCue=,bFullBody=true,bCombo=false,bLoop=true,bForce=false,UniqueShieldSound=none,fModifiedMovement=1.0,fAnimationLength=0.0,fBlendInTime=0.00,fBlendOutTime=0.0,bLastAnimation=false)
	DazedAnimations(0)=(AnimationName=3p_sling_dazedB01,ComboAnimation=,AssociatedSoundCue=,bFullBody=false,bCombo=false,bLoop=false,bForce=false,UniqueShieldSound=none,fModifiedMovement=1.0,fAnimationLength=1.1,fBlendInTime=0.00,fBlendOutTime=0.00,bLastAnimation=true)
	DazedAnimations(1)=(AnimationName=3p_sling_dazedR01,ComboAnimation=,AssociatedSoundCue=,bFullBody=false,bCombo=false,bLoop=false,bForce=false,UniqueShieldSound=none,fModifiedMovement=1.0,fAnimationLength=1.1,fBlendInTime=0.00,fBlendOutTime=0.00,bLastAnimation=true)
	DazedAnimations(2)=(AnimationName=3p_sling_dazedF01,AlternateAnimation=3p_sling_parrydazed,ComboAnimation=,AssociatedSoundCue=,bFullBody=false,bCombo=false,bLoop=false,bForce=false,UniqueShieldSound=none,fModifiedMovement=1.0,fAnimationLength=1.1,fBlendInTime=0.00,fBlendOutTime=0.00,bLastAnimation=true)
	DazedAnimations(3)=(AnimationName=3p_sling_dazedL01,ComboAnimation=,AssociatedSoundCue=,bFullBody=false,bCombo=false,bLoop=false,bForce=false,UniqueShieldSound=none,fModifiedMovement=1.0,fAnimationLength=1.1,fBlendInTime=0.00,fBlendOutTime=0.00,bLastAnimation=true)
	DazedAnimations(4)=(AnimationName=3p_sling_dazedBL,ComboAnimation=,AssociatedSoundCue=,bFullBody=false,bCombo=false,bLoop=false,bForce=false,UniqueShieldSound=none,fModifiedMovement=1.0,fAnimationLength=1.1,fBlendInTime=0.00,fBlendOutTime=0.00,bLastAnimation=true)
	DazedAnimations(5)=(AnimationName=3p_sling_dazedBR,ComboAnimation=,AssociatedSoundCue=,bFullBody=false,bCombo=false,bLoop=false,bForce=false,UniqueShieldSound=none,fModifiedMovement=1.0,fAnimationLength=1.1,fBlendInTime=0.00,fBlendOutTime=0.00,bLastAnimation=true)
	DazedAnimations(6)=(AnimationName=3p_sling_dazedFL,ComboAnimation=,AssociatedSoundCue=,bFullBody=false,bCombo=false,bLoop=false,bForce=false,UniqueShieldSound=none,fModifiedMovement=1.0,fAnimationLength=1.1,fBlendInTime=0.00,fBlendOutTime=0.00,bLastAnimation=true)
	DazedAnimations(7)=(AnimationName=3p_sling_dazedFR,ComboAnimation=,AssociatedSoundCue=,bFullBody=false,bCombo=false,bLoop=false,bForce=false,UniqueShieldSound=none,fModifiedMovement=1.0,fAnimationLength=1.1,fBlendInTime=0.00,fBlendOutTime=0.00,bLastAnimation=true)
	DirHitAnimation(0)=(AnimationName=ADD_3p_sling_hitFL,ComboAnimation=,AssociatedSoundCue=,bFullBody=false,bCombo=false,bLoop=false,bForce=false,UniqueShieldSound=none,fModifiedMovement=1.0,fAnimationLength=0.4,fBlendInTime=0.00,fBlendOutTime=0.1,bLastAnimation=false,bUseSlotSystem=true)
	DirHitAnimation(1)=(AnimationName=ADD_3p_sling_hitFR,ComboAnimation=,AssociatedSoundCue=,bFullBody=false,bCombo=false,bLoop=false,bForce=false,UniqueShieldSound=none,fModifiedMovement=1.0,fAnimationLength=0.4,fBlendInTime=0.00,fBlendOutTime=0.1,bLastAnimation=false,bUseSlotSystem=true)
	DirHitAnimation(2)=(AnimationName=ADD_3p_sling_hitBL,ComboAnimation=,AssociatedSoundCue=,bFullBody=false,bCombo=false,bLoop=false,bForce=false,UniqueShieldSound=none,fModifiedMovement=1.0,fAnimationLength=0.4,fBlendInTime=0.00,fBlendOutTime=0.1,bLastAnimation=false,bUseSlotSystem=true)
	DirHitAnimation(3)=(AnimationName=ADD_3p_sling_hitBR,ComboAnimation=,AssociatedSoundCue=,bFullBody=false,bCombo=false,bLoop=false,bForce=false,UniqueShieldSound=none,fModifiedMovement=1.0,fAnimationLength=0.4,fBlendInTime=0.00,fBlendOutTime=0.1,bLastAnimation=false,bUseSlotSystem=true)
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
