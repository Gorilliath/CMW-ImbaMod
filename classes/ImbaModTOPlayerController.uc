class ImbaModTOPlayerController extends AOCTeamObjectivePC
    dependson(ImbaModTO);

`include(ImbaMod/Include/ImbaModTO.uci)
`include(ImbaMod/Include/ImbaModPlayerController.uci)


simulated function MyPawnIsKing(class<AOCFamilyInfo> NewClass)
{
    local AOCFamilyInfo CurrFamily;

    if (NewClass == class'AOCFamilyInfo_Agatha_King' || NewClass == class'ImbaModFamilyInfo_Agatha_King')
    {
        NewClass = class'ImbaModFamilyInfo_Agatha_King';
        SetWeapons(class'ImbaModWeapon_Longsword', class'ImbaModWeapon_Longsword1H', class'ImbaModWeapon_GrandMace', class'ImbaModWeapon_Kite_Agatha');
    } else if (NewClass == class'AOCFamilyInfo_Mason_King' || NewClass == class'ImbaModFamilyInfo_Mason_King')
    {
        NewClass = class'ImbaModFamilyInfo_Mason_King';
        SetWeapons(class'ImbaModWeapon_Messer', class'ImbaModWeapon_Messer1H', class'ImbaModWeapon_Maul', class'ImbaModWeapon_Kite_Mason');
    }

    CurrFamily = AOCGRI(Worldinfo.GRI).GetOrSpawnFamilyInfoFromClass(NewClass);

    AOCPRI(PlayerReplicationInfo).bCanPerformAB = false;
    SetNewClass(CurrFamily);

    bCanChangeClass = false;

    SetTimer(5.f, false, 'UpdateObjectiveKingClass');
}

simulated function UpdateObjectiveKingClass()
{
    if (MyAssassinationObjective.KingClass == class'AOCFamilyInfo_Agatha_King')
    {
        MyAssassinationObjective.KingClass = class'ImbaModFamilyInfo_Agatha_King';
    }
    else if (MyAssassinationObjective.KingClass == class'AOCFamilyInfo_Mason_King')
    {
        MyAssassinationObjective.KingClass = class'ImbaModFamilyInfo_Mason_King';
    }
}
