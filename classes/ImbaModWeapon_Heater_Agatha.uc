class ImbaModWeapon_Heater_Agatha extends AOCWeapon_Heater_Agatha;


DefaultProperties
{
    Shield = class'AOCShield_Heatshield'
    CurrentWeaponType = EWEP_Heater

    InventoryAttachmentClass=class'AOCInventoryAttachment_Heater_Agatha'

    OtherTeamWeapon(EFAC_MASON)=class'ImbaModWeapon_Heater_Mason'

    /*
     * Formerly in UDKNewWeapon.ini - [AOC.AOCWeapon_Heater_Agatha]
     */
    WeaponFontSymbol="N"
    WeaponReach=100
    WeaponLargePortrait="UI_WeaponImages_SWF.weapon_select_agathashield"
    WeaponSmallPortrait="UI_WeaponImages_SWF.icon_weapon_select_heatershield_png"
}
