class ImbaModProj_ThrownOilPot extends AOCProj_ThrownOilPot;


function checkNearPlayersToBurn()
{
	local AOCPawn P;
	local AOCStaticMeshActor_PaviseShield Pavise;
	local float distFromPawn;

	foreach WorldInfo.AllPawns(class'AOCPawn', P)
	{
	//	`log("CHECK PAWN"@P.IsAliveAndWell()@P.bInfiniteHealth);
		if (P.IsAliveAndWell() && !P.bInfiniteHealth && P.RealityID == RealityID)
		{
			distFromPawn = VSizeSq(BurnLocation - P.Location);
			//`log("DIST FROM PAWN"@distFromPawn@fFireRadius@P);
			if (distFromPawn <= fFireRadius && bBurnFirstTick)
			{
				// Changed so the first tick no longer inflicts full DOT
				P.SetPawnOnFire(FirePS, OwnerPawn.Controller, OwnerPawn, , WalkOverBurnTime);
			}
			else if (distFromPawn <= fFireRadius && !P.bIsBurning)
			{
				P.SetPawnOnFire(FirePS, OwnerPawn.Controller, OwnerPawn, , WalkOverBurnTime);
			}
		}
	}


	// Check for nearby pavise shields
	foreach WorldInfo.AllActors(class'AOCStaticMeshActor_PaviseShield', Pavise)
	{
		if (Pavise.Health > 0)
		{
			Pavise.AOCTakeDamage(9999, Pavise.Location, Vect(0.f, 0.f, 0.f), none, class'AOCDmgType_Burn');
		}
	}

	bBurnFirstTick = false;
}

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

	//`log("CONTINUE BURN"@HitLocation@HitNormal);
	ExpData.Loc = HitLocation;
	ExpData.Norm = HitNormal;
	ExpData.bForce = !ExpData.bForce;

	if (WorldInfo.NetMode == NM_Standalone || Worldinfo.NetMode == NM_ListenServer)
		ReplicatedEvent('ExpData');

	bForceNetUpdate = true;
	bNetDirty = true;

	// If we hit a pawn, set it on fire
	if (!bHitWorld && AOCPawn(ImpactedActor) != none)
	{
		// Changed so the first tick no longer inflicts full DOT
		AOCPawn(ImpactedActor).SetPawnOnFire(FirePS, OwnerPawn.Controller, OwnerPawn, , WalkOverBurnTime);
	}
	if(!bHitWorld && AOCBurnableItem(ImpactedActor) != none)
	{
		AOCBurnableItem(ImpactedActor).Ignite(true, HitLocation);
		SpawnBurnDecal(HitLocation, HitNormal);
	}

	BurnLocation = HitLocation;
	SetTimer(0.2f, true, 'checkNearPlayersToBurn');
	findLandingSpot(HitLocation, HitNormal);
	SetTimer(fFireDieOut, false, 'Shutdown');
	bBurnNoMore = true;
	bDamagedSomething=true;
}

DefaultProperties
{
	Begin Object Name=StaticMeshComponent0
		StaticMesh=StaticMesh'WP_throw_Pots.SM_oil_pot'
		Scale=1.0
		Rotation=(Pitch=49500)
	End Object
	
	ProjExplosionTemplate=ParticleSystem'CHV_PartiPack.Particles.P_Fire_Burst_Burn'
	ProjFlightTemplate=ParticleSystem'CHV_PartiPack.Particles.P_firepot_trail'
	FirePS=ParticleSystem'CHV_PartiPack.Particles.P_fire_blazing_grow1_nosmoke'

	MyBurnDecal=DecalMaterial'CHV_DecalGen.MD_burn_scorch_mark'

	ExplosionLightClass=class'UTGame.UTRocketExplosionLight'
	ExplosionSound=SoundCue'A_Phys_Mat_Impacts.oilpot_fire'

	bSuppressExplosionFX=false
	speed=1500.0
	MaxSpeed=1500.0
	Damage=1.0
	MomentumTransfer=500
	LifeSpan=30.0
	bCollideWorld=true
	bBounce=false
	Physics=PHYS_Falling
	CheckRadius=36.0
	CustomGravityScaling=0.6
	
	fFireRadius=35000.0
	fFireDieOut=7.0
	bExploded=false
	DamageRadius=0.0
	bAdvanceExplosionEffect=false
	bAlwaysRelevant=true

	//TODO randomize this 
	YawRate = 1000.0f
	PitchRate = 100000.0f
	RollRate = 9000.0f

	AmbientSound=SoundCue'A_Projectile_Flight.Flight_Oilpot'
	ImpactSound=SoundCue'A_Phys_Mat_Impacts.oilpot_break'

	bNetTemporary=False
	bWaitForEffects=false

	bBurnNoMore=false
	fProjectileAttachCompensation=2.0f
	bCanPickupProj=false

	ProjCamPosModX=-60
	ProjCamPosModZ=25
	bBurnFirstTick=true

	WalkOverBurnTime = 2.0f
}

