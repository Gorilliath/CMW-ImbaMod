class ImbaModAccessControl extends AOCAccessControl;


var config array<string> WhitelistedAdminSteamID64;


function bool IsWhitelistedAdmin(PlayerController PC)
{
    local string PlayerSteamID64, AdminSteamID64;

    PlayerSteamID64 = OnlineSubsystemSteamworks(PC.OnlineSub).UniqueNetIdToInt64(PC.PlayerReplicationInfo.UniqueId);

    if (PlayerSteamID64 == "")
        return false;

    foreach WhitelistedAdminSteamID64(AdminSteamID64)
    {
        if (PlayerSteamID64 == AdminSteamID64)
            return true;
    }

    return false;
}

function LoginAdminIfWhitelisted(PlayerController PC)
{
    if (IsWhitelistedAdmin(PC))
        PC.PlayerReplicationInfo.bAdmin = true;
}
