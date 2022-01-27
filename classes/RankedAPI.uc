class RankedAPI extends Object;


var string baseURL;
var string key;


delegate OnProcessComplete(HttpRequestInterface OriginalRequest, HttpResponseInterface Response, bool bDidSucceed);


static function DoNothing(HttpRequestInterface OriginalRequest, HttpResponseInterface Response, bool bDidSucceed){}


// Endpoints
static function OnUserConnect(string steamID64,
                              optional string playerIP,
                              optional string mapName,
                              optional delegate<OnProcessComplete> OnProcessComplete = DoNothing)
{
    local GUID GUID;

    GUID = CreateGuid();

    if (playerIP == "")
        playerIP = "?";
    if (mapName == "")
        mapName = "?";

    class'HttpFactory'.static.CreateRequest()
        .SetURL(default.baseURL $ "OnUserConnect"
                                $ "?key=" $ default.key
                                $ "&steamid64=" $ steamID64
                                $ "&GUID=" $ GetStringFromGuid(GUID))
        .SetVerb("GET")
        .SetHeader("playerIP", playerIP)
        .SetHeader("mapName", mapName)
        .SetProcessRequestCompleteDelegate(OnProcessComplete)
        .ProcessRequest();
}

static function OnUserDisconnect(string steamID64, optional delegate<OnProcessComplete> OnProcessComplete = DoNothing)
{
    local GUID GUID;

    GUID = CreateGuid();

    class'HttpFactory'.static.CreateRequest()
        .SetURL(default.baseURL $ "OnUserDisconnect"
                                $ "?key=" $ default.key
                                $ "&steamid64=" $ steamID64
                                $ "&GUID=" $ GetStringFromGuid(GUID))
        .SetVerb("GET")
        .SetProcessRequestCompleteDelegate(OnProcessComplete)
        .ProcessRequest();
}

static function CalculateMatchMaking(Array<String> steamIDs64, int teamSize, optional delegate<OnProcessComplete> OnProcessComplete = DoNothing)
{
    local string stringSteamIDs;
    local JsonObject payload;

    JoinArray(steamIDs64, stringSteamIDs);
    payload = new class'JsonObject';
    payload.SetStringValue("steamids64", stringSteamIDs);

    class'HttpFactory'.static.CreateRequest()
        .SetURL(default.baseURL $ "CalculateMatchMaking"
                                $ "?key=" $ default.key
                                $ "&size=" $ teamSize)
        .SetVerb("POST")
        .SetHeader("Content-Type", "application/json")
        .SetContentAsString(class'JsonObject'.static.EncodeJson(payload))
        .SetProcessRequestCompleteDelegate(OnProcessComplete)
        .ProcessRequest();
}

static function CalculateNewElos(string sCompletedMatchRequestData, optional delegate<OnProcessComplete> OnProcessComplete = DoNothing)
{
    class'HttpFactory'.static.CreateRequest()
        .SetURL(default.baseURL $ "CalculateNewElos"
                                $ "?key=" $ default.key)
        .SetVerb("POST")
        .SetHeader("Content-Type", "application/json")
        .SetContentAsString(sCompletedMatchRequestData)
        .SetProcessRequestCompleteDelegate(OnProcessComplete)
        .ProcessRequest();
}


// Payload handling
static function GetTeamsSteamID64s(string sMatchmakingResponse, out array<string> TeamOneSteamID64s, out array<string> TeamTwoSteamID64s)
{
    local JsonObject jMatchmakingResponse,
                     jTeamOnePlayers,
                     jTeamTwoPlayers,
                     jPlayer;

    jMatchmakingResponse = class'JsonObject'.static.DecodeJson(sMatchmakingResponse);

    jTeamOnePlayers = jMatchmakingResponse.GetObject("response")
                                          .GetObject("items")
                                          .GetObject("Team1")
                                          .GetObject("players");

    jTeamTwoPlayers = jMatchmakingResponse.GetObject("response")
                                          .GetObject("items")
                                          .GetObject("Team2")
                                          .GetObject("players");

    // Clear any previous data from referenced arrays
    TeamOneSteamID64s.Remove(0, TeamOneSteamID64s.Length);
    TeamTwoSteamID64s.Remove(0, TeamTwoSteamID64s.Length);

    foreach jTeamOnePlayers.ObjectArray(jPlayer)
    {
        TeamOneSteamID64s.AddItem(jPlayer.GetStringValue("_id"));
    }

    foreach jTeamTwoPlayers.ObjectArray(jPlayer)
    {
        TeamTwoSteamID64s.AddItem(jPlayer.GetStringValue("_id"));
    }
}

static function GetTeamsAverageElos(string sMatchmakingResponse, out float TeamOneAverageElo, out float TeamTwoAverageElo)
{
    local JsonObject jMatchmakingResponse,
                     jTeamOne,
                     jTeamTwo;

    jMatchmakingResponse = class'JsonObject'.static.DecodeJson(sMatchmakingResponse);

    jTeamOne = jMatchmakingResponse.GetObject("response")
                                   .GetObject("items")
                                   .GetObject("Team1");

    jTeamTwo = jMatchmakingResponse.GetObject("response")
                                   .GetObject("items")
                                   .GetObject("Team2");

    TeamOneAverageElo = jTeamOne.GetIntValue("eloSum") / jTeamOne.GetObject("players").ObjectArray.Length;
    TeamTwoAverageElo = jTeamTwo.GetIntValue("eloSum") / jTeamTwo.GetObject("players").ObjectArray.Length;
}


DefaultProperties
{
    baseURL = "https://rufuspitt.com/api/";
    key = "";
}
