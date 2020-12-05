Changelog
=========

Note: The base values in this document are taken from Mercs Mod 1.995 (thanks GIRU GIRU for providing the numbers for this).

---

# 2.0.2
* Increased messer feint recovery on LMB/overhead (0.3 -> 0.325)
* Increased messer feint recovery on stabs (0.43 -> 0.45)
* Increased messer feint recovery on combos (0.535 -> 0.55)
* Increased longsword feint recovery on LMB/overhead (0.2 -> 0.225)
* Increased longsword feint recovery on combos (0.5 -> 0.525)
* Increased feint recovery on LMB/overhead for all polearms except halberd (0.2 -> 0.3)
* Increased feint recovery on stabs for all polearms except halberd (0.4 -> 0.45)
* Increased feint recovery on combos for all polearms except halberd (0.5 -> 0.55)
* Doubled handle tracers on polearms (this should reduce the amount of handlehits that occur)
* Increase horizontal turncap on all daggers, meaning you can turn faster (75000 -> 85000)
* Reduce turncap on halberd (55000 -> 45000)

# 2.0.1
* Fixed buggy handlehits on polearms from the previous patch
* Reduced halberd knockback on overhead/LMB from 34500 -> 30000
* Reduced halberd knockback on stab from 30175 -> 29000

# 2.0.0

**General Gameplay**

* Added mechanic to cancel ripostes into parries at any time<sup>1</sup>
* Ripostes are no longer flinchable during release state<sup>2</sup>
* MAA stamina on kill increased from 30 to 50
* MAA dodge out of parry cost increased from 25 to 30<sup>3</sup>
* MAA attack lockout after dodge decreased from 0.3 to 0.2 when dodging forwards
* MAA backpedal speed decreased from 0.85 to 0.8
* Archer projectile modifier for torso and arms increased from 2 to 2.25<sup>4</sup>

**Weapon Tweaks**

* Messer stab feint recovery increased from 0.400 to 0.435
* Messer combo feint recovery increased from 0.500 to 0.535
* Poleaxe turncap increased from 53000 to 53800
* Removed handle tracers from all polearms
* Halberd overhead windup increased from 0.600 to 0.625
* Hatchet overhead damage decreased from 95 to 85
* Hatchet swing damage decreased from 95 to 70
* Hatchet damage type for overheads and swings changed from swing to chop

**Console Commands**

* Added admingotoduel to change map to duelyard

**Notes**

* 1 - This mechanic costs 15 stamina not including the stamina drain of the parry
* 2 - Currently, ripostes are also unflinchable during windup, this makes them unflinchable at all times
* 3 - This only affects dodges during a parry, it does not affect normal dodges
* 4 - This is the damage archers take from projectiles, not the damage archer primary weapons deal. This allows light crossbow to 1 shot other archers without needing a headshot.

