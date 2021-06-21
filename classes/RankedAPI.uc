class RankedAPI extends Object;


var string baseURL;
var string key;
var string chatColourHex;


delegate OnProcessComplete(HttpRequestInterface OriginalRequest, HttpResponseInterface Response, bool bDidSucceed);


function DoNothing(HttpRequestInterface OriginalRequest, HttpResponseInterface Response, bool bDidSucceed){}

function OnUserConnect(string steamID64, optional delegate<OnProcessComplete> OnProcessComplete = DoNothing)
{
    class'HttpFactory'.static.CreateRequest()
        .SetURL(baseURL $ "OnUserConnect?steamid64=" $ steamID64 $ "&key=" $ key)
        .SetVerb("GET")
        .SetProcessRequestCompleteDelegate(OnProcessComplete)
        .ProcessRequest();
}

function OnUserDisconnect(string steamID64, optional delegate<OnProcessComplete> OnProcessComplete = DoNothing)
{
    class'HttpFactory'.static.CreateRequest()
        .SetURL(baseURL $ "OnUserDisconnect?steamid64=" $ steamID64 $ "&key=" $ key)
        .SetVerb("GET")
        .SetProcessRequestCompleteDelegate(OnProcessComplete)
        .ProcessRequest();
}

function CalculateMatchMaking(Array<String> steamIDs64, int teamSize, optional delegate<OnProcessComplete> OnProcessComplete = DoNothing)
{
    local string stringSteamIDs;
    local JsonObject payload;

    JoinArray(steamIDs64, stringSteamIDs);
    payload = new class'JsonObject';
    payload.SetStringValue("steamids64", stringSteamIDs);

    class'HttpFactory'.static.CreateRequest()
        .SetURL(baseURL $ "CalculateMatchMaking?size=" $ teamSize $ "&key=" $ key)
        .SetVerb("POST")
        .SetHeader("Content-Type", "application/json")
        .SetContentAsString(class'JsonObject'.static.EncodeJson(payload))
        .SetProcessRequestCompleteDelegate(OnProcessComplete)
        .ProcessRequest();
}


function BroadcastMessageToAll(string Message)
{
    local AOCPlayerController PC;
    foreach class'Worldinfo'.static.GetWorldInfo().AllControllers(class'AOCPlayerController', PC)
    {
        PC.ReceiveChatMessage(Message, EFAC_ALL, false, true, chatColourHex, false);
    }
}

function GetTeamPlayerIDs(JsonObject MatchResponseData, out array<string> AgathaPlayerIDs, out array<string> MasonPlayerIDs)
{
    local JsonObject TeamOnePlayers,
                     TeamTwoPlayers,
                     PlayerInfo;

    AgathaPlayerIDs.Remove(0, 100);
    MasonPlayerIDs.Remove(0, 100);

    TeamOnePlayers = MatchResponseData
        .GetObject("response")
        .GetObject("items")
        .GetObject("Team1")
        .ObjectArray[0];

    TeamTwoPlayers = MatchResponseData
        .GetObject("response")
        .GetObject("items")
        .GetObject("Team2")
        .ObjectArray[0];

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
    chatColourHex = "#00BFFF";
}
