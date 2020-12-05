/**
* Copyright 2010-2012, Torn Banner Studios, All rights reserved
* 
* Original Author: Michael Bao
* 
* The weapon that is replicated to all clients: Messer 1H
*/
class CompModWeaponAttachment_Messer1H extends AOCWeaponAttachment_Messer1H;

DefaultProperties
{


KickOffset=(X=50, Y=0, Z=-65)
	KickSize=20.f

	WeaponID=EWEP_Messer
	WeaponClass=class'CompModWeapon_Messer1H'
	WeaponSocket=wep1hpoint

	bUseAlternativeKick=true

	WeaponStaticMeshScale=1

	AttackTypeInfo(0)=(fBaseDamage=80.0, fForce=22500, cDamageType="AOC.AOCDmgType_Swing", iWorldHitLenience=6)
	AttackTypeInfo(1)=(fBaseDamage=75.0, fForce=22500, cDamageType="AOC.AOCDmgType_SwingBlunt", iWorldHitLenience=6)
	AttackTypeInfo(2)=(fBaseDamage=50.0, fForce=22500, cDamageType="AOC.AOCDmgType_Pierce", iWorldHitLenience=6)
	AttackTypeInfo(3)=(fBaseDamage=0.0, fForce=22500, cDamageType="AOC.AOCDmgType_SwingBlunt", iWorldHitLenience=6)
	AttackTypeInfo(4)=(fBaseDamage=0.0, fForce=22500, cDamageType="AOC.AOCDmgType_SwingBlunt", iWorldHitLenience=6)
	AttackTypeInfo(5)=(fBaseDamage=5.0, fForce=45500.0, cDamageType="AOC.AOCDmgType_Shove", iWorldHitLenience=12)

	Skins(0)={(
		SkeletalMeshPath="WP_15hs_Messer.Messer.wep_messer",
		StaticMeshPath="WP_15hs_Messer.Messer.sm_messer",
		MaterialPath="",
		StaticMeshScale=1.0,
		ImagePath="UI_CustWeaponImages_SWF.skin_messer_png"
		)};
	Skins(1)={(
		SkeletalMeshPath="WP_15hs_Messer_Variant_01.Mesh.wep_messer_variant_01",
		StaticMeshPath="WP_15hs_Messer_Variant_01.Mesh.sm_messer_variant_01",
		MaterialPath="",
		StaticMeshScale=1.0,
		ImagePath="UI_CustWeaponImages_SWF.skin_butchers_messer_png"
		)};
	Skins(2)={(
		SkeletalMeshPath="WP_15hs_Messer_Variant_02.messer.wep_messer",
		StaticMeshPath="WP_15hs_Messer_Variant_02.messer.sm_messer",
		MaterialPath="",
		StaticMeshScale=1.0,
		ImagePath="UI_CustWeaponImages_SWF.skin_ornate_messer_png"
		)};
	Skins(3)={(
		SkeletalMeshPath="WP_15hs_Messer_Variant_03.WEP_Messer_Varaint_02",
		StaticMeshPath="WP_15hs_Messer_Variant_03.SM_Messer_Varaint_02",
		MaterialPath="",
		StaticMeshScale=1.0,
		ImagePath="ui_custweaponimages_swf.skin_infidels_bane_png"
		)};
	Skins(4)={(
		SkeletalMeshPath="WP_15hs_Messer_Variant_04.WEP_ChaosMesser",
		StaticMeshPath="WP_15hs_Messer_Variant_04.WEP_ChaosMesser",
		MaterialPath="",
		StaticMeshScale=1.0,
		ImagePath="ui_custweaponimages_swf.skin_chaos_blade_png"
		)};
}
