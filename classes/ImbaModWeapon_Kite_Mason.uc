class ImbaModWeapon_Kite_Mason extends AOCWeapon_Kite_Mason;


DefaultProperties
{
    Shield = class'AOCShield_Kite'
    CurrentWeaponType = EWEP_Kite

    InventoryAttachmentClass=class'AOCInventoryAttachment_Kite_Mason'

    OtherTeamWeapon(EFAC_AGATHA)=class'ImbaModWeapon_Kite_Agatha'

    /*
     * Formerly in UDKNewWeapon.ini - [AOC.AOCWeapon_Kite_Mason]
     */
    WeaponFontSymbol="N"
    WeaponReach=100
    WeaponLargePortrait="UI_WeaponImages_SWF.weapon_select_kite_mason"
    WeaponSmallPortrait="UI_WeaponImages_SWF.icon_weapon_select_kite_shield_png"
}
