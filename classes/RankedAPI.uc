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
    foreach class'Worldinfo'.static.GetWorldInfo().AllControllers(class'AOCPlayerController', PC) {
        PC.ReceiveChatMessage(Message, EFAC_ALL, false, true, chatColourHex, false);
    }
}


DefaultProperties
{
    baseURL = "https://rufuspitt.com/api/";
    key = "";
    chatColourHex = "#3498db";
}
