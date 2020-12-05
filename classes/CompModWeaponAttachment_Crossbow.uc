/**
* Copyright 2010-2012, Torn Banner Studios, All rights reserved
* 
* Original Author: Michael Bao
* 
* The weapon that is replicated to all clients: Crossbow.
*/
class CompModWeaponAttachment_Crossbow extends AOCWeaponAttachment_Crossbow;

// Node for determining which animation to play
var AnimNodeBlendList AmmoNodeBlendList;
var AnimNodeBlendList OverlayAmmoNodeBlendList;

simulated event PostInitAnimTree(SkeletalMeshComponent SkelComp)
{
	super.PostInitAnimTree(SkelComp);

	if (SkelComp == Mesh)
		AmmoNodeBlendList = AnimNodeBlendList(Mesh.FindAnimNode('AmmoNode'));
	else if (SkelComp == OverlayMesh)
		OverlayAmmoNodeBlendList = AnimNodeBlendList(OverlayMesh.FindAnimNode('AmmoNode'));
}


simulated event Tick(float DeltaTime)
{
	super.Tick(DeltaTime);

	if (bHasAmmo && AmmoNodeBlendList.ActiveChildIndex == 0)
	{
		AmmoNodeBlendList.SetActiveChild(1, 0.2f);

		if (OverlayMesh != none)
		{
			OverlayAmmoNodeBlendList.SetActiveChild(1, 0.2f);
		}
	}
	else if (!bHasAmmo && AmmoNodeBlendList.ActiveChildIndex == 1)
	{
		AmmoNodeBlendList.SetActiveChild(0, 0.2f);

		if (OverlayMesh != none)
		{
			OverlayAmmoNodeBlendList.SetActiveChild(0, 0.2f);
		}
	}
}

DefaultProperties
{
	Begin Object Name=SkeletalMeshComponent0
		//Translation=(Z=1)
		//Rotation=(Roll=-400)
		Scale=1.0
		bUpdateSkelWhenNotRendered=true
		bForceRefPose=0
		Animations=none
		AnimTreeTemplate=AnimTree'ANIM_3p_WEP_Xbow_PKG.xbow_at'
		AnimSets(0)=AnimSet'ANIM_3p_WEP_Xbow_PKG.3p_WEP_Xbow_ANIMSET'
		bIgnoreControllersWhenNotRendered=false
		bOverrideAttachmentOwnerVisibility=false
		SkeletalMesh=SkeletalMesh'WP_xbw_Crossbow.WEP_Crossbow'
	End Object

	Begin Object Name=SkeletalMeshComponent2
		//Translation=(Z=1)
		//Rotation=(Roll=-400)
		Scale=1.0
		bUpdateSkelWhenNotRendered=true
		bForceRefPose=0
		Animations=none
		AnimTreeTemplate=AnimTree'ANIM_3p_WEP_Xbow_PKG.xbow_at'
		AnimSets(0)=AnimSet'ANIM_3p_WEP_Xbow_PKG.3p_WEP_Xbow_ANIMSET'
		bIgnoreControllersWhenNotRendered=false
		bOverrideAttachmentOwnerVisibility=false
		SkeletalMesh=SkeletalMesh'WP_xbw_Crossbow.WEP_Crossbow'
	End Object

	WeaponID=EWEP_Crossbow
	WeaponClass=class'CompModWeapon_Crossbow'
	WeaponSocket=CrossBowPoint
	bHasAmmo=true

	Skins(0)={(
		SkeletalMeshPath="WP_xbw_Crossbow.WEP_Crossbow",
		StaticMeshPath="WP_xbw_Crossbow.sm_crossbow",
		MaterialPath="",
		StaticMeshScale=1.0,
		ImagePath="UI_CustWeaponImages_SWF.skin_crossbow_png"
		)};
	Skins(1)={(
		SkeletalMeshPath="WP_xbw_crossbow_variant_01.WEP_SK_viper_crossbow",
		StaticMeshPath="WP_xbw_crossbow_variant_01.SM_viper_crossbow",
		MaterialPath="",
		StaticMeshScale=1.0,
		ImagePath="UI_CustWeaponImages_SWF.skin_hawkeye_crossbow_png"
		)};
}

