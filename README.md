# ImbaMod  
*x1 x4 z5 xx2 xx2 xx2 xx2 xx2*

---

Forked from CompMod 2.0.2

[CHANGELOG](CHANGELOG.md)  
[KNOWN ISSUES](KNOWN-ISSUES.md)

[STEAM WORKSHOP](https://steamcommunity.com/sharedfiles/filedetails/?id=2358740950)

---

## Ranked Mode  
*A sub-mode presently compatible with all vanilla team game-modes except for Team Objective.*

**General Flow**  
- Players join any team to 'queue' (spectators are not considered ready to play)  
- The game periodically sends all queuing players to the remote service until a match is successfully made.  
- Resulting teams are enforced and locked until the match is concluded.  
- After a match concludes, player and team KPIs are sent to the remote service along with the match result.

**Commands**  
| Command              | Argument                | Description        |  
|----------------------|-------------------------|--------------------|  
| Admin RankedMode     | 0 (disable) 1 (enable)  | Toggle ranked mode |  
| Admin RankedTeamSize | 1 - half of max players | Sets the desired team size and therefore match size |

**Miscellaneous**  
- Incompatible with tournament mode; enabling one will disable the other!  
- Configurable per game-mode.  
- Player names are prepended with their skill rating.  
- Team names display the team's average skill rating.  
- Communicates with [Warlock's](https://steamcommunity.com/profiles/76561198088696466) remote service.
