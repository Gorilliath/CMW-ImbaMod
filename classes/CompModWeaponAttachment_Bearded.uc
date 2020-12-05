/**
* Copyright 2010-2012, Torn Banner Studios, All rights reserved
*
* Original Author: Michael Bao
*
* The weapon that is replicated to all clients: Bearded Axe
*/

class CompModWeaponAttachment_Bearded extends AOCWeaponAttachment_Bearded;

simulated function float GetHandleTracerPercent(int i)
{
    local vector vStart, vMid, vEnd;
    local float HandleLength, WeaponLength;

    if (Mesh.GetSocketByName('TraceMid') == None)
    {
        return 0.0f;
    }
    Mesh.GetSocketWorldLocationAndRotation('TraceStart', vStart);
    Mesh.GetSocketWorldLocationAndRotation('TraceMid', vMid);
    Mesh.GetSocketWorldLocationAndRotation('TraceEnd', vEnd);

    WeaponLength = VSize(vEnd - vStart);
    HandleLength = VSize(vMid - vStart);

    return (HandleLength / WeaponLength)/2;
}

DefaultProperties
{

KickOffset=(X=50, Y=0, Z=-65)
	KickSize=20.f

	Begin Object Name=SkeletalMeshComponent0
		SkeletalMesh=SkeletalMesh'WP_2ha_Pollaxe.WEP_Pollaxe'
		Scale=1.1
	End Object

	Begin Object Name=SkeletalMeshComponent2
		SkeletalMesh=SkeletalMesh'WP_2ha_Pollaxe.WEP_Pollaxe'
		Scale=1.1
	End Object

	WeaponID=EWEP_Bearded
	WeaponClass=class'CompModWeapon_Bearded'

	WeaponSocket=wep2haxepoint
	bUseAlternativeKick=true

	AttackTypeInfo(0)=(fBaseDamage=95, fForce=35500, cDamageType="AOC.AOCDmgType_Swing", iWorldHitLenience=6)
	AttackTypeInfo(1)=(fBaseDamage=90, fForce=30000, cDamageType="AOC.AOCDmgType_SwingBlunt", iWorldHitLenience=6)
	AttackTypeInfo(2)=(fBaseDamage=20.0, fForce=37500, cDamageType="AOC.AOCDmgType_Blunt", iWorldHitLenience=6)
	AttackTypeInfo(3)=(fBaseDamage=0.0, fForce=22500, cDamageType="AOC.AOCDmgType_SwingBlunt", iWorldHitLenience=6)
	AttackTypeInfo(4)=(fBaseDamage=0.0, fForce=40500, cDamageType="AOC.AOCDmgType_SwingBlunt", iWorldHitLenience=6)
	AttackTypeInfo(5)=(fBaseDamage=5.0, fForce=45500.0, cDamageType="AOC.AOCDmgType_Shove", iWorldHitLenience=12)

	Skins(0)={(
		SkeletalMeshPath="WP_2ha_Bearded.WEP_Bearded_Axe",
		StaticMeshPath="WP_2ha_Bearded.SM_Bearded_Axe",
		MaterialPath="",
		StaticMeshScale=1.0,
		ImagePath="UI_CustWeaponImages_SWF.skin_bearded_axe_png"
		)};

	Skins(1)={(
		SkeletalMeshPath="WP_2ha_bearded_Variant_01.WEP_bearded_axe",
		StaticMeshPath="WP_2ha_bearded_Variant_01.sm_bearded_axe",
		MaterialPath="",
		StaticMeshScale=1.0,
		ImagePath="UI_CustWeaponImages_SWF.skin_judgement_axe_png"
		)};

	Skins(2)={(
		SkeletalMeshPath="WP_2ha_bearded_Variant_02.WEP_ChickenAxe",
		StaticMeshPath="WP_2ha_bearded_Variant_02.SM_ChickenAxe",
		MaterialPath="",
		StaticMeshScale=1.0,
		ImagePath="UI_CustWeaponImages_SWF.skin_chicken_axe_png"
		)};
}
