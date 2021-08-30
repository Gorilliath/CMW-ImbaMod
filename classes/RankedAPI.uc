class RankedAPI extends Object;


var string baseURL;
var string key;


delegate OnProcessComplete(HttpRequestInterface OriginalRequest, HttpResponseInterface Response, bool bDidSucceed);


static function DoNothing(HttpRequestInterface OriginalRequest, HttpResponseInterface Response, bool bDidSucceed){}


// Endpoints
static function OnUserConnect(string steamID64, optional string playerIP, optional delegate<OnProcessComplete> OnProcessComplete = DoNothing)
{
    local GUID GUID;

    GUID = CreateGuid();

    if (playerIP == "")
        playerIP = "?";

    class'HttpFactory'.static.CreateRequest()
        .SetURL(default.baseURL $ "OnUserConnect"
                                $ "?key=" $ default.key
                                $ "&steamid64=" $ steamID64
                                $ "&GUID=" $ GetStringFromGuid(GUID))
        .SetVerb("GET")
        .SetHeader("playerIP", playerIP)
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
static function GetTeamPlayerIDs(string MatchResponseData, out array<string> AgathaPlayerIDs, out array<string> MasonPlayerIDs)
{
    local JsonObject jMatchResponseData,
                     TeamOnePlayers,
                     TeamTwoPlayers,
                     PlayerInfo;

    jMatchResponseData = class'JsonObject'.static.DecodeJson(MatchResponseData);

    AgathaPlayerIDs.Remove(0, 100);
    MasonPlayerIDs.Remove(0, 100);

    TeamOnePlayers = jMatchResponseData
        .GetObject("response")
        .GetObject("items")
        .GetObject("Team1")
        .GetObject("players");

    TeamTwoPlayers = jMatchResponseData
        .GetObject("response")
        .GetObject("items")
        .GetObject("Team2")
        .GetObject("players");

    foreach TeamOnePlayers.ObjectArray(PlayerInfo)
    {
        AgathaPlayerIDs.AddItem(PlayerInfo.GetStringValue("_id"));
    }

    foreach TeamTwoPlayers.ObjectArray(PlayerInfo)
    {
        MasonPlayerIDs.AddItem(PlayerInfo.GetStringValue("_id"));
    }
}


DefaultProperties
{
    baseURL = "https://rufuspitt.com/api/";
    key = "";
}
