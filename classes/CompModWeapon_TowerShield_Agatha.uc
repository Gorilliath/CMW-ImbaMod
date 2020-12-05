/**
* Copyright 2010-2012, Torn Banner Studios, All rights reserved
*
* Original Author: Michael Bao
*
* Heater - Weapon Loadout.
*/
class CompModWeapon_TowerShield_Agatha extends AOCWeapon_TowerShield_Agatha;

DefaultProperties
{
	Shield = class'AOCShield_TowerShield'
	CurrentWeaponType = EWEP_Tower

	InventoryAttachmentClass=class'AOCInventoryAttachment_TowerShield_Agatha'

	OtherTeamWeapon(EFAC_MASON)=class'CompModWeapon_TowerShield_Mason'

	/*
	 * Formerly in UDKNewWeapon.ini - [AOC.AOCWeapon_TowerShield_Agatha]
	 */
	WeaponFontSymbol=">"
	WeaponReach=100
	WeaponLargePortrait="UI_WeaponImages_SWF.weapon_select_tower_agatha"
	WeaponSmallPortrait="UI_WeaponImages_SWF.icon_weapon_select_towershield_png"
}
