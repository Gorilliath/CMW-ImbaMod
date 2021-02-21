class ImbaModWeapon_Heater_Mason extends AOCWeapon_Heater_Mason;


DefaultProperties
{
    Shield = class'AOCShield_Heatshield'
    CurrentWeaponType = EWEP_Heater

    InventoryAttachmentClass=class'AOCInventoryAttachment_Heater_Mason'

    OtherTeamWeapon(EFAC_AGATHA)=class'ImbaModWeapon_Heater_Agatha'

    /*
     * Formerly in UDKNewWeapon.ini - [AOC.AOCWeapon_Heater_Mason]
     */
    WeaponFontSymbol="N"
    WeaponReach=100
    WeaponLargePortrait="UI_WeaponImages_SWF.weapon_select_masonshield"
    WeaponSmallPortrait="UI_WeaponImages_SWF.icon_weapon_select_heatershield_png"
}
