# Source Audit — Where every tool comes from

Each row in the table below corresponds to a `get` call inside `fetch.sh`. Use this list to verify every upstream before running the fetcher, or to satisfy due-diligence requirements for a client engagement.

Click any **Repo / Source** link to inspect the maintainer, star count, license, last commit, release notes, and (where applicable) CI build logs.

> **No binaries are committed to this repo.** Every file is downloaded directly from the URL listed below at install time.

---

## Tier A — Official / first-party

Microsoft-signed, project upstream, or canonical author releases.

| Tool | Repo / Source | Maintainer |
|---|---|---|
| Sysinternals: `PsExec`, `PsExec64`, `procdump`, `procdump64`, `accesschk`, `accesschk64`, `PsLoggedon`, `PsLoggedon64` | <https://live.sysinternals.com/> | Microsoft Corporation |
| `mimikatz` (full bundle) | <https://github.com/gentilkiwi/mimikatz> | Benjamin Delpy (gentilkiwi) |
| `chisel` (linux + win) | <https://github.com/jpillora/chisel> | Jaime Pillora |
| `ligolo-ng` (agent + proxy) | <https://github.com/nicocha30/ligolo-ng> | nicocha30 |
| `busybox` (static linux) | <https://busybox.net/downloads/binaries/> | BusyBox project |
| `wget.exe` (32 + 64) | <https://eternallybored.org/misc/wget/> | Jernej Simončič (canonical Win build) |

---

## Tier B — Reputable security researchers

Well-known authors with public reputation, source available, widely audited.

| Tool | Repo / Source | Maintainer |
|---|---|---|
| `linpeas.sh`, `winPEAS*` | <https://github.com/peass-ng/PEASS-ng> | peass-ng community (post-Carlospolop fork) |
| `lse.sh` | <https://github.com/diego-treitos/linux-smart-enumeration> | Diego Treitos |
| `LinEnum.sh` | <https://github.com/rebootuser/LinEnum> | rebootuser |
| `linux-exploit-suggester.sh` | <https://github.com/The-Z-Labs/linux-exploit-suggester> | The-Z-Labs |
| `linux-exploit-suggester-2.pl` | <https://github.com/jondonas/linux-exploit-suggester-2> | jondonas |
| `deepce.sh` | <https://github.com/stealthcopter/deepce> | stealthcopter |
| `pspy32`, `pspy32s`, `pspy64`, `pspy64s` | <https://github.com/DominicBreuker/pspy> | Dominic Breuker |
| `traitor-amd64` | <https://github.com/liamg/traitor> | Liam Galvin (also tfsec, trivy) |
| `PrintSpoofer32`, `PrintSpoofer64`, `PrivescCheck.ps1` | <https://github.com/itm4n/PrintSpoofer>, <https://github.com/itm4n/PrivescCheck> | itm4n (Synacktiv) |
| `RoguePotato`, `JuicyPotatoNG` | <https://github.com/antonioCoco/RoguePotato>, <https://github.com/antonioCoco/JuicyPotatoNG> | antonioCoco |
| `GodPotato-NET2/35/4` | <https://github.com/BeichenDream/GodPotato> | BeichenDream |
| `kerbrute_linux_amd64`, `kerbrute_windows_amd64.exe` | <https://github.com/ropnop/kerbrute> | Ronnie Flathers (Praetorian) |
| `LaZagne.exe` | <https://github.com/AlessandroZ/LaZagne> | Alessandro Zanni |
| `Invoke-PowerShellTcp.ps1` (Nishang) | <https://github.com/samratashok/nishang> | Nikhil Mittal (PentesterAcademy) |
| `powercat.ps1` | <https://github.com/besimorhino/powercat> | besimorhino (canonical fork) |
| `php-reverse-shell.php` | <https://github.com/pentestmonkey/php-reverse-shell> | pentestmonkey |
| `PetitPotam.py` | <https://github.com/topotam/PetitPotam> | Lionel Gilles (topotam), original disclosure |
| `noPac.py`, `noPac scanner.py` | <https://github.com/Ridter/noPac> | Ridter |
| `HiveNightmare.exe`, `HiveNightmare.cpp` | <https://github.com/GossiTheDog/HiveNightmare> | Kevin Beaumont (GossiTheDog / DoublePulsar) |
| `CVE-2021-1675.ps1` (PrintNightmare) | <https://github.com/calebstewart/CVE-2021-1675> | Caleb Stewart |
| `CVE-2021-1675.py` (PrintNightmare) | <https://github.com/cube0x0/CVE-2021-1675> | cube0x0 |
| `pwnkit.c` (CVE-2021-4034) | <https://github.com/berdav/CVE-2021-4034> | berdav |
| `dirtypipe.c`, `dirtypipe-2.c` (CVE-2022-0847) | <https://github.com/AlexisAhmed/CVE-2022-0847-DirtyPipe-Exploits> | Alexis Ahmed (HackerSploit) |
| `dirtycow.c` (CVE-2016-5195) | <https://github.com/FireFart/dirtycow> | FireFart |
| `gameoverlay.sh` (CVE-2023-2640 / 32629) | <https://github.com/g1vi/CVE-2023-2640-CVE-2023-32629> | g1vi |
| `adPEAS.ps1` | <https://github.com/61106960/adPEAS> | 61106960 |

