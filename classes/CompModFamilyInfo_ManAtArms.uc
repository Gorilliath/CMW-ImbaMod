/**
* Copyright 2010-2012, Torn Banner Studios, All rights reserved
*
* Original Author: Michael Bao
*
* Man-At-Arms.
*/
class CompModFamilyInfo_ManAtArms extends AOCFamilyInfo_ManAtArms;

DefaultProperties
{
	PrimaryWeapons(0)=class'AOCWeapon_Broadsword'
	PrimaryWeapons(1)=class'AOCWeapon_Falchion'
	PrimaryWeapons(2)=class'AOCWeapon_WarAxe'
	PrimaryWeapons(3)=class'AOCWeapon_NorseSword'
	PrimaryWeapons(4)=class'AOCWeapon_Mace'
	PrimaryWeapons(5)=class'AOCWeapon_MorningStar'

	SecondaryWeapons(0)=class'AOCWeapon_Buckler'
	SecondaryWeapons(1)=class'AOCWeapon_Heater'
	SecondaryWeapons(2)=class'AOCWeapon_ThrowingKnife'
	SecondaryWeapons(3)=class'CompModWeapon_OilPot'

	NewPrimaryWeapons(0)=(CWeapon=class'AOCWeapon_Broadsword',CheckLimitExpGroup=EEXP_1HSHARP,UnlockExpLevel=0.f)
	NewPrimaryWeapons(1)=(CWeapon=class'AOCWeapon_NorseSword',CheckLimitExpGroup=EEXP_1HSHARP,UnlockExpLevel=25.f)
	NewPrimaryWeapons(2)=(CWeapon=class'AOCWeapon_Falchion',CheckLimitExpGroup=EEXP_1HSHARP,UnlockExpLevel=100.f,CorrespondingDuelProp=EDUEL_FalchionUse)
	NewPrimaryWeapons(3)=(CWeapon=class'AOCWeapon_Hatchet',CheckLimitExpGroup=EEXP_1HAXE,UnlockExpLevel=0.f,CorrespondingDuelProp=EDUEL_HatchetUse)
	NewPrimaryWeapons(4)=(CWeapon=class'AOCWeapon_WarAxe',CheckLimitExpGroup=EEXP_1HAXE,UnlockExpLevel=25.f,CorrespondingDuelProp=EDUEL_WarAxeUse)
	NewPrimaryWeapons(5)=(CWeapon=class'AOCWeapon_Dane',CheckLimitExpGroup=EEXP_1HAXE,UnlockExpLevel=100.f,CorrespondingDuelProp=EDUEL_DaneUse)
	NewPrimaryWeapons(6)=(CWeapon=class'AOCWeapon_Mace',CheckLimitExpGroup=EEXP_1HBLUNT,UnlockExpLevel=0.f,CorrespondingDuelProp=EDUEL_MaceUse)
	NewPrimaryWeapons(7)=(CWeapon=class'AOCWeapon_MorningStar',CheckLimitExpGroup=EEXP_1HBLUNT,UnlockExpLevel=25.f,CorrespondingDuelProp=EDUEL_MorningStarUse)
	NewPrimaryWeapons(8)=(CWeapon=class'AOCWeapon_HolyWaterSprinkler',CheckLimitExpGroup=EEXP_1HBLUNT,UnlockExpLevel=100.f,CorrespondingDuelProp=EDUEL_HolyWaterSprinklerUse)
	NewPrimaryWeapons(9)=(CWeapon=class'AOCWeapon_QuarterStaff',CheckLimitExpGroup=EEXP_STAFF,UnlockExpLevel=0.f,CorrespondingDuelProp=EDUEL_QStaffUse)
	NewSecondaryWeapons(0)=(CWeapon=class'AOCWeapon_BroadDagger',CheckLimitExpGroup=EEXP_DAGGER,UnlockExpLevel=0.f,CorrespondingDuelProp=EDUEL_BroadDaggerUse)
	NewSecondaryWeapons(1)=(CWeapon=class'AOCWeapon_HuntingKnife',CheckLimitExpGroup=EEXP_DAGGER,UnlockExpLevel=25.f,CorrespondingDuelProp=EDUEL_HuntingKnifeUse)
	NewSecondaryWeapons(2)=(CWeapon=class'AOCWeapon_ThrustDagger',CheckLimitExpGroup=EEXP_DAGGER,UnlockExpLevel=100.f,CorrespondingDuelProp=EDUEL_ThrustDaggerUse)
	NewSecondaryWeapons(3)=(CWeapon=class'AOCWeapon_Dagesse',CheckLimitExpGroup=EEXP_LIGHTAUX,UnlockExpLevel=0.f,CorrespondingDuelProp=EDUEL_DagesseUse)
	NewSecondaryWeapons(4)=(CWeapon=class'AOCWeapon_Saber',CheckLimitExpGroup=EEXP_LIGHTAUX,UnlockExpLevel=25.f,CorrespondingDuelProp=EDUEL_SaberUse)
	NewSecondaryWeapons(5)=(CWeapon=class'AOCWeapon_Cudgel',CheckLimitExpGroup=EEXP_LIGHTAUX,UnlockExpLevel=100.f,CorrespondingDuelProp=EDUEL_CudgelUse)

	NewTertiaryWeapons(0)=(CWeapon=class'AOCWeapon_ThrowingKnife')
	NewTertiaryWeapons(1)=(CWeapon=class'AOCWeapon_OilPot')
	NewTertiaryWeapons(2)=(CWeapon=class'AOCWeapon_Buckler')

	PawnArmorType = ARMORTYPE_LIGHT

	AirSpeed=440.0
	WaterSpeed=220.0
	AirControl=0.35
	GroundSpeed=210.0

	ClassReference = ECLASS_ManAtArms

	// damage modifiers
	DamageResistances(EDMG_Swing) = 0.85
	DamageResistances(EDMG_Pierce) = 0.85
	DamageResistances(EDMG_Blunt) = 0.65

	/*
	 *
	 * Formerly in UDKFamilyInfo.ini
	 *
	 */
	GroundSpeed=210
	AccelRate=700.0
	SprintAccelRate=100.0
	JumpZ=380.0
	SprintModifier=1.55
	SprintTime=10.0
	DodgeSpeed=400.0
	DodgeSpeedZ=200.0
	Health=100
	BACK_MODIFY=0.85
	STRAFE_MODIFY=0.9
	FORWARD_MODIFY=1.0
	CROUCH_MODIFY=0.65
	PercentDamageToTake=0.9
	MaxSprintSpeedTime=2
	bCanDodge=false
	iDodgeCost=20
	iKickCost=20
	fComboAggressionBonus=1.0
	fBackstabModifier=1.0
	iMissMeleeStrikePenalty=10
	iMissMeleeStrikePenaltyBonus=0
	fShieldStaminaAbsorption=6
	bCanSprintAttack=false
	fStandingSpread=0.05f
	fCrouchingSpread=0.0f
	fWalkingSpread=0.1
	fSprintingSpread=0.25
	fFallingSpread=0.25
	fSpreadPenaltyPerSecond=0.5
	fSpreadRecoveryPerSecond=0.3

}
