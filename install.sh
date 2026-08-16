#!/usr/bin/env bash
# Installs AGENTS.md as the user-profile-level agent instructions for
# Claude Code, Codex and opencode.
#
# Works on Linux, WSL, and native Windows via Git Bash.
#
#   ./install.sh              install into the current environment's home
#   ./install.sh --dry-run    show what would happen, change nothing
#   ./install.sh --no-backup  overwrite without keeping a .bak copy
#   ./install.sh --windows    (from WSL) also install into the Windows profile

set -euo pipefail

SOURCE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/AGENTS.md"

DRY_RUN=0
BACKUP=1
WITH_WINDOWS=0

for arg in "$@"; do
  case "$arg" in
    --dry-run)   DRY_RUN=1 ;;
    --no-backup) BACKUP=0 ;;
    --windows)   WITH_WINDOWS=1 ;;
    -h|--help)   sed -n '2,10p' "${BASH_SOURCE[0]}" | cut -c3-; exit 0 ;;
    *)           echo "unknown option: $arg" >&2; exit 2 ;;
  esac
done

[[ -f "$SOURCE" ]] || { echo "source not found: $SOURCE" >&2; exit 1; }

is_wsl() { [[ -n "${WSL_DISTRO_NAME:-}" ]] || grep -qi microsoft /proc/version 2>/dev/null; }

windows_home() {
  local user
  user="$(cmd.exe /c 'echo %USERNAME%' 2>/dev/null | tr -d '\r\n')" || return 1
  [[ -n "$user" && -d "/mnt/c/Users/$user" ]] && printf '/mnt/c/Users/%s' "$user"
}

install_to() {
  local dest="$1"
  if [[ $DRY_RUN -eq 1 ]]; then
    echo "  would install -> $dest"
    return
  fi
  mkdir -p "$(dirname "$dest")"
  if [[ $BACKUP -eq 1 && -s "$dest" ]] && ! cmp -s "$SOURCE" "$dest"; then
    local bak="$dest.bak-$(date +%Y%m%d%H%M%S)"
    cp "$dest" "$bak"
    echo "  backed up   -> $bak"
  fi
  cp "$SOURCE" "$dest"
  echo "  installed   -> $dest"
}

install_for_home() {
  local home="$1" label="$2"
  echo "$label ($home)"
  install_to "$home/.claude/CLAUDE.md"
  install_to "$home/.codex/AGENTS.md"
  install_to "${XDG_CONFIG_HOME:-$home/.config}/opencode/AGENTS.md"
}

echo "source: $SOURCE"
install_for_home "$HOME" "current environment"

if [[ $WITH_WINDOWS -eq 1 ]]; then
  if ! is_wsl; then
    echo "--windows only applies when running under WSL" >&2
    exit 2
  fi
  win_home="$(windows_home)" || { echo "could not resolve Windows profile" >&2; exit 1; }
  XDG_CONFIG_HOME= install_for_home "$win_home" "windows profile"
elif is_wsl; then
  echo "note: running under WSL — re-run with --windows to also install into the Windows profile"
fi
