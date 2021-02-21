class ImbaModFamilyInfo_Mason_Knight extends AOCFamilyInfo_Mason_Knight;

DefaultProperties
{
    NewPrimaryWeapons.empty;
    NewPrimaryWeapons(0)=(CWeapon=class'ImbaModWeapon_DoubleAxe')
    NewPrimaryWeapons(1)=(CWeapon=class'ImbaModWeapon_PoleAxe')
    NewPrimaryWeapons(2)=(CWeapon=class'ImbaModWeapon_Bearded')
    NewPrimaryWeapons(3)=(CWeapon=class'ImbaModWeapon_WarHammer')
    NewPrimaryWeapons(4)=(CWeapon=class'ImbaModWeapon_Maul')
    NewPrimaryWeapons(5)=(CWeapon=class'ImbaModWeapon_GrandMace')
    NewPrimaryWeapons(6)=(CWeapon=class'ImbaModWeapon_Longsword')
    NewPrimaryWeapons(7)=(CWeapon=class'ImbaModWeapon_SwordOfWar')
    NewPrimaryWeapons(8)=(CWeapon=class'ImbaModWeapon_Messer')

    NewSecondaryWeapons.empty;
    NewSecondaryWeapons(0)=(CWeapon=class'ImbaModWeapon_Mace')
    NewSecondaryWeapons(1)=(CWeapon=class'ImbaModWeapon_MorningStar')
    NewSecondaryWeapons(2)=(CWeapon=class'ImbaModWeapon_HolyWaterSprinkler')
    NewSecondaryWeapons(3)=(CWeapon=class'ImbaModWeapon_Broadsword')
    NewSecondaryWeapons(4)=(CWeapon=class'ImbaModWeapon_Falchion')
    NewSecondaryWeapons(5)=(CWeapon=class'ImbaModWeapon_NorseSword')
    NewSecondaryWeapons(6)=(CWeapon=class'ImbaModWeapon_Hatchet')
    NewSecondaryWeapons(7)=(CWeapon=class'ImbaModWeapon_WarAxe')
    NewSecondaryWeapons(8)=(CWeapon=class'ImbaModWeapon_Dane')
    NewSecondaryWeapons(9)=(CWeapon=class'ImbaModWeapon_Flail')
    NewSecondaryWeapons(10)=(CWeapon=class'ImbaModWeapon_HFlail')

    NewTertiaryWeapons.empty;
    NewTertiaryWeapons(0)=(CWeapon=class'ImbaModWeapon_ThrowingAxe')
    NewTertiaryWeapons(1)=(CWeapon=class'ImbaModWeapon_TowerShield_Mason')
    NewTertiaryWeapons(2)=(CWeapon=class'ImbaModWeapon_Heater_Mason',bEnabledDefault=true)
    NewTertiaryWeapons(3)=(CWeapon=class'ImbaModWeapon_Kite_Mason')
    NewTertiaryWeapons(4)=(CWeapon=class'ImbaModWeapon_Buckler_Mason')

    ProjectileLocationModifiers(EHIT_Head) = 2
    ProjectileLocationModifiers(EHIT_Torso) = 1
    ProjectileLocationModifiers(EHIT_Arm) = 1

    CrossbowLocationModifiers(EHIT_Head) = 2
    CrossbowLocationModifiers(EHIT_Torso) = 1.2
    CrossbowLocationModifiers(EHIT_Arm) = 1.2
}