---

## Tier C — CI build mirrors

Auto-built compiled binaries from upstream offensive security source. Convenient because you don't need .NET tooling locally; trade-off is that you trust the maintainer's CI / build pipeline rather than recompiling from official source yourself.

| Tool | Mirror Repo | Original Author / Source | Maintainer of mirror |
|---|---|---|---|
| `Watson.exe`, `SharpView.exe`, `KrbRelayUp.exe`, `Inveigh.exe`, `ADSearch.exe`, `SharpKatz.exe`, `SharpHound.exe`, `SweetPotato.exe` | <https://github.com/Flangvik/SharpCollection> | rasta-mouse, HarmJ0y, KrbRelayUp authors, Kevin-Robertson, tomcarver16, b4rtik, BloodHoundAD, CCob | Christopher Panayi (Flangvik / CovertSwarm), public GitHub Actions CI |
| `Rubeus.exe`, `Seatbelt.exe`, `SharpUp.exe`, `Certify.exe`, `SafetyKatz.exe`, `SharpDPAPI.exe`, `SharpChrome.exe` | <https://github.com/r3motecontrol/Ghostpack-CompiledBinaries> | SpecterOps / GhostPack (HarmJ0y, Will Schroeder, et al.), <https://github.com/GhostPack> | r3motecontrol (community mirror, no public CI) |

For high-stakes engagements: clone the original GhostPack / source repos and `dotnet build` yourself.

---

## Tier D — Single-maintainer mirrors

Useful binaries from a single maintainer's repo. Source isn't always provided, no signing.

| Tool | Repo / Source | Maintainer |
|---|---|---|
| `nc.exe`, `nc64.exe` | <https://github.com/int0x33/nc.exe> | int0x33 (community netcat-for-windows mirror) |
| `socat`, `nmap`, `ncat`, `nping`, `python`, `python2.7`, `p0f` (linux statics) | <https://github.com/andrew-d/static-binaries> | andrew-d |
| `shell.aspx` | <https://github.com/borjmz/aspx-reverse-shell> | borjmz |
| `jsp-reverse.jsp` | <https://github.com/tennc/webshell> | tennc (broad webshell collection, only one specific file pulled) |

---

## Tier E — Archived but historic

These projects are no longer actively maintained but are still widely used in CTF / OSCP-era environments. Defender flags everything in this tier on sight.

| Tool | Repo / Source | Note |
|---|---|---|
| `PowerUp.ps1`, `PowerView.ps1`, `Invoke-Mimikatz.ps1` | <https://github.com/PowerShellMafia/PowerSploit> | Archived 2020. Live successor: <https://github.com/BC-SECURITY/Empire> |
| `Sherlock.ps1` | <https://github.com/rasta-mouse/Sherlock> | Archived. Use Watson.exe (already included) |
| `JAWS.ps1` | <https://github.com/411Hall/JAWS> | Quiet since 2019, still functional |
| `Invoke-MS16-032.ps1` (CVE-2016-0099) | <https://github.com/EmpireProject/Empire> | Empire archived. Module sourced from `data/module_source/privesc/` |

---

## How to verify yourself

For every URL in the table:

1. Visit the linked repo.
2. Confirm the repo is the one **you expect** (correct owner, no recent ownership transfers, matches what's referenced in published research / CVE disclosures).
3. Skim recent commits / releases for unexpected activity.
4. Compare star count + fork count against community references (BloodHound walkthroughs, OSCP guides, HackTricks).
5. For Tier C / D you may also want to:
    - Diff the compiled binary's strings / functions against a self-built copy of the original source.
    - Run it through VirusTotal. Note that AV detections are not necessarily a sign of tampering, since these are intentionally offensive tools.

A simple self-audit script:

```bash
grep -oP 'https://[^ )"]+' fetch.sh | sort -u | tee /tmp/sources.txt
# manually review each line, or:
xargs -a /tmp/sources.txt -I{} curl -sI {} | grep -E "HTTP/|Location:"
```

---

Maintained by **Chris Alupului (Neospring)**.