# 1.6.0
* Stamina values have been fully rewritten, new values can be found [here](https://docs.google.com/spreadsheets/d/1gaXfSi5lQ256lwTdCtGf68Hzlo7aJJf1jZUe5mlNTRA/edit?usp=sharing) while old values can be found [here](https://docs.google.com/spreadsheets/d/1oe2dZvHpgk-lW4AvaQkj5sE0ETmtme6Oabfw2Utof3g/edit?usp=sharing).
* Sword of War overhead damage decreased to 68 swing from 70 swing.
* Sword of War stab damage decreased to 63 pierce from 77.5 pierce.
* Sword of War stab windup decreased to 0.625 seconds from 0.7 seconds.
* Sword of War LMB release decreased to 0.5 seconds from 0.525 seconds.
* Sword of War stab release decreased to 0.375 seconds from 0.4 seconds.
* Sword of War stab feint recovery increased to 0.45 seconds from 0.4 seconds.

# 1.5.0
* Feint window increased on 2h weapons for both combos and normal attacks by 0.05
* Reduce throwing axe ammo to 1 and throwing knife ammo to 2
* Reduce initial projectile speed for firepots from 2000 to 1500
* Increase greatsword combo times on overhead and slash to 0.7
* Increase broadsword stab release to 0.35 and overhead release to 0.4

# 1.4.0

Feint window changes:
* Feint window reduction out of combos increased to (0.275) from (0.25)
* Feint recovery changes reverted for:
* 2H Longsword LMB reverted to (0.2) from (0.36)
* 2H Longsword overhead reverted to (0.2) from (0.36)
* 2H Messer stab reverted to (0.4) from (0.46)
* Greatsword LMB reverted to (0.2) from (0.26)
* Greatsword overhead reverted to (0.2) from (0.26)
* Greatsword stab reverted to (0.4) from (0.46)
* Claymore stab reverted to (0.4) from (0.46)

Feint recovery changes decreased for:
* 2H Longsword stab reduced to (0.45) from (0.52) - pre v1.2.0 was (0.4)
* 2H Messer LMB reduced to (0.3) from (0.36) - pre v1.2.0 was (0.2)
* 2H Messer overhead reduced to (0.3) from (0.36) - pre v1.2.0 was (0.2)
* 1H All Weapons stab reduced to (0.45) from (0.475) - pre v1.2.0 was (0.4)

Feint recovery changes remaining at 1.3.0 values for:
* 1H All weapons LMB will remain at (0.35) - pre v1.2.0 was (0.3)
* 1H All weapons overhead will remain at (0.35) - pre v1.2.0 was (0.3)
* 2H Sword of War LMB will remain at (0.28) - pre v1.2.0 was (0.2)
* 2H Sword of War overhead will remain at (0.28) - pre v1.2.0 was (0.2)
* Poleaxe LMB will remain at (0.18) - pre v1.2.0 was (0.2)
* Poleaxe overhead will remain at (0.18) - pre v1.2.0 was (0.2)
* Quaterstaff LMB will remain at (0.32) - pre v1.2.0 was (0.2)
* Quarterstaff overhead will remain at (0.32) - previously (0.2)
* Quarterstaff stab will remain at (0.46) - pre v1.2.0 was (0.4)

# 1.3.0
* Moved kick tracer down so it is now jumpable (Z=-10 -> Z=-65)
* Readded CauseEvent, but it now displays in chat when used (it can be useful to map makers sometimes)
* Fixed some sling zoom bugs
* Bardiche overhead damage type changed (CHOP -> CUT)
* Bardiche overhead damage increased (100 -> 105)
* Sword of War overhead release time decreased (0.525 -> 0.5)
* Quarterstaff overhead & LMB windups increased (0.4 & 0.45 -> 0.5)
* Waraxe overhead & LMB windups increased (0.4 & 0.45 -> 0.5)
* Holy Water Sprinkler overhead & LMB windups increased (0.4 & 0.45 -> 0.5)
* Flinch duration for two-handed weapons increased (0.9 -> 1.0)

#### 1.2.1
* Longsword stab feint recovery increased from (0.4) -> (0.52)
* Messer stab feint recovery increased from (0.4) -> (0.46)
* All 1H stab feint recoveries increased from (0.475) -> (0.52)
* Sword of war overhead / LMB feint recovery increased from (0.2 -> 0.28)
* Smoke pot and oil pot no longer flinch

# 1.2.0

#### KNIGHT PRIMARY WEAPONS
Poleaxe
* Horizontal swing feint recovery decreased from (0.2) to (0.18)
* Overhead feint recovery decreased from (0.2) to (0.18)

Bearded Axe
* Horizontal swing windup increased from (0.525) to (0.55)
* Stab windup increased from (0.55) to (0.6)
* Overhead stamina drain increased from (26) to (29)

Grand Mace
* Overhead windup increased from (0.575) to (0.6)
* Overhead release decreased from (0.6) to (0.575)

Longsword (2 Handed)
* Horizontal swing feint recovery increased from (0.2) to (0.36)
* Overhead feint recovery increased from (0.2) to (0.36)

Longsword (1 Handed)
* Horizontal swing feint recovery increased from (0.3) to (0.35)
* Overhead feint recovery increased from (0.3) to (0.35)
* Stab feint recovery increased from (0.4) to (0.475)

Messer (2 Handed)
* Overhead release time decreased from (0.6) to (0.575)
* Horizontal swing feint recovery increased from (0.2) to (0.36)
* Overhead feint recovery increased from (0.2) to (0.36)

#### KNIGHT TERTIARY WEAPONS
Throwing Knives
* Damage to archer head decreased to (76) from (86)

Throwing Axes
* Damage to archer head decreased to (119) from (135)

#### VANGUARD PRIMARY WEAPONS
Greatsword
* Overhead windup increased from (0.55) to (0.575)
* Horizontal swing feint recovery increased from (0.2) to (0.26)
* Overhead feint recovery increased from (0.2) to (0.26)
* Stab feint recovery increased from (0.4) to (0.46)

Claymore
* Stab feint recovery increased from (0.4) to (0.46)

Spear
* Overhead recovery decreased from (0.725) to (0.675)
* Stab recovery decreased from (0.65) to (0.625)

Bardiche
* Alternate horizontal swing into stab combo increased from (0.7) to (0.8)

Billhook
* Alternate horizontal swing into stab combo increased from (0.7) to (0.8)
* Horizontal swing stamina drain increased from (25) to (27)
* Overhead stamina drain increased from (27) to (29)
* Stab stamina drain increased from (26) to (28)

Halberd
* Overhead release time decreased from (0.6) to (0.575)
* Alternate horizontal swing into stab combo increased from (0.7) to (0.8)

Polehammer
* Polehammer alt-LMB to stab combo (0.725 -> 0.825)

#### VANGUARD TERTIARY WEAPONS
Smoke Pots
* Ammo increased to 3
* Initial projectile speed increased from (1500) to (2000)
* Maximum projectile speed increased from (2000) to (2500)

#### MAN AT ARMS PRIMARY WEAPONS
Broadsword
* Horizontal swing feint recovery increased from (0.3) to (0.35)
* Overhead feint recovery increased from (0.3) to (0.35)
* Stab feint recovery increased from (0.4) to (0.475)

Norse Sword
* Horizontal swing feint recovery increased from (0.3) to (0.35)
* Overhead feint recovery increased from (0.3) to (0.35)
* Stab feint recovery increased from (0.4) to (0.475)

Falchion
* Horizontal swing feint recovery increased from (0.3) to (0.35)
* Overhead feint recovery increased from (0.3) to (0.35)
* Stab feint recovery increased from (0.4) to (0.475)

Hatchet
* Horizontal swing feint recovery increased from (0.3) to (0.35)
* Overhead feint recovery increased from (0.3) to (0.35)
* Stab feint recovery increased from (0.4) to (0.475)

War Axe
* Horizontal swing feint recovery increased from (0.3) to (0.35)
* Overhead feint recovery increased from (0.3) to (0.35)
* Stab feint recovery increased from (0.4) to (0.475)

Dane Axe
* Horizontal swing feint recovery increased from (0.3) to (0.35)
* Overhead feint recovery increased from (0.3) to (0.35)
* Stab feint recovery increased from (0.4) to (0.475)

Mace
* Horizontal swing feint recovery increased from (0.3) to (0.35)
* Overhead feint recovery increased from (0.3) to (0.35)
* Stab feint recovery increased from (0.4) to (0.475)

Morningstar
* Horizontal swing feint recovery increased from (0.3) to (0.35)
* Overhead feint recovery increased from (0.3) to (0.35)
* Stab feint recovery increased from (0.4) to (0.475)

Holy Water Sprinkler
* Horizontal swing feint recovery increased from (0.3) to (0.35)
* Overhead feint recovery increased from (0.3) to (0.35)
* Stab feint recovery increased from (0.4) to (0.475)

Quaterstaff
* Horizontal swing feint recovery increased from (0.2) to (0.32)
* Overhead feint recovery increased from (0.2) to (0.32)
* Stab feint recovery increased from (0.4) to (0.46)

#### MAN AT ARMS SECONDARY WEAPONS
Shortsword
* Horizontal swing feint recovery increased from (0.3) to (0.35)
* Overhead feint recovery increased from (0.3) to (0.35)
* Stab feint recovery increased from (0.4) to (0.475)

Sabre
* Horizontal swing feint recovery increased from (0.3) to (0.35)
* Overhead feint recovery increased from (0.3) to (0.35)
* Stab feint recovery increased from (0.4) to (0.475)

Cudgel
* Horizontal swing feint recovery increased from (0.3) to (0.35)
* Overhead feint recovery increased from (0.3) to (0.35)
* Stab feint recovery increased from (0.4) to (0.475)

Broad Dagger
* Horizontal swing feint recovery increased from (0.3) to (0.35)
* Overhead feint recovery increased from (0.3) to (0.35)
* Stab feint recovery increased from (0.4) to (0.475)

Hunting Knife
* Horizontal swing feint recovery increased from (0.3) to (0.35)
* Overhead feint recovery increased from (0.3) to (0.35)
* Stab feint recovery increased from (0.4) to (0.475)

Thrusting Dagger
* Horizontal swing feint recovery increased from (0.3) to (0.35)
* Overhead feint recovery increased from (0.3) to (0.35)
* Stab feint recovery increased from (0.4) to (0.475)

#### ARCHER PRIMARY WEAPONS
Longbow
* Bodkin arrows removed
* Broadhead damage to knight to head decreased to (42) from (46)
* Broadhead damage to knight to torso decreased to (21) from (23)
* Broadhead damage to knight to legs decreased to (14) from (15)
* Broadhead damage to vanguard to head decreased to (63) from (68)
* Broadhead damage to vanguard to torso decreased to (32) from (34)
* Broadhead damage to vanguard to legs decreased to (21) from (22)
* Broadhead damage to man at arms to head decreased to (90) from (97)
* Broadhead damage to man at arms to torso decreased to (45) from (49)
* Broadhead damage to man at arms to legs decreased to (29) from (31)
* Broadhead damage to archer to head decreased to (155) from (188)
* Broadhead damage to archer to torso decreased to (102) from (110)
* Broadhead damage to archer to legs decreased to (38) from (41)
* Arrow cam removed

Shortbow
* Broadhead arrows removed
* Bodkin damage to knight to head decreased to (49) from (50)
* Bodkin damage to knight to torso decreased to (24) from (25)
* Bodkin damage to vanguard to head decreased to (65) from (68)
* Bodkin damage to vanguard to torso decreased to (33) from (34)
* Bodkin damage to vanguard to legs decreased to (21) from (22)
* Bodkin damage to man at arms to head decreased to (70) from (72)
* Bodkin damage to man at arms to torso decreased to (35) from (36)
* Bodkin damage to archer to head decreased to (99) from (115)
* Bodkin damage to archer to torso decreased to (65) from (67)
* Bodkin damage to archer to legs decreased to (24) from (25)
* Arrow cam removed

Warbow
* Broadhead arrows removed
* Bodkin damage to knight to head increased to (74) from (72)
* Bodkin damage to knight to torso increased to (37) from (36)
* Bodkin damage to knight to legs increased to (24) from (23)
* Bodkin damage to vanguard to head increased to (99) from (98)
* Bodkin damage to vanguard to torso increased to (50) from (49)
* Bodkin damage to vanguard to legs increased to (33) from (32)
* Bodkin damage to man at arms to head increased to (107) from (104)
* Bodkin damage to man at arms to torso increased to (54) from (52)
* Bodkin damage to man at arms to legs increased to (35) from (34)
* Bodkin damage to archer to head decreased to (151) from (166)
* Bodkin damage to archer to torso increased to (100) from (97)
* Bodkin damage to archer to legs increased to (37) from (36)
* Arrow cam removed

Crossbow
* Arrow cam removed

Light Crossbow
* Arrow cam removed

Heavy Crossbow
* Arrow cam removed

Javelins
* Thrown damage to archer head decreased to (167) from (189)
* Arrow cam removed

Short Spears
* Thrown damage to archer head decreased to (155) from (176)
* Arrow cam removed

Heavy Javelins
* Thrown damage to archer head decreased to (215) from (243)
* Arrow cam removed

Sling
* Pebble minimum damage to archer head decreased to (45) from (50)
* Pebble maximum damage to archer head decreased to (74) from (84)
* Lead ball minimum damage to archer head decreased to (37) from (42)
* Lead ball maximum damage to archer head decreased to (104) from (118)
* Added zoom feature
* Arrow cam removed

#### OTHER GAMEPLAY CHANGES
* Removed stamina gain on teamkills

#### ADMINISTRATOR COMMANDS
All Modes
* Added 'AdminBroadcastMessage' command - will send chat message in yellow to all players
* AdminForceSpectate will alert you that you are not logged in as an administrator if you attempt to use it as a regular user
* AdminChangeTeam will alert you that you are not logged in as an administrator if you attempt to use it as a regular user
* AdminCancelVote will alert you that you are not logged in as an administrator if you attempt to use it as a regular user
* AdminReadyAll will alert you that you are not logged in as an administrator if you attempt to use it as a regular user
* AdminChangeTeamdDamageAmount will alert you that you are not logged in as an administrator if you attempt to use it as a regular user

Tournament Mode
* Tournament mode greeting message will no longer be sent on respawn

Normal Mode
* AdminForceSpectate will display in chat on use
* AdminChangeTeam will display in chat on use
* AdminCancelVote will display in chat on use
* AdminReadyAll will display in chat on use
* AdminChangeTeamdDamageAmount will display in chat on use

#### 1.1.1
+ Added `AdminForceSpectate` command (similar to `AdminChangeTeam`) which forces a player into spectate mode
+ Added `AdminGotoMoor` and `AdminGotoDF` commands, simply aliases for `AdminChangeMap AOCLTS-Moor_p` and `AdminChangeMap AOCTO-Darkforest_p` respectively
* Fixed not being able to parry shortly after dodge
* Falchion damage reduced (95 -> 90)
* Bardiche overhead release time decreased (0.6s -> 0.55s)
* Bardiche horizontal turncap while attacking nerfed (55000 -> 49500)
* FOV console command no longer requires weapon switch if above 120. Also introduces FOV cap of 165.
* You are no longer able to parry ballista bolts
* Improved projectile hit detection again (uses a directional system again rather than the parry tracer)
- Removed the invisible Mercs pitchfork which was selectable
- Removed standing health regen on king (now same as vanilla)
- Removed `CauseEvent` / `CE` admin commands

## 1.1.0
+ Fists always flinch
+ Added `GetAdmins` console command which tells you a list of logged-in admins
* F10 suicide delay reduced (5.0s -> 1.0s)
* Improved hit detection for projectiles
* Kick flinches (unless the other player has a shield raised)
* Shield heavy bash stuns a raised shield
* Spear overhead/long attack knockback reduced by 15% (31500 -> 26775)
* Halberd stab knockback reduced by 15% (35500 -> 30175)
* Longsword LMB damage reduced (84 -> 79)
* Norse sword stab damage reduced (59 -> 57)
* Bubble reduced (50 -> 39)
* Reduced weapon sheath times on all bows, crossbows and sling (0.5s -> 0.2s)
* Javelins can't be fliched while raised (fixes parry lockout issue)
- Disabled team flinch during pre-game warmup
- Removed PauseBreak exploit which allowed a non-admin to unpause


#### 1.0.2
* Firepots and smokepots are no longer parryable by non-shield weapons
- Projectiles don't flinch you if they hit a teammate

#### 1.0.1
* Projectiles can no longer be backparried
- Fists can no longer parry projectiles

# 1.0.0
+ Added the ability to parry projectiles with normal weapons (15 stamina)
+ If you attack a teammate, you get flinched (they still take damage)
+ Man-at-Arms is now locked out of attacking for 300ms after dodging
* ~~Reverted bubble size back to vanilla (50 -> 39)~~
* Raised SoW stab windup (0.65 -> 0.7)
* Raised SoW stab damage (68 -> 77.5)
* Raised SoW overhead windup (0.525 -> 0.55)
* Raised SoW combo speeds (all 0.675 -> 0.7)
- Removed the flinch/stun effect from kick
