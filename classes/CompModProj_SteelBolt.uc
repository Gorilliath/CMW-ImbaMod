/**
* Copyright 2010-2012, Torn Banner Studios, All rights reserved
*
* Original Author: Michael Bao
*
* Steel Bolt
*/
class CompModProj_SteelBolt extends AOCProj_SteelBolt;

defaultproperties
{
	ProjType = EPROJ_Steel
	Begin Object Name=StaticMeshComponent0
		StaticMesh=StaticMesh'WP_xbw_Crossbow.StaticMeshes.Bolt_STATMESH'
		//Rotation=(Yaw=49500)
		Scale=1.0
	End Object	
	ProjFlightTemplate=ParticleSystem'CHV_Particles_01.Particles.P_ArrowTrail'
	AttachmentMesh=SkeletalMesh'WP_xbw_Crossbow.WEP_Bolt'
	CustomGravityScaling=0.1
	fProjectileAttachCompensation=9.0f

	AmbientSound=SoundCue'A_Projectile_Flight.Flight_Arrow'
	ImpactSounds= {(
		Light=SoundCue'A_Impacts_Missile.Arrow_Light',
		Medium=SoundCue'A_Impacts_Missile.Arrow_Medium',
		Heavy=SoundCue'A_Impacts_Missile.Arrow_Heavy',
		Stone=SoundCue'A_Phys_Mat_Impacts.arrow_Stone',
		Dirt=SoundCue'A_Phys_Mat_Impacts.arrow_Dirt',
		Wood=SoundCue'A_Phys_Mat_Impacts.arrow_Wood',
		Gravel=SoundCue'A_Phys_Mat_Impacts.arrow_Dirt',
		Foliage=SoundCue'A_Phys_Mat_Impacts.arrow_Dirt',
		Sand=SoundCue'A_Phys_Mat_Impacts.arrow_Dirt',
		Water=SoundCue'A_Phys_Mat_Impacts.arrow_water',
		ShallowWater=SoundCue'A_Phys_Mat_Impacts.arrow_water',
		Metal=SoundCue'A_Phys_Mat_Impacts.arrow_metal',
		Snow=SoundCue'A_Phys_Mat_Impacts.arrow_Dirt',
		Ice=SoundCue'A_Phys_Mat_Impacts.arrow_Dirt',
		Mud=SoundCue'A_Phys_Mat_Impacts.arrow_Dirt',
		Tile=SoundCue'A_Phys_Mat_Impacts.arrow_Dirt')
	}
	YawRate = 0.0f
	PitchRate = 0.0f
	RollRate = 0.0f
	bCanPickupProj=false
}