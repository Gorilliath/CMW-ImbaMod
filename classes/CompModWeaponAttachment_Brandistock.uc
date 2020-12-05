/**
* Copyright 2010-2012, Torn Banner Studios, All rights reserved
*
* Original Author: Michael Bao
*
* Weapon Attachment: Brandistock.
*/
class CompModWeaponAttachment_Brandistock extends AOCWeaponAttachment_Brandistock;

DefaultProperties
{

KickOffset=(X=50, Y=0, Z=-65)
	KickSize=20.f

	Begin Object Name=SkeletalMeshComponent0
		SkeletalMesh=SkeletalMesh'WP_spr_Spear.WEP_spear'
	End Object

	Begin Object Name=SkeletalMeshComponent2
		SkeletalMesh=SkeletalMesh'WP_spr_Spear.WEP_spear'
	End Object

	WeaponID=EWEP_Brandistock
	WeaponClass=class'CompModWeapon_Brandistock'
	WeaponSocket=wep2hpoint

	AttackTypeInfo(0)=(fBaseDamage=50.0, fForce=37500, cDamageType="AOC.AOCDmgType_Blunt", iWorldHitLenience=6)
	AttackTypeInfo(1)=(fBaseDamage=95.0, fForce=34000, cDamageType="AOC.AOCDmgType_Pierce", iWorldHitLenience=6)
	AttackTypeInfo(2)=(fBaseDamage=65.0, fForce=27000, cDamageType="AOC.AOCDmgType_Pierce", iWorldHitLenience=6)
	AttackTypeInfo(3)=(fBaseDamage=100.0, fForce=65000, cDamageType="AOC.AOCDmgType_Pierce", iWorldHitLenience=6)
	AttackTypeInfo(4)=(fBaseDamage=0.0, fForce=32500, cDamageType="AOC.AOCDmgType_Pierce", iWorldHitLenience=6)
	AttackTypeInfo(5)=(fBaseDamage=5.0, fForce=45500.0, cDamageType="AOC.AOCDmgType_Shove", iWorldHitLenience=12)

	Skins(0)={(
		SkeletalMeshPath="WP_spr_Brandistock.WEP_brandistock",
		StaticMeshPath="WP_spr_Brandistock.sm_brandistock",
		MaterialPath="",
		StaticMeshScale=1.0,
		ImagePath="UI_CustWeaponImages_SWF.skin_brandistock_png"
		)};

	Skins(1)={(
		SkeletalMeshPath="WP_spr_Brandistock_Variant_01.WEP_brandistock",
		StaticMeshPath="WP_spr_Brandistock_Variant_01.SM_brandistock",
		MaterialPath="",
		StaticMeshScale=1.0,
		ImagePath="UI_CustWeaponImages_SWF.skin_fist_burning_sun_png"
		)};

	Skins(2)={(
		SkeletalMeshPath="WP_spr_Brandistock_variant_02.WEP_brandistock_variant_02",
		StaticMeshPath="WP_spr_Brandistock_variant_02.SM_brandistock_variant_02",
		MaterialPath="",
		StaticMeshScale=1.0,
		ImagePath="UI_CustWeaponImages_SWF.skin_sharp_claw_png"
		)};
}
