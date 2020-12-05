/**
* Copyright 2010-2012, Torn Banner Studios, All rights reserved
*
* Original Author: Richard Pragnell
*
* Smoke Pot projectile.
*/

class CompModProj_ThrownSmokePot extends AOCProj_ThrownOilPot;

/**
 *  Burn baby burn
 */
simulated function Burn(bool bHitWorld, optional vector HitLocation, optional Vector HitNormal)
{
	local ProjectileBaseInfo BaseInfo;
	if (bBurnNoMore)
		return;

	HideProjectile();
	SetCollision(false,false);

	if (OwnerPawn.Role != ROLE_Authority)
	{
		// 5 - bHitWorld = false
		// 6 - bHitWorld = true
		BaseInfo.bHitWorld = bHitWorld;
		PassImmediateShutdownToServer(BaseInfo, HitLocation, HitNormal);

		// Gonna have to spawn effects here -- handles for player who threw -- will never replicate back
		if (OwnerPawn.IsLocallyControlled())
		{
			SpawnExplosionEffects(HitLocation, HitNormal);
			SpawnBurnDecal(HitLocation, HitNormal);
		}

		SetTimer(fFireDieOut, false, 'Shutdown');
		return;
	}

	ExpData.Loc = HitLocation;
	ExpData.Norm = HitNormal;
	ExpData.bForce = !ExpData.bForce;

	if (WorldInfo.NetMode == NM_Standalone || Worldinfo.NetMode == NM_ListenServer)
		ReplicatedEvent('ExpData');

	bForceNetUpdate = true;
	bNetDirty = true;

	findLandingSpot(HitLocation, HitNormal);
	SetTimer(fFireDieOut, false, 'Shutdown');
	bBurnNoMore = true;
	bDamagedSomething=true;
}

DefaultProperties
{
	Begin Object Name=StaticMeshComponent0
		StaticMesh=StaticMesh'WP_throw_Pots.SM_smoke_pot'
		Scale=1.0
		Rotation=(Pitch=49500)
	End Object

	ProjExplosionTemplate=ParticleSystem'CHV_PartiPack.Particles.P_smokepot'
	ProjFlightTemplate=none

	speed=2000.0
	MaxSpeed=2500.0
	Damage=1.0
	MomentumTransfer=500
	LifeSpan=30.0
	bCollideWorld=true
	bBounce=false
	Physics=PHYS_Falling
	CheckRadius=36.0
	CustomGravityScaling=0.6

	bExploded=false
	DamageRadius=0.0
	bAdvanceExplosionEffect=false

	//TODO randomize this
	YawRate = 1000.0f
	PitchRate = 100000.0f
	RollRate = 9000.0f
	fFireDieOut=20.0

	AmbientSound=SoundCue'A_Projectile_Flight.Flight_Oilpot'
	ImpactSound=SoundCue'A_Phys_Mat_Impacts.oilpot_break'

	bNetTemporary=False
	bWaitForEffects=false

	FirePS=ParticleSystem'CHV_PartiPack.Particles.P_firepot_static'
	fProjectileAttachCompensation=2.0f
	bCanPickupProj=false

	ProjCamPosModX=-60
	ProjCamPosModZ=25
}
