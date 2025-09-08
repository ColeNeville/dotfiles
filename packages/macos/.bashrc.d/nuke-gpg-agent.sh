function nuke-gpg-agent () {
  gpgconf --kill all
  gpg-connect-agent reloadagent /bye
}
