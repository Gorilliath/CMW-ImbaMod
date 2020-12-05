/**
* Copyright 2010-2012, Torn Banner Studios, All rights reserved
*
* Original Author: Michael Bao
*
* Buckler - Weapon Loadout.
*/
class CompModWeapon_Buckler_Mason extends AOCWeapon_Buckler_Mason;

DefaultProperties
{
	Shield = class'AOCShield_Buckler'
	CurrentWeaponType = EWEP_Buckler

	InventoryAttachmentClass=class'AOCInventoryAttachment_Buckler_Mason'

	OtherTeamWeapon(EFAC_AGATHA)=class'CompModWeapon_Buckler_Agatha'

	/*
	 * Formerly in UDKNewWeapon.ini - [AOC.AOCWeapon_Buckler_Mason]
	 */
	WeaponFontSymbol="6"
	WeaponReach=100
	WeaponLargePortrait="UI_WeaponImages_SWF.weapon_select_buckler_mason"
	WeaponSmallPortrait="UI_WeaponImages_SWF.icon_weapon_select_buckler_png"
}
