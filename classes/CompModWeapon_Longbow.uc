/**
* Copyright 2010-2012, Torn Banner Studios, All rights reserved
*
* Original Author: Michael Bao
*
* Longbow.
*/
class CompModWeapon_Longbow extends CompModRangeWeapon
	dependson(AOCPawn);

/** Remember previos state for the recovery state */
var name PreviousState;

/** State Variables */
var bool bWantToFire;

/** How long to hold for archer to become exhausted */
var float fExhaustTime;
var bool bIsExhausted;

/** Points to determine how much to reduce stamina by */
var array<InterpPoint> StaminaReductionArray;

/** Attack queuing */
var EAttack AttackQueue;

/** Windup time */
var float fWindupAnimDuration;

var float fBowDrawCost;

simulated function Fire()
{
	super.Fire();
	MakeNoise(1.0);
}

simulated function OnTimerFire();

simulated function PostBeginPlay()
{
	local AnimationInfo Info;
	Info = WindupAnimations[0];
	fWindupAnimDuration = Info.fAnimationLength;
}

simulated function SpawnProjectile( Vector RealStartLoc, float Pitch, float Yaw, float Roll )
{
	local vector StartLoc;
	local Rotator Aim;
	local EProjType Type;

	if (AmmoCount <= 0)
		return;

	if(Worldinfo.TimeSeconds - fLastProjectileSpawnTime < fReasonableRefireRate)
		return;

	Type = GetProjectileType();
	Aim.Pitch = Pitch + ConfigProjectileBaseDamage[Type].PitchCorrection;;
	Aim.Yaw = Yaw;
	Aim.Roll = Roll;
	AOCPawn(Owner).CurrentWeaponAttachment.Mesh.GetSocketWorldLocationAndRotation( 'ArrowSocket' , StartLoc );
	SpawnedProjectile = Spawn(GetProjectileClass(),self,, RealStartLoc, Aim);
	if (AOCPlayerController(AOCOwner.Controller) != none)
	{
		AOCProjectile(SpawnedProjectile).ProjIdent = ++AOCPlayerController(AOCOwner.Controller).ProjectileNumber;
		AOCPlayerController(AOCOwner.Controller).SpawnedProjectile.AddItem(AOCProjectile(SpawnedProjectile));
	}
	if ( SpawnedProjectile != None )
	{
		// Give the projectiles properties based on weapon
		AOCProjectile(SpawnedProjectile).Damage = ConfigProjectileBaseDamage[Type].Damage;
		AOCProjectile(SpawnedProjectile).Speed = ConfigProjectileBaseDamage[Type].InitialSpeed;
		AOCProjectile(SpawnedProjectile).MaxSpeed = ConfigProjectileBaseDamage[Type].MaxSpeed;
		AOCProjectile(SpawnedProjectile).TerminalVelocity = ConfigProjectileBaseDamage[Type].MaxSpeed;
		AOCProjectile(SpawnedProjectile).CustomGravityScaling = ConfigProjectileBaseDamage[Type].InitialGravityScale;
		AOCProjectile(SpawnedProjectile).Drag = ConfigProjectileBaseDamage[Type].Drag;

		if (AOCOwner.bIsBot) //TEMP: Bots can't handle drag at the moment, so, uh, turn it off
			AOCProjectile(SpawnedProjectile).Drag = 0;

		AOCProjectile(SpawnedProjectile).OwnerPawn = AOCOwner;
		AOCProjectile(SpawnedProjectile).PrevLocation = StartLoc;
		SpawnedProjectile.Speed = SpawnedProjectile.Speed;
		SpawnedProjectile.MaxSpeed = SpawnedProjectile.MaxSpeed;
		SpawnedProjectile.Damage = SpawnedProjectile.Damage;
		AOCProjectile(SpawnedProjectile).RepSpeed = SpawnedProjectile.Speed;
		AOCProjectile(SpawnedProjectile).RepMaxSpeed = SpawnedProjectile.MaxSpeed;
		AOCProjectile(SpawnedProjectile).LaunchingWeapon = self.Class;
		AOCProjectile(SpawnedProjectile).CurrentAssociatedWeapon = 0;
		AOCProjectile(SpawnedProjectile).AOCInit( Aim);

		if (AOCPlayerController(AOCOwner.Controller) != none)
			AOCProjectile(SpawnedProjectile).ThisController = AOCPlayerController(AOCOwner.Controller);
	}
}


