class CompModFamilyInfo_Mason_Archer extends AOCFamilyInfo_Mason_Archer;

DefaultProperties
{
	NewPrimaryWeapons.empty;
	NewPrimaryWeapons(0)=(CWeapon=class'CompModWeapon_Longbow',CForceTertiary=(class'AOCWeapon_ProjBroadhead', class'AOCWeapon_ProjFireArrow'))
	NewPrimaryWeapons(1)=(CWeapon=class'CompModWeapon_Shortbow',CForceTertiary=(class'AOCWeapon_ProjBodkin', class'AOCWeapon_ProjFireArrow'))
	NewPrimaryWeapons(2)=(CWeapon=class'CompModWeapon_Warbow',CForceTertiary=(class'AOCWeapon_ProjBodkin', class'AOCWeapon_ProjFireArrow'))
	NewPrimaryWeapons(3)=(CWeapon=class'CompModWeapon_Crossbow',CForceTertiary=(class'AOCWeapon_PaviseShield_Mason',class'AOCWeapon_ExtraAmmo'))
	NewPrimaryWeapons(4)=(CWeapon=class'CompModWeapon_LightCrossbow',CForceTertiary=(class'AOCWeapon_PaviseShield_Mason',class'AOCWeapon_ExtraAmmo'))
	NewPrimaryWeapons(5)=(CWeapon=class'CompModWeapon_HeavyCrossbow',CForceTertiary=(class'AOCWeapon_PaviseShield_Mason',class'AOCWeapon_ExtraAmmo'))
	NewPrimaryWeapons(6)=(CWeapon=class'CompModWeapon_JavelinMelee',CForceTertiary=(class'CompModWeapon_Buckler_Mason'))
	NewPrimaryWeapons(7)=(CWeapon=class'CompModWeapon_ShortSpearMelee',CForceTertiary=(class'CompModWeapon_Buckler_Mason'))
	NewPrimaryWeapons(8)=(CWeapon=class'CompModWeapon_HeavyJavelinMelee',CForceTertiary=(class'CompModWeapon_Buckler_Mason'))
	NewPrimaryWeapons(9)=(CWeapon=class'CompModWeapon_Sling',CForceTertiary=(class'AOCWeapon_ProjPebble',class'AOCWeapon_ProjLeadBall'))

	NewSecondaryWeapons.empty;
	NewSecondaryWeapons(0)=(CWeapon=class'CompModWeapon_BroadDagger')
	NewSecondaryWeapons(1)=(CWeapon=class'CompModWeapon_HuntingKnife')
	NewSecondaryWeapons(2)=(CWeapon=class'CompModWeapon_ThrustDagger')
	NewSecondaryWeapons(3)=(CWeapon=class'CompModWeapon_Dagesse')
	NewSecondaryWeapons(4)=(CWeapon=class'CompModWeapon_Saber')
	NewSecondaryWeapons(5)=(CWeapon=class'CompModWeapon_Cudgel')

	NewTertiaryWeapons.empty;
	NewTertiaryWeapons(0)=(CWeapon=class'AOCWeapon_PaviseShield_Mason',bEnabledDefault=false)
	NewTertiaryWeapons(1)=(CWeapon=class'AOCWeapon_ExtraAmmo',bEnabledDefault=false)
	NewTertiaryWeapons(2)=(CWeapon=class'CompModWeapon_Buckler_Mason',bEnabledDefault=false)
	NewTertiaryWeapons(3)=(CWeapon=class'AOCWeapon_ProjBodkin',bEnabledDefault=false)
	NewTertiaryWeapons(4)=(CWeapon=class'AOCWeapon_ProjBroadhead',bEnabledDefault=false)
	NewTertiaryWeapons(5)=(CWeapon=class'AOCWeapon_ProjPebble',bEnabledDefault=false)
	NewTertiaryWeapons(6)=(CWeapon=class'AOCWeapon_ProjLeadBall',bEnabledDefault=false)


	ProjectileLocationModifiers(EHIT_Head) = 2.655
	ProjectileLocationModifiers(EHIT_Torso) = 1.75
	ProjectileLocationModifiers(EHIT_Arm) = 1
	CrossbowLocationModifiers(EHIT_Head) = 2.5
	CrossbowLocationModifiers(EHIT_Torso) = 2.25
	CrossbowLocationModifiers(EHIT_Arm) = 2.25

	DamageResistances(EDMG_Swing) = 1.1


}
