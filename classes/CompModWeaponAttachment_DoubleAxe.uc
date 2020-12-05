/**
* Copyright 2010-2012, Torn Banner Studios, All rights reserved
*
* Original Author: Michael Bao
*
* The weapon that is replicated to all clients: Double Axe
*/

class CompModWeaponAttachment_DoubleAxe extends AOCWeaponAttachment_DoubleAxe;

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
		SkeletalMesh=SkeletalMesh'WP_2ha_doubleaxe.WEP_doubleaxe'
		Scale=1.15
	End Object

	Begin Object Name=SkeletalMeshComponent2
		SkeletalMesh=SkeletalMesh'WP_2ha_doubleaxe.WEP_doubleaxe'
		Scale=1.15
	End Object

	WeaponID=EWEP_DoubleAxe
	WeaponClass=class'CompModWeapon_DoubleAxe'

	WeaponSocket=wep2haxepoint
	bUseAlternativeKick=true

	AttackTypeInfo(0)=(fBaseDamage=90, fForce=30000, cDamageType="AOC.AOCDmgType_SwingBlunt", iWorldHitLenience=6)
	AttackTypeInfo(1)=(fBaseDamage=123, fForce=30000, cDamageType="AOC.AOCDmgType_SwingBlunt", iWorldHitLenience=6)
	AttackTypeInfo(2)=(fBaseDamage=45.0, fForce=35000, cDamageType="AOC.AOCDmgType_Blunt", iWorldHitLenience=6)
	AttackTypeInfo(3)=(fBaseDamage=0.0, fForce=22500, cDamageType="AOC.AOCDmgType_SwingBlunt", iWorldHitLenience=6)
	AttackTypeInfo(4)=(fBaseDamage=0.0, fForce=40500, cDamageType="AOC.AOCDmgType_SwingBlunt", iWorldHitLenience=6)
	AttackTypeInfo(5)=(fBaseDamage=5.0, fForce=45500.0, cDamageType="AOC.AOCDmgType_Shove", iWorldHitLenience=12)

	Skins(0)={(
		SkeletalMeshPath="WP_2ha_doubleaxe.WEP_doubleaxe",
		StaticMeshPath="WP_2ha_doubleaxe.SM_Double_Axe",
		MaterialPath="",
		StaticMeshScale=1.0,
		ImagePath=""
		)};

	Skins(1)={(
		SkeletalMeshPath="WP_2ha_doubleaxe_Variant_01.WEP_Hengest_and_Horsa",
		StaticMeshPath="WP_2ha_doubleaxe_Variant_01.SM_HengestAndHorsa",
		MaterialPath="",
		StaticMeshScale=1.0,
		ImagePath="ui_custweaponimages_swf.skin_hengest_horsa_png"
		)};
}
