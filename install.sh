#!/usr/bin/env bash
# Installs agent-toolkit into the user profile for Claude Code, Codex and opencode:
# AGENTS.md as the profile-level instructions, skills/common always, and any other
# skills/<group> you opt into (running that group's setup.sh, if it has one).
#
# Works on Linux, WSL, and native Windows via Git Bash.
#
#   ./install.sh              install into the current environment's home
#   ./install.sh --dry-run    show what would happen, change nothing
#   ./install.sh --no-backup  overwrite AGENTS.md without keeping a .bak copy
#   ./install.sh --windows    (from WSL) also install into the Windows profile

set -euo pipefail
shopt -s nullglob

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOURCE="$ROOT/AGENTS.md"

DRY_RUN=0
BACKUP=1
WITH_WINDOWS=0

for arg in "$@"; do
  case "$arg" in
    --dry-run)   DRY_RUN=1 ;;
    --no-backup) BACKUP=0 ;;
    --windows)   WITH_WINDOWS=1 ;;
    -h|--help)   sed -n '2,11p' "${BASH_SOURCE[0]}" | cut -c3-; exit 0 ;;
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

skill_names() { (cd "$1" && echo */ | tr -d /); }

install_skills() {
  local dest="$1" group skill count=0
  for group in "${SELECTED[@]}"; do
    for skill in "$ROOT/skills/$group"/*/; do
      [[ $DRY_RUN -eq 1 ]] || { mkdir -p "$dest"; cp -R "${skill%/}" "$dest/"; }
      count=$((count + 1))
    done
  done
  if [[ $DRY_RUN -eq 1 ]]; then
    echo "  would install $count skills -> $dest"
  else
    echo "  installed   $count skills -> $dest"
  fi
}

install_for_home() {
  local home="$1" label="$2"
  echo "$label ($home)"
  install_to "$home/.claude/CLAUDE.md"
  install_to "$home/.codex/AGENTS.md"
  install_to "${XDG_CONFIG_HOME:-$home/.config}/opencode/AGENTS.md"
  install_skills "$home/.claude/skills"
  install_skills "$home/.agents/skills"
}

SELECTED=(common)
for dir in "$ROOT"/skills/*/; do
  group="$(basename "$dir")"
  [[ $group == common ]] && continue
  read -rp "Install $group skills ($(skill_names "$dir"))? [y/N] " answer || answer=""
  [[ $answer =~ ^[Yy] ]] && SELECTED+=("$group")
done

echo "source: $ROOT"
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

for group in "${SELECTED[@]}"; do
  setup="$ROOT/skills/$group/setup.sh"
  [[ -f "$setup" ]] || continue
  echo "$group setup"
  if [[ $DRY_RUN -eq 1 ]]; then
    echo "  would run $setup"
  else
    bash "$setup"
  fi
done
