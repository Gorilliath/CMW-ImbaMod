/**
* Copyright 2010-2012, Torn Banner Studios, All rights reserved
* 
* Original Author: Michael Bao
* 
* The Weapon Attachment for the Broad Dagger.
*/
class CompModWeaponAttachment_BroadDagger extends AOCWeaponAttachment_BroadDagger;

DefaultProperties
{

KickOffset=(X=50, Y=0, Z=-65)
	KickSize=20.f

	Begin Object Name=SkeletalMeshComponent0
		SkeletalMesh=SkeletalMesh'WP_dag_BroadDagger.WEP_broadDagger'
		Scale=1.2
	End Object

	Begin Object Name=SkeletalMeshComponent2
		SkeletalMesh=SkeletalMesh'WP_dag_BroadDagger.WEP_broadDagger'
		Scale=1.2
	End Object

	WeaponID=EWEP_BroadDagger
	WeaponClass=class'CompModWeapon_BroadDagger'
	WeaponSocket=wep1hpoint

	AttackTypeInfo(0)=(fBaseDamage=35.0, fForce=10000, cDamageType="AOC.AOCDmgType_Swing", iWorldHitLenience=6)
	AttackTypeInfo(1)=(fBaseDamage=40.0, fForce=10000, cDamageType="AOC.AOCDmgType_Pierce", iWorldHitLenience=6)
	AttackTypeInfo(2)=(fBaseDamage=35.0, fForce=10000, cDamageType="AOC.AOCDmgType_Pierce", iWorldHitLenience=6)
	AttackTypeInfo(3)=(fBaseDamage=0.0, fForce=22500, cDamageType="AOC.AOCDmgType_Swing", iWorldHitLenience=6)
	AttackTypeInfo(4)=(fBaseDamage=0.0, fForce=22500, cDamageType="AOC.AOCDmgType_Swing", iWorldHitLenience=6)
	AttackTypeInfo(5)=(fBaseDamage=5.0, fForce=45500.0, cDamageType="AOC.AOCDmgType_Shove", iWorldHitLenience=12)

	Skins(0)={(
		SkeletalMeshPath="WP_dag_BroadDagger.WEP_broadDagger",
		StaticMeshPath="WP_dag_BroadDagger.Broad_Dagger.Broad_Dagger",
		MaterialPath="",
		StaticMeshScale=1.0,
		ImagePath=""
		)};
}
