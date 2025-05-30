function fix_file_table_overflow () {
  sudo sysctl -w kern.maxfiles=524288
  sudo sysctl -w kern.maxfilesperproc=524288
  ulimit -n 524288
}
