class CompModFamilyInfo_Agatha_Vanguard extends AOCFamilyInfo_Agatha_Vanguard;

DefaultProperties
{

	NewPrimaryWeapons.empty;
	NewPrimaryWeapons(0)=(CWeapon=class'CompModWeapon_Greatsword',CorrespondingDuelProp=EDUEL_GreatswordUse)
	NewPrimaryWeapons(1)=(CWeapon=class'CompModWeapon_Claymore',CorrespondingDuelProp=EDUEL_ClaymoreUse)
	NewPrimaryWeapons(2)=(CWeapon=class'CompModWeapon_Zweihander',CorrespondingDuelProp=EDUEL_ZweihanderUse)
	NewPrimaryWeapons(3)=(CWeapon=class'CompModWeapon_Spear',CorrespondingDuelProp=EDUEL_SpearUse)
	NewPrimaryWeapons(4)=(CWeapon=class'CompModWeapon_Fork',CorrespondingDuelProp=EDUEL_ForkUse)
	NewPrimaryWeapons(5)=(CWeapon=class'CompModWeapon_Brandistock',CorrespondingDuelProp=EDUEL_BrandistockUse)
	NewPrimaryWeapons(6)=(CWeapon=class'CompModWeapon_Bardiche',CorrespondingDuelProp=EDUEL_BardicheUse)
	NewPrimaryWeapons(7)=(CWeapon=class'CompModWeapon_Bill',CorrespondingDuelProp=EDUEL_BillUse)
	NewPrimaryWeapons(8)=(CWeapon=class'CompModWeapon_Halberd',CorrespondingDuelProp=EDUEL_HalberdUse)
	NewPrimaryWeapons(9)=(CWeapon=class'CompModWeapon_PoleHammer',CorrespondingDuelProp=EDUEL_PoleHammerUse)

	NewSecondaryWeapons.empty;
	NewSecondaryWeapons(0)=(CWeapon=class'CompModWeapon_Dagesse',CorrespondingDuelProp=EDUEL_DagesseUse)
	NewSecondaryWeapons(1)=(CWeapon=class'CompModWeapon_Saber',CorrespondingDuelProp=EDUEL_SaberUse)
	NewSecondaryWeapons(2)=(CWeapon=class'CompModWeapon_Cudgel',CorrespondingDuelProp=EDUEL_CudgelUse)
	NewSecondaryWeapons(3)=(CWeapon=class'CompModWeapon_WarAxe',CorrespondingDuelProp=EDUEL_WarAxeUse)
	NewSecondaryWeapons(4)=(CWeapon=class'CompModWeapon_Hatchet',CorrespondingDuelProp=EDUEL_HatchetUse)
	NewSecondaryWeapons(5)=(CWeapon=class'CompModWeapon_Dane',CorrespondingDuelProp=EDUEL_DaneUse)
	NewSecondaryWeapons(6)=(CWeapon=class'CompModWeapon_Broadsword')
	NewSecondaryWeapons(7)=(CWeapon=class'CompModWeapon_Falchion')
	NewSecondaryWeapons(8)=(CWeapon=class'CompModWeapon_NorseSword')

	NewTertiaryWeapons.empty;
	NewTertiaryWeapons(0)=(CWeapon=class'CompModWeapon_ThrowingAxe')
	NewTertiaryWeapons(1)=(CWeapon=class'CompModWeapon_ThrowingKnife')
	NewTertiaryWeapons(2)=(CWeapon=class'CompModWeapon_SmokePot')

	bCanSprintAttack=false

	ProjectileLocationModifiers(EHIT_Head) = 1.98
	ProjectileLocationModifiers(EHIT_Torso) = 1
	ProjectileLocationModifiers(EHIT_Arm) = 1
	CrossbowLocationModifiers(EHIT_Head) = 2
	CrossbowLocationModifiers(EHIT_Torso) = 1
	CrossbowLocationModifiers(EHIT_Arm) = 1


}
