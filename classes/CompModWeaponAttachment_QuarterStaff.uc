/**
* Copyright 2010-2012, Torn Banner Studios, All rights reserved
* 
* Original Author: Michael Bao
* 
* Quarter Staff Weapon Attachment.
*/
class CompModWeaponAttachment_QuarterStaff extends AOCWeaponAttachment_QuarterStaff;

defaultproperties
{

KickOffset=(X=50, Y=0, Z=-65)
	KickSize=20.f

	Begin Object Name=SkeletalMeshComponent0
		SkeletalMesh=SkeletalMesh'WP_DL1_quarterstaff.WEP_quarterstaff'
	End Object

	Begin Object Name=SkeletalMeshComponent2
		SkeletalMesh=SkeletalMesh'WP_DL1_quarterstaff.WEP_quarterstaff'
	End Object

	WeaponID=EWEP_QStaff
	WeaponClass=class'CompModWeapon_QuarterStaff'

	WeaponSocket=wepQstaffpoint
	bUseAlternativeKick=true

	WeaponStaticMeshScale=1

	AttackTypeInfo(0)=(fBaseDamage=45.0, fForce=22500, cDamageType="AOC.AOCDmgType_Blunt", iWorldHitLenience=6)
	AttackTypeInfo(1)=(fBaseDamage=50.0, fForce=22500, cDamageType="AOC.AOCDmgType_Blunt", iWorldHitLenience=6)
	AttackTypeInfo(2)=(fBaseDamage=45.0, fForce=22500, cDamageType="AOC.AOCDmgType_Blunt", iWorldHitLenience=6)
	AttackTypeInfo(3)=(fBaseDamage=0.0, fForce=22500, cDamageType="AOC.AOCDmgType_Blunt", iWorldHitLenience=6)
	AttackTypeInfo(4)=(fBaseDamage=0.0, fForce=22500, cDamageType="AOC.AOCDmgType_Blunt", iWorldHitLenience=6)
	AttackTypeInfo(5)=(fBaseDamage=5.0, fForce=45500.0, cDamageType="AOC.AOCDmgType_Shove", iWorldHitLenience=12)

	Skins(0)={(
		SkeletalMeshPath="WP_DL1_quarterstaff.WEP_quarterstaff",
		StaticMeshPath="WP_DL1_quarterstaff.SM_quarterstaff",
		MaterialPath="",
		StaticMeshScale=1.0,
		ImagePath="UI_CustWeaponImages_SWF.skin_quarterstaff_png"
		)};
	Skins(1)={(
		SkeletalMeshPath="WP_DL1_quarterstaff_Variation_01.WEP_quarterstaff",
		StaticMeshPath="WP_DL1_quarterstaff_Variation_01.SM_quarterstaff",
		MaterialPath="",
		StaticMeshScale=1.0,
		ImagePath="UI_CustWeaponImages_SWF.skin_fleshpound_quarterstaff_png"
		)};
	Skins(2)={(
		SkeletalMeshPath="WP_DL1_quarterstaff_variant_02.WEP_quarterstaff_variant_01",
		StaticMeshPath="WP_DL1_quarterstaff_variant_02.SM_quarterstaff",
		MaterialPath="",
		StaticMeshScale=1.0,
		ImagePath="UI_CustWeaponImages_SWF.skin_thornstaff_png"
		)};
}