simulated function ResetFOV()
{
	if (PlayerController(AOCOwner.Controller) != none)
		PlayerController(AOCOwner.Controller).DesiredFOV = PlayerController(AOCOwner.Controller).DefaultFOV;
}


/** Default Active/Idle state.
 */
simulated state Active
{
	/** Initialize the weapon as being active and ready to go. */
	simulated event BeginState(Name PreviousStateName)
	{
		AOCOwner.StateVariables.bIsAttacking = false;
		bWantToFire = false;
		super.BeginState(PreviousStateName);

		// Set bLoaded here because we reload when we start to attack
		if (AmmoCount > 0)
			bLoaded = true;

		if (AttackQueue != Attack_Null)
		{
			CurrentFireMode = AttackQueue;
			BeginFire(AttackQueue);
			AttackQueue = Attack_Null;
		}
	}
}


/** Reload state. Most range weapons are automated reload with the exception of the crossbow.
 */
simulated state Reload
{
	/** Play appropriate attack animation */
	simulated event BeginState(Name PreviousStateName)
	{
		AOCOwner.ToggleSprint(false);
		AOCOwner.StateVariables.bCanSprint = false;
		super.BeginState(PreviousStateName);
		AOCPawn(Owner).ConsumeStamina(fBowDrawCost);
	}

	/** Play recovery animation */
	simulated function PlayStateAnimation()
	{
		local AnimationInfo AnimInfo;
		CurrentFireMode = Attack_Slash;
		AnimInfo = ReloadAnimations[CurrentFireMode];
		AOCOwner.ReplicateCompressedAnimation(AnimInfo, EWST_Reload, CurrentFireMode);
	}

	/** When finished with reload go to the next state */
	simulated function OnStateAnimationEnd()
	{
		GotoState('Windup');
	}

	/** If we decide to do an attack during the windup animation, take note of it and handle during release state */
	simulated function BeginFire(byte FireModeNum)
	{
		if (FireModeNum != Attack_Parry)
			bWantToFire = false;
	}

	/** The user released the mouse button and we should fire */
	simulated function EndFire(byte FireModeNum)
	{
		if (FireModeNum == Attack_Overhead)
			return;
		else
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

simulated function StartWaiver();
simulated function EndHold();

/** After holding for 1.5 seconds, transit to
 */
simulated state Hold
{

	simulated function StartWaiver()
	{
		PlayExhaustAnimation();
	}

	simulated function EndHold()
	{
		GotoState('Recovery');
	}

	/** Play appropriate attack animation */
	simulated event BeginState(Name PreviousStateName)
	{
		super.BeginState(PreviousStateName);
		ElapsedHoldTime = 0.0f;
		Clock(ElapsedHoldTime);
		if (bWantToFire)
		{
			EndFire(0);
			bWantToFire=false;
		}

		SEtTimer(3.f, false, 'StartWaiver');
		SEtTimer(5.f, false, 'EndHold');
	}

	/** Play hold idle 2 animation */
	simulated function PlayExhaustAnimation()
	{
		AOCOwner.ReplicateCompressedAnimation(HoldAnimations[CurrentFireMode+1],EWST_Hold, CurrentFireMode + 1,,,false,false);
	}

	/** Cancel Fire.
	 */
	simulated function BeginFire(byte FireModeNum)
	{
		if (FireModeNum == Attack_Parry)
			GotoState('Recovery');
	}

	/** The user released the mouse button and we should fire */
	simulated function EndFire(byte FireModeNum)
	{
		UnClock(ElapsedHoldTime);
		ElapsedHoldTime /= 1000.0f;
		/*if (ElapsedHoldTime < fWindupAnimDuration)
		{
			SetTimer(0.5f - ElapsedHoldTime, false, 'EndFire');
			ElapsedHoldTime = 0.5f;
		}
		else */
		super.EndFire(FireModeNum);
	}

	simulated event EndState(Name NextStateName)
	{
		bIsExhausted = false;
		bWantToFire = false;

		// zoom out just in case
		ZoomOut();

		// Remove Debuff from hold animation
		AOCOwner.RemoveDebuff(EDEBF_ANIMATION);
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


/** Windup state. Getting ready to fire.
 *  Go into hold if necessary.
 */
simulated state Windup
{
	/** When finished with windup go to the next state */
	simulated function OnStateAnimationEnd()
	{
		ElapsedDrawTime = WorldInfo.TimeSeconds - ElapsedDrawTime;
		super.OnStateAnimationEnd();
	}

	/** The user released the mouse button and we should fire */
	simulated function EndFire(byte FireModeNum)
	{
		if (FireModeNum == Attack_Overhead)
			return;
		else
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

	/** Play windup animation */
	simulated function PlayStateAnimation()
	{
		local AnimationInfo Info; // custom AnimationInfo to pass
		Info = WindupAnimations[0];
		AOCOwner.ReplicateCompressedAnimation(Info, EWST_Windup, 0);
	}

	/** Play appropriate windup animation */
	simulated event BeginState(Name PreviousStateName)
	{
		//AOCOwner.DisableDirectionalDebuffs(true);
		// set time so we know how long user has been drawing for
		ElapsedDrawTime = WorldInfo.TimeSeconds;
		if (CurrentFireMode == Attack_Slash)
		{
			super.BeginState(PreviousStateName);
			AOCOwner.StateVariables.bIsAttacking = true;
		}
		else
			GotoState('Active');
	}

	/** Go into proper state for firing - Changed so that we notify other clients about starting an attack.
	 *  This function called on both server and client.
	 */
	simulated function BeginFire(byte FireModeNum)
	{
		if (FireModeNum == Attack_Parry || FireModeNum == Attack_Overhead)
			GotoState('Recovery');
		else
			bWantToFire = false;
	}
}

/** Release state. Fire the projectile.
 *  Blend back to idle.
 */
simulated state Release
{
	simulated event BeginState(Name PreviousStateName)
	{
		super.BeginState(PreviousStateName);
		ResetFOV();
	}

	/** When finished with release go to the next state */
	simulated function OnStateAnimationEnd()
	{
		GotoState('Active');
	}

	/** Play release animation */
	simulated function PlayStateAnimation()
	{
		local AnimationInfo Info;

		CurrentFireMode = Attack_Slash;
		Info = ReleaseAnimations[CurrentFireMode];
		AOCOwner.ReplicateCompressedAnimation(Info, EWST_Release, CurrentFireMode);

	}

	/** If we decide to do an attack during the windup animation, take note of it and handle during release state */
	simulated function BeginFire(byte FireModeNum)
	{
		if (EAttack(FireModeNum) == Attack_Slash || EAttack(FireModeNum) == Attack_Overhead)
		{
			AttackQueue = EAttack(FireModeNum);
		}
	}

	/** The user released the mouse button and we should fire */
	simulated function EndFire(byte FireModeNum)
	{
		if (FireModeNum == Attack_Overhead)
			return;
		else
			bWantToFire = true;
	}

}

/** Recovery state. User coming back to active/idle after firing weapon.
 */
simulated state Recovery
{
	/** Figure out what the previous state was */
	simulated event BeginState(Name PreviousStateName)
	{
		//AOCOwner.DisableDirectionalDebuffs(false);
		AttackQueue = Attack_Null;
		bWantToFire = false;
		PreviousState = PreviousStateName;
		AOCOwner.StateVariables.bIsParrying = false;
		AOCOwner.StateVariables.bCanDodge = true;
		// no longer need to update abilities...should carry over from windup
		PlayStateAnimation();
		ResetFOV();                                   //prevents left-click-hold > shift-hold > q while in windup from locking in zoomed FOV
	}

	/** Play recovery animation */
	simulated function PlayStateAnimation()
	{
		local AnimationInfo Info; // custom AnimationInfo to pass

		Info = RecoveryAnimations[0];

		//Info.fBlendOutTime = GetRealAnimLength(Info) - 0.05f;
		AOCOwner.ReplicateCompressedAnimation(Info, EWST_Recovery, 0);
	}

	/** If we decide to do an attack during the windup animation, take note of it and handle during release state */
	simulated function BeginFire(byte FireModeNum)
	{
		if (EAttack(FireModeNum) == Attack_Slash || EAttack(FireModeNum) == Attack_Overhead)
		{
			AttackQueue = EAttack(FireModeNum);
		}
	}

	simulated function EndFire(byte FireModeNum)
	{
		if (FireModeNum == Attack_Overhead)
			return;
		else if (AttackQueue != Attack_Null)
			bWantToFire = true;
	}
}

DefaultProperties
{
	fBowDrawCost=0.0f
	bWeaponProjCamEnabled=false
	bWantToFire=false
	CurrentWeaponType = EWEP_Longbow
	// set maximum ammo
	AmmoCount=30
	MaxAmmoCount=30
	AIRange=5000
	bPlayOnWeapon=true

	AttachmentClass=class'AOCWeaponAttachment_Longbow'
	InventoryAttachmentClass=class'AOCInventoryAttachment_Longbow'
	PermanentAttachmentClass(0)=class'AOCInventoryAttachment_LongbowQuiverAgatha'
	PermanentAttachmentClass(1)=class'AOCInventoryAttachment_LongbowQuiverMason'
	bHaveShield=false
	WeaponIdleAnim(0)=3p_longbow_idle01
	WeaponIdentifier="longbow"

	CurrentGenWeaponType=EWT_Longbow
	fExhaustTime = 1.5f
	bIsExhausted=false
	FiringStatesArray(0)=Reload

	StaminaReductionArray(0)=(X=0.0,Y=100.0)
	StaminaReductionArray(1)=(X=1.0,Y=98.0)
	StaminaReductionArray(2)=(X=2.0,Y=96.0)
	StaminaReductionArray(3)=(X=3.0,Y=90.0)
	StaminaReductionArray(4)=(X=4.0,Y=75.0)
	StaminaReductionArray(5)=(X=5.0,Y=50.0)
	StaminaReductionArray(6)=(X=6.0,Y=0.0)

	AttackQueue = Attack_Null

	ProjectileSpawnLocation=ProjLongbowPoint
	StrafeModify=0.75f
	bCanDodge=false
	bUseIdleForTopHalf=true
	bRetIdle=true
	bRetIdleOriginal=true

	// Will Get Modified By Code Based on user selection (yes I do like to capitalize random 1st letters)
	WeaponProjectiles(0)=class'AOCProj_Arrow'

	fSpread = 3500.0f

	fReasonableRefireRate=1.0f

	bNeverFlinch=false

	/*
	 * Formerly in UDKNewWeapon.ini - [AOC.AOCWeapon_Longbow]
	 */
	ConfigProjectileBaseDamage[0]=(Damage=52,InitialSpeed=5000.0,MaxSpeed=5500.0,AmmoCount=25,InitialGravityScale=0.4,Drag=0.0000030,PitchCorrection=50)
	ConfigProjectileBaseDamage[1]=(Damage=53,InitialSpeed=5000.0,MaxSpeed=5500.0,AmmoCount=25,InitialGravityScale=0.4,Drag=0.0000030,PitchCorrection=0)
	ConfigProjectileBaseDamage[2]=(Damage=20,InitialSpeed=5000.0,MaxSpeed=5500.0,AmmoCount=15,InitialGravityScale=0.5,Drag=0.000004,PitchCorrection=0)
	ConfigProjectileBaseDamage[3]=(Damage=0,InitialSpeed=0,MaxSpeed=0,AmmoCount=0,InitialGravityScale=0,Drag=0,PitchCorrection=0.0)
	ConfigProjectileBaseDamage[4]=(Damage=0,InitialSpeed=0,MaxSpeed=0,AmmoCount=0,InitialGravityScale=0,Drag=0,PitchCorrection=0.0)
	ConfigProjectileBaseDamage[5]=(Damage=0,InitialSpeed=0,MaxSpeed=0,AmmoCount=0,InitialGravityScale=0,Drag=0,PitchCorrection=0.0)
	iFeintStaminaCost=0
	WeaponFontSymbol="t"
	WeaponReach=100
	WeaponLargePortrait="UI_WeaponImages_SWF.weapon_select_longbow"
	WeaponSmallPortrait="UI_WeaponImages_SWF.icon_weapon_select_longbow_png"
	HorizontalRotateSpeed=75000.0
	VerticalRotateSpeed=45000.0
	AttackHorizRotateSpeed=40000.0
	SprintAttackHorizRotateSpeed=20000.0
	SprintAttackVerticalRotateSpeed=20000.0
	BattleCryAnim=(AnimationName=3p_longbow_battlecry,ComboAnimation=,AssociatedSoundCue=,bFullBody=true,bCombo=false,bLoop=false,bForce=false,UniqueShieldSound=none,fModifiedMovement=0.0,fAnimationLength=0.0,fBlendInTime=0.00,fBlendOutTime=0.00,bLastAnimation=true)
	WindupAnimations(0)=(AnimationName=3p_longbow_draw,ComboAnimation=,AssociatedSoundCue=SoundCue'A_Combat_Locomotion.Longbow_Reload',bFullBody=False,bCombo=False,bLoop=False,bForce=false,fModifiedMovement=0.75,fAnimationLength=1.2,fBlendInTime=0.10,fBlendOutTime=0.00,bLastAnimation=false,bPlayOnWeapon=true,bUseAltNode=true)
	ReleaseAnimations(0)=(AnimationName=3p_longbow_release,ComboAnimation=,AssociatedSoundCue=SoundCue'A_Combat_Locomotion.Longbow_Attack_01',bFullBody=False,bCombo=False,bLoop=False,bForce=false,fModifiedMovement=1.0,fAnimationLength=0,fBlendInTime=0.00,fBlendOutTime=0.00,bLastAnimation=false,bPlayOnWeapon=true,bUseAltNode=true,bAttachArrow=0)
	ReleaseAnimations(1)=(AnimationName=,ComboAnimation=3p_1hsharp_slash021release,AssociatedSoundCue=SoundCue'A_Combat_Locomotion.Broadsword_Attack_02',bFullBody=False,bCombo=False,bLoop=False,bForce=false,UniqueShieldSound=none,fModifiedMovement=1.0,fAnimationLength=0.0,fBlendInTime=0.00,fBlendOutTime=0.00,bLastAnimation=false)
	ReleaseAnimations(2)=(AnimationName=,ComboAnimation=3p_1hsharp_stabrelease,AssociatedSoundCue=SoundCue'A_Combat_Locomotion.Broadsword_Attack_03',bFullBody=False,bCombo=False,bLoop=False,bForce=false,UniqueShieldSound=none,fModifiedMovement=1.0,fAnimationLength=0.0,fBlendInTime=0.00,fBlendOutTime=0.00,bLastAnimation=false)
	ReleaseAnimations(3)=(AnimationName=,ComboAnimation=,AssociatedSoundCue=SoundCue'A_Combat_Locomotion.broadsword_sprint_attack',bFullBody=True,bCombo=False,bLoop=False,bForce=false,UniqueShieldSound=none,fModifiedMovement=1.0,fAnimationLength=0.0,fBlendInTime=0.00,fBlendOutTime=0.00,bLastAnimation=false)
	ReleaseAnimations(4)=(AnimationName=,ComboAnimation=,AssociatedSoundCue=SoundCue'A_Combat_Locomotion.Broadsword_Parry',bFullBody=False,bCombo=False,bLoop=False,bForce=false,UniqueShieldSound=none,fModifiedMovement=1.0,fAnimationLength=0.0,fBlendInTime=0.00,fBlendOutTime=0.00,bLastAnimation=false)
	ReleaseAnimations(5)=(AnimationName=,ComboAnimation=,AssociatedSoundCue=,bFullBody=True,bCombo=False,bLoop=False,bForce=false,UniqueShieldSound=none,fModifiedMovement=1.0,fAnimationLength=0.0,fBlendInTime=0.00,fBlendOutTime=0.00,bLastAnimation=false)
	ReleaseAnimations(6)=(AnimationName=,ComboAnimation=,AssociatedSoundCue=,bFullBody=false,bCombo=false,bLoop=false,bForce=false,UniqueShieldSound=none,fModifiedMovement=1.0,fAnimationLength=0.0,fBlendInTime=0.00,fBlendOutTime=0.00,bLastAnimation=false)
	ReleaseAnimations(7)=(AnimationName=,ComboAnimation=,AssociatedSoundCue=,bFullBody=false,bCombo=false,bLoop=false,bForce=false,UniqueShieldSound=none,fModifiedMovement=1.0,fAnimationLength=0.0,fBlendInTime=0.00,fBlendOutTime=0.00,bLastAnimation=false)
	ReleaseAnimations(8)=(AnimationName=3p_longbow_equipup,ComboAnimation=,AssociatedSoundCue=SoundCue'A_Combat_Locomotion.longbow_draw',bFullBody=false,bCombo=false,bLoop=false,bForce=false,UniqueShieldSound=none,fModifiedMovement=1.0,fAnimationLength=0.5,fBlendInTime=0.00,fBlendOutTime=0.01,bLastAnimation=false)
	ReleaseAnimations(9)=(AnimationName=3p_longbow_equipdown,ComboAnimation=,AssociatedSoundCue=SoundCue'A_Combat_Locomotion.longbow_sheath',bFullBody=false,bCombo=false,bLoop=false,bForce=false,UniqueShieldSound=none,fModifiedMovement=1.0,fAnimationLength=0.2,fBlendInTime=0.00,fBlendOutTime=0.01,bLastAnimation=false)
	RecoveryAnimations(0)=(AnimationName=3p_longbow_drawtoidle,ComboAnimation=,AssociatedSoundCue=,bFullBody=false,bCombo=false,bLoop=false,bForce=false,fModifiedMovement=1.0,fAnimationLength=0.8,fBlendInTime=0.0,fBlendOutTime=0.10,bLastAnimation=true,bPlayOnWeapon=true,bUseAltNode=true,bAttachArrow=1)
	RecoveryAnimations(1)=(AnimationName=3p_longbow_reloadrecover,ComboAnimation=,AssociatedSoundCue=,bFullBody=false,bCombo=false,bLoop=false,bForce=false,fModifiedMovement=1.0,fAnimationLength=0.333,fBlendInTime=0.1,fBlendOutTime=0.10,bLastAnimation=true,bUseAltNode=true)
	HoldAnimations[0]=(AnimationName=3p_longbow_drawidle01,ComboAnimation=,AssociatedSoundCue=,bFullBody=false,bCombo=false,bLoop=true,bForce=false,fModifiedMovement=0.6,fAnimationLength=0.0,fBlendInTime=0.0,fBlendOutTime=0.00,bLastAnimation=false,bPlayOnWeapon=true,bUseAltNode=true)
	HoldAnimations[1]=(AnimationName=3p_longbow_drawidle02,ComboAnimation=,AssociatedSoundCue=,bFullBody=false,bCombo=false,bLoop=true,bForce=false,fModifiedMovement=1.0,fAnimationLength=0.0,fBlendInTime=0.0,fBlendOutTime=0.00,bLastAnimation=false,bPlayOnWeapon=true,bUseAltNode=true)
	ReloadAnimations[0]=(AnimationName=3p_longbow_reload,ComboAnimation=,AssociatedSoundCue=,bFullBody=false,bCombo=false,bLoop=false,bForce=false,fModifiedMovement=1.0,fAnimationLength=1.2,fBlendInTime=0.0,fBlendOutTime=0.10,bLastAnimation=false,bPlayOnWeapon=true,bUseAltNode=true,bAttachArrow=1)
	StateAnimations(0)=(AnimationName=3p_1hsharp_parried,ComboAnimation=,AssociatedSoundCue=,bFullBody=false,bCombo=false,bLoop=false,bForce=false,UniqueShieldSound=none,fModifiedMovement=1.0,fAnimationLength=0.8,fBlendInTime=0.00,fBlendOutTime=0.08,bLastAnimation=true)
	StateAnimations(1)=(AnimationName=3p_longbow_dazed,ComboAnimation=,AssociatedSoundCue=,bFullBody=false,bCombo=false,bLoop=false,bForce=false,UniqueShieldSound=none,fModifiedMovement=1.0,fAnimationLength=0.2,fBlendInTime=0.00,fBlendOutTime=0.00,bLastAnimation=true)
	StateAnimations(2)=(AnimationName=3p_longbow_hit1,ComboAnimation=,AssociatedSoundCue=,bFullBody=true,bCombo=false,bLoop=false,bForce=false,UniqueShieldSound=none,fModifiedMovement=1.0,fAnimationLength=0.9,fBlendInTime=0.00,fBlendOutTime=0.00,bLastAnimation=true)
	StateAnimations(3)=(AnimationName=3p_longbow_hit1,ComboAnimation=,AssociatedSoundCue=,bFullBody=true,bCombo=false,bLoop=false,bForce=false,UniqueShieldSound=none,fModifiedMovement=1.0,fAnimationLength=0.9,fBlendInTime=0.00,fBlendOutTime=0.00,bLastAnimation=true)
	StateAnimations(4)=(AnimationName=3p_longbow_hit1,ComboAnimation=,AssociatedSoundCue=,bFullBody=false,bCombo=false,bLoop=false,bForce=false,UniqueShieldSound=none,fModifiedMovement=1.0,fAnimationLength=0.4,fBlendInTime=0.00,fBlendOutTime=0.08,bLastAnimation=false)
	TurnInfo(0)=(AnimationName=3p_1hsharp_turnL,ComboAnimation=,AssociatedSoundCue=,bFullBody=false,bCombo=false,bLoop=true,bForce=false,UniqueShieldSound=none,fModifiedMovement=1.0,fAnimationLength=0.0,fBlendInTime=0.00,fBlendOutTime=0.0,bLastAnimation=false,bLowerBody=true)
	TurnInfo(1)=(AnimationName=3p_1hsharp_turnR,ComboAnimation=,AssociatedSoundCue=,bFullBody=false,bCombo=false,bLoop=true,bForce=false,UniqueShieldSound=none,fModifiedMovement=1.0,fAnimationLength=0.0,fBlendInTime=0.00,fBlendOutTime=0.0,bLastAnimation=false)
	DazedAnimations(0)=(AnimationName=3p_longbow_dazedB01,ComboAnimation=,AssociatedSoundCue=,bFullBody=false,bCombo=false,bLoop=false,bForce=false,UniqueShieldSound=none,fModifiedMovement=1.0,fAnimationLength=1.1,fBlendInTime=0.00,fBlendOutTime=0.00,bLastAnimation=true)
	DazedAnimations(1)=(AnimationName=3p_longbow_dazedR01,ComboAnimation=,AssociatedSoundCue=,bFullBody=false,bCombo=false,bLoop=false,bForce=false,UniqueShieldSound=none,fModifiedMovement=1.0,fAnimationLength=1.1,fBlendInTime=0.00,fBlendOutTime=0.00,bLastAnimation=true)
	DazedAnimations(2)=(AnimationName=3p_longbow_dazedF01,ComboAnimation=,AssociatedSoundCue=,bFullBody=false,bCombo=false,bLoop=false,bForce=false,UniqueShieldSound=none,fModifiedMovement=1.0,fAnimationLength=1.1,fBlendInTime=0.00,fBlendOutTime=0.00,bLastAnimation=true)
	DazedAnimations(3)=(AnimationName=3p_longbow_dazedL01,ComboAnimation=,AssociatedSoundCue=,bFullBody=false,bCombo=false,bLoop=false,bForce=false,UniqueShieldSound=none,fModifiedMovement=1.0,fAnimationLength=1.1,fBlendInTime=0.00,fBlendOutTime=0.00,bLastAnimation=true)
	DazedAnimations(4)=(AnimationName=3p_longbow_dazedBL,ComboAnimation=,AssociatedSoundCue=,bFullBody=false,bCombo=false,bLoop=false,bForce=false,UniqueShieldSound=none,fModifiedMovement=1.0,fAnimationLength=1.1,fBlendInTime=0.00,fBlendOutTime=0.00,bLastAnimation=true)
	DazedAnimations(5)=(AnimationName=3p_longbow_dazedBR,ComboAnimation=,AssociatedSoundCue=,bFullBody=false,bCombo=false,bLoop=false,bForce=false,UniqueShieldSound=none,fModifiedMovement=1.0,fAnimationLength=1.1,fBlendInTime=0.00,fBlendOutTime=0.00,bLastAnimation=true)
	DazedAnimations(6)=(AnimationName=3p_longbow_dazedFL,ComboAnimation=,AssociatedSoundCue=,bFullBody=false,bCombo=false,bLoop=false,bForce=false,UniqueShieldSound=none,fModifiedMovement=1.0,fAnimationLength=1.1,fBlendInTime=0.00,fBlendOutTime=0.00,bLastAnimation=true)
	DazedAnimations(7)=(AnimationName=3p_longbow_dazedFR,ComboAnimation=,AssociatedSoundCue=,bFullBody=false,bCombo=false,bLoop=false,bForce=false,UniqueShieldSound=none,fModifiedMovement=1.0,fAnimationLength=1.1,fBlendInTime=0.00,fBlendOutTime=0.00,bLastAnimation=true)
	DirHitAnimation(0)=(AnimationName=ADD_3p_longbow_hitFL,ComboAnimation=,AssociatedSoundCue=,bFullBody=false,bCombo=false,bLoop=false,bForce=false,UniqueShieldSound=none,fModifiedMovement=1.0,fAnimationLength=0.4,fBlendInTime=0.00,fBlendOutTime=0.1,bLastAnimation=false,bUseSlotSystem=true)
	DirHitAnimation(1)=(AnimationName=ADD_3p_longbow_hitFR,ComboAnimation=,AssociatedSoundCue=,bFullBody=false,bCombo=false,bLoop=false,bForce=false,UniqueShieldSound=none,fModifiedMovement=1.0,fAnimationLength=0.4,fBlendInTime=0.00,fBlendOutTime=0.1,bLastAnimation=false,bUseSlotSystem=true)
	DirHitAnimation(2)=(AnimationName=ADD_3p_longbow_hitBL,ComboAnimation=,AssociatedSoundCue=,bFullBody=false,bCombo=false,bLoop=false,bForce=false,UniqueShieldSound=none,fModifiedMovement=1.0,fAnimationLength=0.4,fBlendInTime=0.00,fBlendOutTime=0.1,bLastAnimation=false,bUseSlotSystem=true)
	DirHitAnimation(3)=(AnimationName=ADD_3p_longbow_hitBR,ComboAnimation=,AssociatedSoundCue=,bFullBody=false,bCombo=false,bLoop=false,bForce=false,UniqueShieldSound=none,fModifiedMovement=1.0,fAnimationLength=0.4,fBlendInTime=0.00,fBlendOutTime=0.1,bLastAnimation=false,bUseSlotSystem=true)
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
