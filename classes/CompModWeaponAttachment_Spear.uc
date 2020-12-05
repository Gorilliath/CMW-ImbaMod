/**
* Copyright 2010-2012, Torn Banner Studios, All rights reserved
*
* Original Author: Michael Bao
*
* Weapon Attachment: Spear.
*/
class CompModWeaponAttachment_Spear extends AOCWeaponAttachment_Spear;

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

	WeaponID=EWEP_Spear
	WeaponClass=class'CompModWeapon_Spear'
	WeaponSocket=wep2hpoint
	bUseAlternativeKick=true

	WeaponStaticMeshScale=1

	AttackTypeInfo(0)=(fBaseDamage=30.0, fForce=37000, cDamageType="AOC.AOCDmgType_Blunt", iWorldHitLenience=6)
	AttackTypeInfo(1)=(fBaseDamage=70.0, fForce=26775, cDamageType="AOC.AOCDmgType_Pierce", iWorldHitLenience=6)
	AttackTypeInfo(2)=(fBaseDamage=55.0, fForce=26000, cDamageType="AOC.AOCDmgType_Pierce", iWorldHitLenience=6)
	AttackTypeInfo(3)=(fBaseDamage=100.0, fForce=65000, cDamageType="AOC.AOCDmgType_Pierce", iWorldHitLenience=6)
	AttackTypeInfo(4)=(fBaseDamage=0.0, fForce=32500, cDamageType="AOC.AOCDmgType_Pierce", iWorldHitLenience=6)
	AttackTypeInfo(5)=(fBaseDamage=5.0, fForce=45500.0, cDamageType="AOC.AOCDmgType_Shove", iWorldHitLenience=12)

	Skins(0)={(
		SkeletalMeshPath="WP_spr_Spear.WEP_spear",
		StaticMeshPath="WP_spr_Spear.sm_spear",
		MaterialPath="",
		StaticMeshScale=1.0,
		ImagePath="UI_CustWeaponImages_SWF.skin_spear_png"
		)};
	Skins(1)={(
		SkeletalMeshPath="WP_spr_Spear_variant_01.Meshes.WEP_spear_variant_01",
		StaticMeshPath="WP_spr_Spear_variant_01.Meshes.sm_spear_variant_01",
		MaterialPath="",
		StaticMeshScale=1.0,
		ImagePath="UI_CustWeaponImages_SWF.skin_chargebreaker_png"
		)};
	Skins(2)={(
		SkeletalMeshPath="WP_spr_Spear_Variant_02.WEP_spear_honorsguard_01",
		StaticMeshPath="WP_spr_Spear_Variant_02.SM_spear_honorsguard_01",
		MaterialPath="",
		StaticMeshScale=1.0,
		ImagePath="UI_CustWeaponImages_SWF.skin_honors_guard_spear_png"
		)};
	Skins(3)={(
		SkeletalMeshPath="WP_spr_Spear_variant_03.WEP_shatteredstar",
		StaticMeshPath="WP_spr_Spear_variant_03.SM_shatteredstar",
		MaterialPath="",
		StaticMeshScale=1.0,
		ImagePath="UI_CustWeaponImages_SWF.skin_shattered_star_png"
		)};
	Skins(4)={(
		SkeletalMeshPath="WP_spr_Spear_Variation_04.WEP_Spear_Variation_03",
		StaticMeshPath="WP_spr_Spear_Variation_04.SM_Spear_Variation_03",
		MaterialPath="",
		StaticMeshScale=1.0,
		ImagePath="ui_custweaponimages_swf.skin_awl_pike_png"
		)};
	Skins(5)={(
		SkeletalMeshPath="WP_spr_Spear_variant_05.WEP_spear_v05",
		StaticMeshPath="WP_spr_Spear_variant_05.SM_spear_v05",
		MaterialPath="",
		StaticMeshScale=1.0,
		ImagePath="ui_custweaponimages_swf.skin_fleurDeLis_png"
		)};
}
