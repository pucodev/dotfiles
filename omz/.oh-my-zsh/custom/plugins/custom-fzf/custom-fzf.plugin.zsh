# Add docker methods for fzf
dcps() {
  docker ps | \
    sed 1d
}

DCFZF_OPTIONS=(
  --style=full
  --border --border-label=' Get docker ID '
  --input-label=' Search '
  --preview='docker logs -f --tail 10 {1}'
)

dcfzf() {
  fzf "${DCFZF_OPTIONS[@]}"
}

dcid() {
  dcps | \
    dcfzf | \
    awk '{print $1}'
}

_fzf_complete_docker() {
  _fzf_complete "${DCFZF_OPTIONS[@]}" -- "$@" < <(
    dcps
  )
}

_fzf_complete_docker_post() {
  awk '{print $1}'
}

