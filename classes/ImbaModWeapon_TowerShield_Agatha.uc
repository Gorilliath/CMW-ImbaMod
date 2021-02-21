class ImbaModWeapon_TowerShield_Agatha extends AOCWeapon_TowerShield_Agatha;


DefaultProperties
{
    Shield = class'AOCShield_TowerShield'
    CurrentWeaponType = EWEP_Tower

    InventoryAttachmentClass=class'AOCInventoryAttachment_TowerShield_Agatha'

    OtherTeamWeapon(EFAC_MASON)=class'ImbaModWeapon_TowerShield_Mason'

    /*
     * Formerly in UDKNewWeapon.ini - [AOC.AOCWeapon_TowerShield_Agatha]
     */
    WeaponFontSymbol=">"
    WeaponReach=100
    WeaponLargePortrait="UI_WeaponImages_SWF.weapon_select_tower_agatha"
    WeaponSmallPortrait="UI_WeaponImages_SWF.icon_weapon_select_towershield_png"
}
