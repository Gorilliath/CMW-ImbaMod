class CompModRangeWeapon extends AOCRangeWeapon;

var bool bWeaponProjCamEnabled;

simulated function ChangeProjectileType(class<AOCProjectile> Proj) {
	if (Role == ROLE_Authority && Proj != none)
		AllowedProjClass = Proj;

	if (Proj != none)
		WeaponProjectiles[0] = Proj;
	AmmoCount = ConfigProjectileBaseDamage[GetProjectileType()].AmmoCount;

	CacheWeaponReferences();

	if (class<CompModWeapon_Crossbow>(Class) != none && AOCOwner.PawnInfo.myTertiary == class'AOCWeapon_ExtraAmmo')
		AmmoCount += class'AOCWeapon_ExtraAmmo'.default.ExtraAmmo;

	MaxAmmoCount = AmmoCount;

	if (Role < ROLE_Authority)
	{
		RequestInitialAmmo();
		NotifyAmmoConsume();
	}
}

simulated function enableProjCam() {
	AOCPlayerController(AOCOwner.Controller).bCanSwapToProjCam = bWeaponProjCamEnabled;
	bHasInformedPawnAboutProjectileCam = false;

	if (Role < ROLE_Authority && bWeaponProjCamEnabled) {
		s_enableProjCam();
	}
}

simulated state Active {
	simulated function BeginFire(byte FireModeNum) {
		if (FireModeNum == Attack_Shove)
			AOCOwner.PlaySound(AOCOwner.GenericCantDoSound, true);
		else if (bLoaded || (FireModeNum == Attack_Overhead && CompModWeapon_Crossbow(self) != none))
			super.BeginFire(FireModeNum);
	}
}

DefaultProperties
{
    bWeaponProjCamEnabled=true;
}
