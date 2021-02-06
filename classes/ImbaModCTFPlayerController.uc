class ImbaModCTFPlayerController extends AOCCTFPlayerController
    dependson(ImbaModCTF);

`include(ImbaMod/Include/ImbaModCTF.uci)
`include(ImbaMod/Include/ImbaModPlayerController.uci)


exec function AdminResetFlags() {
    if (!PlayerReplicationInfo.bAdmin) {
        ClientDisplayConsoleMessage("You are not logged in as an administrator on this server.");
        return;
    }

    S_AdminResetFlags();
}

reliable server function S_AdminResetFlags() {
    local AOCFlag Flag;

    // Verify admin permissions
    if (!IsAdmin()) {
        ClientDisplayConsoleMessage("You are not logged in as an administrator on this server.");
        return;
    }

    // Verify gamemode is CTF
    if (AOCCTF(WorldInfo.Game) == none) {
        ClientDisplayConsoleMessage("The current gamemode is not CTF.");
        return;
    }

    // Log action to players
    S_AdminBroadcastMessage("AdminResetFlags");

    // Reset Agatha flag
    Flag = AOCCTF(Worldinfo.Game).GetActiveFlag(EFAC_Agatha);
    if (Flag.CurrentUser != none)
        Flag.DropFlag(Flag.CurrentUser, false);
    Flag.DeactivateFlag();
    Flag.ResetFlag(false);

    // Reset Mason flag
    Flag = AOCCTF(Worldinfo.Game).GetActiveFlag(EFAC_Mason);
    if (Flag.CurrentUser != none)
        Flag.DropFlag(Flag.CurrentUser, false);
    Flag.DeactivateFlag();
    Flag.ResetFlag(false);

    // Set new flags
    AOCCTF(Worldinfo.Game).ChooseRandomFlag(EFAC_AGATHA);
    AOCCTF(Worldinfo.Game).ChooseRandomFlag(EFAC_MASON);
}

exec function AdminIncreaseScore(string Team, optional string PlayerName) {
    if (!PlayerReplicationInfo.bAdmin) {
        ClientDisplayConsoleMessage("You are not logged in as an administrator on this server.");
        return;
    }

    S_AdminIncreaseScore(Team, PlayerName);
}

reliable server function S_AdminIncreaseScore(string Team, optional string PlayerName) {
    local EAOCFaction Faction;
    local AOCPlayerController PlayerControllerToCredit;
    local AOCPawn PlayerPawnToCredit;

    // Verify admin permissions
    if (!IsAdmin()) {
        ClientDisplayConsoleMessage("You are not logged in as an administrator on this server.");
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
    S_AdminBroadcastMessage("AdminIncreaseScore for team" @ Caps(Team));

    // Award score
    AOCCTF(WorldInfo.Game).SuccessfulCapture(Faction, PlayerPawnToCredit);
}
