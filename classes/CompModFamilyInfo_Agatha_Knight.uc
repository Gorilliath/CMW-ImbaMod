class CompModFamilyInfo_Agatha_Knight extends AOCFamilyInfo_Agatha_Knight;

DefaultProperties
{

	NewPrimaryWeapons.empty;
	NewPrimaryWeapons(0)=(CWeapon=class'CompModWeapon_DoubleAxe')
	NewPrimaryWeapons(1)=(CWeapon=class'CompModWeapon_PoleAxe')
	NewPrimaryWeapons(2)=(CWeapon=class'CompModWeapon_Bearded')
	NewPrimaryWeapons(3)=(CWeapon=class'CompModWeapon_WarHammer')
	NewPrimaryWeapons(4)=(CWeapon=class'CompModWeapon_Maul')
	NewPrimaryWeapons(5)=(CWeapon=class'CompModWeapon_GrandMace')
	NewPrimaryWeapons(6)=(CWeapon=class'CompModWeapon_Longsword')
	NewPrimaryWeapons(7)=(CWeapon=class'CompModWeapon_SwordOfWar')
	NewPrimaryWeapons(8)=(CWeapon=class'CompModWeapon_Messer')

	NewSecondaryWeapons.empty;
	NewSecondaryWeapons(0)=(CWeapon=class'CompModWeapon_Mace')
	NewSecondaryWeapons(1)=(CWeapon=class'CompModWeapon_MorningStar')
	NewSecondaryWeapons(2)=(CWeapon=class'CompModWeapon_HolyWaterSprinkler')
	NewSecondaryWeapons(3)=(CWeapon=class'CompModWeapon_Broadsword')
	NewSecondaryWeapons(4)=(CWeapon=class'CompModWeapon_Falchion')
	NewSecondaryWeapons(5)=(CWeapon=class'CompModWeapon_NorseSword')
	NewSecondaryWeapons(6)=(CWeapon=class'CompModWeapon_Hatchet')
	NewSecondaryWeapons(7)=(CWeapon=class'CompModWeapon_WarAxe')
	NewSecondaryWeapons(8)=(CWeapon=class'CompModWeapon_Dane')
	NewSecondaryWeapons(9)=(CWeapon=class'CompModWeapon_Flail')
	NewSecondaryWeapons(10)=(CWeapon=class'CompModWeapon_HFlail')

	NewTertiaryWeapons.empty;
	NewTertiaryWeapons(0)=(CWeapon=class'CompModWeapon_ThrowingAxe')
	NewTertiaryWeapons(1)=(CWeapon=class'CompModWeapon_TowerShield_Agatha')
	NewTertiaryWeapons(2)=(CWeapon=class'CompModWeapon_Heater_Agatha',bEnabledDefault=true)
	NewTertiaryWeapons(3)=(CWeapon=class'CompModWeapon_Kite_Agatha')
	NewTertiaryWeapons(4)=(CWeapon=class'CompModWeapon_Buckler_Agatha')

	ProjectileLocationModifiers(EHIT_Head) = 2
	ProjectileLocationModifiers(EHIT_Torso) = 1
	ProjectileLocationModifiers(EHIT_Arm) = 1


	CrossbowLocationModifiers(EHIT_Head) = 2
	CrossbowLocationModifiers(EHIT_Torso) = 1.2
	CrossbowLocationModifiers(EHIT_Arm) = 1.2


}
