function fix-file-table-overflow() {
  sudo sysctl -w kern.maxfiles=524288
  sudo sysctl -w kern.maxfilesperproc=524288
  ulimit -n 524288
}

function nuke-gpg-agent() {
  gpgconf --kill all
  gpg-connect-agent reloadagent /bye
}
