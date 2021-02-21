class ImbaModFamilyInfo_Mason_ManAtArms extends AOCFamilyInfo_Mason_ManAtArms;

DefaultProperties
{
    NewPrimaryWeapons.empty;
    NewPrimaryWeapons(0)=(CWeapon=class'ImbaModWeapon_Broadsword')
    NewPrimaryWeapons(1)=(CWeapon=class'ImbaModWeapon_NorseSword')
    NewPrimaryWeapons(2)=(CWeapon=class'ImbaModWeapon_Falchion',CorrespondingDuelProp=EDUEL_FalchionUse)
    NewPrimaryWeapons(3)=(CWeapon=class'ImbaModWeapon_Hatchet',CorrespondingDuelProp=EDUEL_HatchetUse)
    NewPrimaryWeapons(4)=(CWeapon=class'ImbaModWeapon_WarAxe',CorrespondingDuelProp=EDUEL_WarAxeUse)
    NewPrimaryWeapons(5)=(CWeapon=class'ImbaModWeapon_Dane',CorrespondingDuelProp=EDUEL_DaneUse)
    NewPrimaryWeapons(6)=(CWeapon=class'ImbaModWeapon_Mace',CorrespondingDuelProp=EDUEL_MaceUse)
    NewPrimaryWeapons(7)=(CWeapon=class'ImbaModWeapon_MorningStar',CorrespondingDuelProp=EDUEL_MorningStarUse)
    NewPrimaryWeapons(8)=(CWeapon=class'ImbaModWeapon_HolyWaterSprinkler',CorrespondingDuelProp=EDUEL_HolyWaterSprinklerUse)
    NewPrimaryWeapons(9)=(CWeapon=class'ImbaModWeapon_QuarterStaff',CorrespondingDuelProp=EDUEL_QStaffUse)

    NewSecondaryWeapons.empty;
    NewSecondaryWeapons(0)=(CWeapon=class'ImbaModWeapon_BroadDagger',CorrespondingDuelProp=EDUEL_BroadDaggerUse)
    NewSecondaryWeapons(1)=(CWeapon=class'ImbaModWeapon_HuntingKnife',CorrespondingDuelProp=EDUEL_HuntingKnifeUse)
    NewSecondaryWeapons(2)=(CWeapon=class'ImbaModWeapon_ThrustDagger',CorrespondingDuelProp=EDUEL_ThrustDaggerUse)
    NewSecondaryWeapons(3)=(CWeapon=class'ImbaModWeapon_Dagesse',CorrespondingDuelProp=EDUEL_DagesseUse)
    NewSecondaryWeapons(4)=(CWeapon=class'ImbaModWeapon_Saber',CorrespondingDuelProp=EDUEL_SaberUse)
    NewSecondaryWeapons(5)=(CWeapon=class'ImbaModWeapon_Cudgel',CorrespondingDuelProp=EDUEL_CudgelUse)

    NewTertiaryWeapons.empty;
    NewTertiaryWeapons(0)=(CWeapon=class'ImbaModWeapon_ThrowingKnife')
    NewTertiaryWeapons(1)=(CWeapon=class'ImbaModWeapon_OilPot')
    NewTertiaryWeapons(2)=(CWeapon=class'ImbaModWeapon_Buckler_Mason')
    NewTertiaryWeapons(3)=(CWeapon=class'AOCWeapon_Heater_Mason')

    bCanDodge=true

    ProjectileLocationModifiers(EHIT_Head) = 2
    ProjectileLocationModifiers(EHIT_Torso) = 1
    ProjectileLocationModifiers(EHIT_Arm) = 1
    CrossbowLocationModifiers(EHIT_Head) = 2
    CrossbowLocationModifiers(EHIT_Torso) = 1
    CrossbowLocationModifiers(EHIT_Arm) = 1

    DamageResistances(EDMG_Blunt) = 0.65

    BACK_MODIFY=0.8

    iDodgeCost=25
}
