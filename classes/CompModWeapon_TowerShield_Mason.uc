/**
* Copyright 2010-2012, Torn Banner Studios, All rights reserved
*
* Original Author: Michael Bao
*
* Heater - Weapon Loadout.
*/
class CompModWeapon_TowerShield_Mason extends AOCWeapon_TowerShield_Mason;

DefaultProperties
{
	Shield = class'AOCShield_TowerShield'
	CurrentWeaponType = EWEP_Tower

	InventoryAttachmentClass=class'AOCInventoryAttachment_TowerShield_Mason'

	OtherTeamWeapon(EFAC_AGATHA)=class'CompModWeapon_TowerShield_Agatha'

	/*
	 * Formerly in UDKNewWeapon.ini - [AOC.AOCWeapon_TowerShield_Mason]
	 */
	WeaponFontSymbol=">"
	WeaponReach=100
	WeaponLargePortrait="UI_WeaponImages_SWF.weapon_select_tower_mason"
	WeaponSmallPortrait="UI_WeaponImages_SWF.icon_weapon_select_towershield_png"
}
