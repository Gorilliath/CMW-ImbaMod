class ImbaModWeapon_Kite_Agatha extends AOCWeapon_Kite_Agatha;


DefaultProperties
{
    Shield = class'AOCShield_Kite'
    CurrentWeaponType = EWEP_Kite

    InventoryAttachmentClass=class'AOCInventoryAttachment_Kite_Agatha'

    OtherTeamWeapon(EFAC_MASON)=class'ImbaModWeapon_Kite_Mason'

    /*
     * Formerly in UDKNewWeapon.ini - [AOC.AOCWeapon_Kite_Agatha]
     */
    WeaponFontSymbol="N"
    WeaponReach=100
    WeaponLargePortrait="UI_WeaponImages_SWF.weapon_select_kite_agatha"
    WeaponSmallPortrait="UI_WeaponImages_SWF.icon_weapon_select_kite_shield_png"
}
