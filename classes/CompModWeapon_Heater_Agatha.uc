/**
* Copyright 2010-2012, Torn Banner Studios, All rights reserved
*
* Original Author: Eric "wcire" Williams
*
* AOCWeapon Heater sheild for Agatha
*
* ***********************************************************************************
* Description:  Has the correct InventoryAttachmentClass so the mesh is correct
* when the shield is holstered on the players back.
*/

class CompModWeapon_Heater_Agatha extends AOCWeapon_Heater_Agatha;

DefaultProperties
{
	Shield = class'AOCShield_Heatshield'
	CurrentWeaponType = EWEP_Heater

	InventoryAttachmentClass=class'AOCInventoryAttachment_Heater_Agatha'

	OtherTeamWeapon(EFAC_MASON)=class'CompModWeapon_Heater_Mason'

	/*
	 * Formerly in UDKNewWeapon.ini - [AOC.AOCWeapon_Heater_Agatha]
	 */
	WeaponFontSymbol="N"
	WeaponReach=100
	WeaponLargePortrait="UI_WeaponImages_SWF.weapon_select_agathashield"
	WeaponSmallPortrait="UI_WeaponImages_SWF.icon_weapon_select_heatershield_png"
}
