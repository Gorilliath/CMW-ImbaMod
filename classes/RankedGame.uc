class RankedGame extends Actor;


var string MatchmakingResponse;         // JSON string response from remote service /CalculateMatchMaking
var string Map;                         // What map the game should be played on
var int TeamSize;                       // How many players should be on each team
var int GameSize;                       // How many matches should be played
var array<string> CompletedMatches;     // JSON string results of each completed match
var bool ReadyToPlay;                   // Whether the match (or round) can be started
var bool Cancelled;                     // Whether an admin has cancelled the entire game


function bool IsComplete()
{
    return CompletedMatches.Length == GameSize;
}

function JsonObject GetMatchmakingResponseObject()
{
    return class'JsonObject'.static.DecodeJson(MatchmakingResponse);
}

function GetTeamsSteamID64s(out array<string> TeamOneSteamID64s, out array<string> TeamTwoSteamID64s)
{
    class'RankedAPI'.static.GetTeamsSteamID64s(MatchmakingResponse, TeamOneSteamID64s, TeamTwoSteamID64s);
}

function GetTeamsAverageElos(out float TeamOneAverageElo, out float TeamTwoAverageElo)
{
    class'RankedAPI'.static.GetTeamsAverageElos(MatchmakingResponse, TeamOneAverageElo, TeamTwoAverageElo);
}


DefaultProperties
{

}
