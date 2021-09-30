class ImbaModTO extends AOCTeamObjective;

`include(ImbaMod/Include/ImbaModTO.uci)
`include(ImbaMod/Include/ImbaModGame.uci)


function ActivateNextObjectiveStage()
{
    local AOCPlayerController PC;
    local int i;
    local int PrevTimeLeft;
    local bool bNotifyStopTwoMin;
    local float AttackerProgress;


    CurrentObjectiveStage += 1;
    bNotifyStopTwoMin = false;
    AOCTOGRI(GameReplicationInfo).ObjectiveIndex = CurrentObjectiveStage;
    if (CurrentObjectiveStage != 0)
    {
        AllObjectives[CurrentObjectiveStage-1].CompletionTime = WorldInfo.TimeSeconds - GameStartTime;

        AllObjectives[CurrentObjectiveStage-1].CurVar = AOCTOGRI(GameReplicationInfo).CurObjective.CurVar;
        AllObjectives[CurrentObjectiveStage-1].MaxVar = AOCTOGRI(GameReplicationInfo).CurObjective.MaxVar;
        AllObjectives[CurrentObjectiveStage-1].ExtraVar = AOCTOGRI(GameReplicationInfo).CurObjective.ExtraVar;

        AttackerProgress = AOCGRI(GameReplicationInfo).GetTeamProgress(AttackingTeam);

        if (AttackerProgress > 0.0f)
        {
            AllObjectives[CurrentObjectiveStage-1].CurVar = AttackerProgress;
            AllObjectives[CurrentObjectiveStage-1].MaxVar = 1.0f;
        }

        PrevTimeLeft = TimeLeft;
        // Add bonus time we get from completing objective
        TimeLeft += AllObjectives[CurrentObjectiveStage-1].BonusTime;

        bNotifyStopTwoMin = PrevTimeLeft <= 120 && TimeLeft > 120;
    }
    CurrentObjStartTime = WorldInfo.TimeSeconds;

    // Clear out the stage objectives in previous and current objectives
    for (i = 0; i < 7; i++)
    {
        AOCTOGRI(GameReplicationInfo).PrevObjective.StageObjectives[i] = none;
        AOCTOGRI(GameReplicationInfo).NextObjective.StageObjectives[i] = none;
    }

    // Pass to GRI
    // Previous Objective
    if (CurrentObjectiveStage - 1 >= 0)
        AOCTOGRI(GameReplicationInfo).PrevObjective = AllObjectives[CurrentObjectiveStage-1];

    // Current Objective
    AOCTOGRI(GameReplicationInfo).CurObjective = AllObjectives[CurrentObjectiveStage];
    if (WorldInfo.NetMode == NM_Standalone || Worldinfo.NetMode == NM_ListenServer)
        AOCTOGRI(GameReplicationInfo).ReplicatedEvent('CurObjective');

    // Next Objective
    if (CurrentObjectiveStage + 1 < AllObjectives.Length)
        AOCTOGRI(GameReplicationInfo).NextObjective = AllObjectives[CurrentObjectiveStage+1];
    else
        AOCTOGRI(GameReplicationInfo).NextObjective.StageObjectives[0] = none;

    AOCTOGRI(GameReplicationInfo).bForceNetUpdate = TRUE;

    // Notify all players of next objective in chat
    foreach WorldInfo.AllControllers(class'AOCPlayerController', PC)
    {
        if (bNotifyStopTwoMin)
            PC.StopLowTimeMusic();
    }

    // Do this ~0.5 seconds later to make sure the objective complete/failed messages are replicated first
    if (CurrentObjectiveStage != 0)
        SetTimer(0.5f, false, 'ShowNextObjectiveText');
    else
        ShowNextObjectiveText();
}

function ObjectiveEndGame(EAOCFaction Winner)
{
    local float AttackerProgress;

    TheWinningTeam = Winner;

    if (CurrentObjectiveStage != 0)
    {
        AllObjectives[CurrentObjectiveStage].CompletionTime = TimeLeft;

        AllObjectives[CurrentObjectiveStage].CurVar = AOCTOGRI(GameReplicationInfo).CurObjective.CurVar;
        AllObjectives[CurrentObjectiveStage].MaxVar = AOCTOGRI(GameReplicationInfo).CurObjective.MaxVar;
        AllObjectives[CurrentObjectiveStage].ExtraVar = AOCTOGRI(GameReplicationInfo).CurObjective.ExtraVar;

        AttackerProgress = AOCGRI(GameReplicationInfo).GetTeamProgress(AttackingTeam);

        if (AttackerProgress > 0.0f)
        {
            AllObjectives[CurrentObjectiveStage].CurVar = AttackerProgress;
            AllObjectives[CurrentObjectiveStage].MaxVar = 1.0f;
        }
    }

    EndGame(GetHighestScoreFromTeam(Winner), "TimeLimit");
}


DefaultProperties
{
    MinimumRespawnTime = 10.0
}
