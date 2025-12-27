#!/usr/bin/env bash
set -u

pane_id="${1:?pane_id is required(e.g. %2)}"
widx="${2:?window_index is required}"
pidx="${3:?pane_index is required}"

if [ -z "${pane_id}" ] || [ -z "${widx}" ] || [ -z "${pidx}" ]; then
    echo "tmux-capture-on-exit.sh: empty argument(s): pane_id=`${pane_id}` widx=`${widx}` pidx=`${pidx}`" >&2
    exit 2
fi

log_root="${TMUX_LOG_DIR:-$HOME/logs/tmux}"
day="$(date +%Y%m%d)"
dir="${log_root}/${day}"
mkdir -p "${dir}"

pane_num="$(printf '%s' "${pane_id}" | tr -cd '0-9')"
out="${dir}/${day}-w${widx}-p${pidx}-id${pane_num}.log"

tmux capture-pane -p -J -S - -t "${pane_id}" >> "${out}" 2>/dev/null

# cleanup remain-on-exit sessions
tmux kill-pane -t "${pane_id}"
exit 0

