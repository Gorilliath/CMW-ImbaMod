/**
* Copyright 2010-2012, Torn Banner Studios, All rights reserved
* 
* Original Author: Michael Bao
* 
* The weapon that is replicated to all clients: Broadsword
*/
class CompModWeaponAttachment_Broadsword extends AOCWeaponAttachment_Broadsword;

DefaultProperties
{

KickOffset=(X=50, Y=0, Z=-65)
	KickSize=20.f

	Begin Object Name=SkeletalMeshComponent0
		SkeletalMesh=SkeletalMesh'WP_1hs_Broadsword.WEP_Broadsword'
	End Object

	Begin Object Name=SkeletalMeshComponent2
		SkeletalMesh=SkeletalMesh'WP_1hs_Broadsword.WEP_Broadsword'
	End Object

	WeaponID=EWEP_Broadsword
	WeaponClass=class'CompModWeapon_Broadsword'
	WeaponSocket = wep1hpoint

	AttackTypeInfo(0)=(fBaseDamage=60.0, fForce=15000, cDamageType="AOC.AOCDmgType_Swing", iWorldHitLenience=6)
	AttackTypeInfo(1)=(fBaseDamage=70.0, fForce=15000, cDamageType="AOC.AOCDmgType_Swing", iWorldHitLenience=6)
	AttackTypeInfo(2)=(fBaseDamage=55.0, fForce=22500, cDamageType="AOC.AOCDmgType_Pierce", iWorldHitLenience=6)
	AttackTypeInfo(3)=(fBaseDamage=0.0, fForce=30000, cDamageType="AOC.AOCDmgType_Swing", iWorldHitLenience=6)
	AttackTypeInfo(4)=(fBaseDamage=0.0, fForce=22500, cDamageType="AOC.AOCDmgType_Swing", iWorldHitLenience=6)
	AttackTypeInfo(5)=(fBaseDamage=5.0, fForce=45500.0, cDamageType="AOC.AOCDmgType_Shove", iWorldHitLenience=12)

	Skins(0)={(
		SkeletalMeshPath="WP_1hs_Broadsword.WEP_Broadsword",
		StaticMeshPath="WP_1hs_Broadsword.sm_Broadsword",
		MaterialPath="",
		StaticMeshScale=1.0,
		ImagePath="UI_CustWeaponImages_SWF.skin_broadsword_png"
		)};

	Skins(1)={(
		SkeletalMeshPath="WP_1hs_Broadsword_variant_01.WEP_Broadsword",
		StaticMeshPath="WP_1hs_Broadsword_variant_01.sm_Broadsword",
		MaterialPath="",
		StaticMeshScale=1.0,
		ImagePath="UI_CustWeaponImages_SWF.skin_oriental_broadsword_png"
		)};

	Skins(2)={(
		SkeletalMeshPath="WP_1hs_Broadsword_Variant_02.sk_bsword2",
		StaticMeshPath="WP_1hs_Broadsword_Variant_02.sm_bsword2",
		MaterialPath="",
		StaticMeshScale=1.0,
		ImagePath="UI_CustWeaponImages_SWF.skin_temujins_broadsword_png"
		)};
		
	Skins(3)={(
		SkeletalMeshPath="WP_1hs_Broadsword_Variant_03.WEP_KinSlayer",
		StaticMeshPath="WP_1hs_Broadsword_Variant_03.SM_KinSlayer",
		MaterialPath="",
		StaticMeshScale=1.0,
		ImagePath="UI_CustWeaponImages_SWF.skin_kinslayer_png"
		)};

	Skins(4)={(
		SkeletalMeshPath="WP_1hs_Broadsword_Variant_04.WEP_Bohemiansword",
		StaticMeshPath="WP_1hs_Broadsword_Variant_04.SM_Bohemiansword",
		MaterialPath="",
		StaticMeshScale=1.0,
		ImagePath="ui_custweaponimages_swf.skin_bohemian_broadsword_png"
		)};

	Skins(5)={(
		SkeletalMeshPath="WP_1hs_Broadsword_Variant_06.WEP_Broadsword",
		StaticMeshPath="WP_1hs_Broadsword_Variant_06.sm_Broadsword",
		MaterialPath="",
		StaticMeshScale=1.0,
		ImagePath="ui_custweaponimages_swf.skin_ice_breaker_png"
		)};

	Skins(6)={(
		SkeletalMeshPath="WP_1hs_Broadsword_Variant_05.WEP_Tsword",
		StaticMeshPath="StaticMesh'WP_1hs_Broadsword_Variant_05.SM_Tsword",
		MaterialPath="",
		StaticMeshScale=1.0,
		ImagePath="ui_custweaponimages_swf.skin_squire_trainer_png"
		)};
}
