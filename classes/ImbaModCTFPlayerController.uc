class ImbaModCTFPlayerController extends AOCCTFPlayerController
    dependson(ImbaModCTF);

`include(ImbaMod/Include/ImbaModCTF.uci)
`include(ImbaMod/Include/ImbaModPlayerController.uci)


exec function AdminResetFlag(string Team) {
    S_AdminResetFlag(Team);
}

reliable server function S_AdminResetFlag(string Team) {
    local AOCFlag Flag;

    // Verify admin permissions
    if (!IsAdmin()) {
        NotifyNotAdmin();
        return;
    }

    // Verify gamemode is CTF
    if (AOCCTF(WorldInfo.Game) == none) {
        ClientDisplayConsoleMessage("The current gamemode is not CTF.");
        return;
    }

    // Verify Team
    if ( !(Team ~= "agatha" || Team ~= "mason" || Team ~= "all" || Team ~= "both") ) {
        ClientDisplayConsoleMessage("'" $ Team $ "' is not a valid team. Use AGATHA, MASON, ALL, BOTH");
        return;
    }

    // Reset Agatha
    if (Team ~= "agatha" || Team ~= "all" || Team ~= "both") {

        // Log action to players
        S_BroadcastServerMessage("AdminResetFlag: AGATHA");

        // Reset Agatha flag
        Flag = AOCCTF(Worldinfo.Game).GetActiveFlag(EFAC_MASON); // enum is inverted intentionally; game is bad
        if (Flag.CurrentUser != none)
            Flag.DropFlag(Flag.CurrentUser, false);
        Flag.DeactivateFlag();
        Flag.ResetFlag(false);

        AOCCTF(Worldinfo.Game).ChooseRandomFlag(EFAC_MASON);
    }

    // Reset Mason
    if (Team ~= "mason" || Team ~= "all" || Team ~= "both") {

        // Log action to players
        S_BroadcastServerMessage("AdminResetFlag: MASON");

        // Reset Mason flag
        Flag = AOCCTF(Worldinfo.Game).GetActiveFlag(EFAC_AGATHA);
        if (Flag.CurrentUser != none)
            Flag.DropFlag(Flag.CurrentUser, false);
        Flag.DeactivateFlag();
        Flag.ResetFlag(false);

        AOCCTF(Worldinfo.Game).ChooseRandomFlag(EFAC_AGATHA);
    }
}

exec function AdminIncreaseScore(string Team, optional string PlayerName) {
    S_AdminIncreaseScore(Team, PlayerName);
}

reliable server function S_AdminIncreaseScore(string Team, optional string PlayerName) {
    local EAOCFaction Faction;
    local AOCPlayerController PlayerControllerToCredit;
    local AOCPawn PlayerPawnToCredit;

    // Verify admin permissions
    if (!IsAdmin()) {
        NotifyNotAdmin();
        return;
    }

    // Verify gamemode is CTF
    if (AOCCTF(WorldInfo.Game) == none) {
        ClientDisplayConsoleMessage("The current gamemode is not CTF.");
        return;
    }

    // Resolve team
    if (Team ~= "agatha") {
        Faction = EFAC_AGATHA;
    } else if (Team ~= "mason") {
        Faction = EFAC_MASON;
    } else {
        ClientDisplayConsoleMessage("'" $ Team $ "' is not a valid team. Use AGATHA or MASON.");
        return;
    }

    // Resolve player to credit
    // Try to match a player controller
    PlayerControllerToCredit = AOCPlayerController(WorldInfo.Game.AccessControl.GetControllerFromString(PlayerName));

    PlayerPawnToCredit = PlayerControllerToCredit != none
        ? AOCPawn(PlayerControllerToCredit.Pawn)            // If a player controller was matched use it's pawn
        : AOCPawn(Pawn);                                    // Otherwise use this function caller's pawn

    // Log action to players
    S_BroadcastServerMessage("AdminIncreaseScore:" @ Caps(Team));

    // Award score and player points
    AOCCTF(WorldInfo.Game).SuccessfulCapture(Faction, PlayerPawnToCredit);
}

exec function AdminDecreaseScore(string Team, optional string PlayerName) {
    S_AdminDecreaseScore(Team, PlayerName);
}

reliable server function S_AdminDecreaseScore(string Team, optional string PlayerName) {
    local EAOCFaction Faction;
    local AOCPlayerController PlayerControllerToDiscredit;
    local AOCPawn PlayerPawnToDiscredit;

    // Verify admin permissions
    if (!IsAdmin()) {
        NotifyNotAdmin();
        return;
    }

    // Verify gamemode is CTF
    if (AOCCTF(WorldInfo.Game) == none) {
        ClientDisplayConsoleMessage("The current gamemode is not CTF.");
        return;
    }

    // Resolve team
    if (Team ~= "agatha") {
        Faction = EFAC_AGATHA;
    } else if (Team ~= "mason") {
        Faction = EFAC_MASON;
    } else {
        ClientDisplayConsoleMessage("'" $ Team $ "' is not a valid team. Use AGATHA or MASON.");
        return;
    }

    // Resolve player to discredit
    // Try to match a player controller
    PlayerControllerToDiscredit = AOCPlayerController(WorldInfo.Game.AccessControl.GetControllerFromString(PlayerName));

    PlayerPawnToDiscredit = PlayerControllerToDiscredit != none
        ? AOCPawn(PlayerControllerToDiscredit.Pawn)                 // If a player controller was matched use it's pawn
        : AOCPawn(Pawn);                                            // Otherwise use this function caller's pawn

    // Log action to players
    S_BroadcastServerMessage("AdminDecreaseScore:" @ Caps(Team));

    // Remove team score, permitting negatives
    if (Faction == EFAC_AGATHA) {
        AOCCTF(WorldInfo.Game).AgathaCaptures -= 1;
        AOCCTFGRI(WorldInfo.Game.GameReplicationInfo).AgathaCaptures -= 1;
    }
    else if (Faction == EFAC_MASON) {
        AOCCTF(WorldInfo.Game).MasonCaptures -= 1;
        AOCCTFGRI(WorldInfo.Game.GameReplicationInfo).MasonCaptures -= 1;
    }

    // Remove points from player
    AOCPRI(PlayerPawnToDiscredit.PlayerReplicationInfo).Score -= AOCCTF(WorldInfo.Game).POINTS_PER_FLAG_CAPTURE;
}
