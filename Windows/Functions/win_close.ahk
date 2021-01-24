win_close(exe) {
  Run, cmd /c taskkill /IM %exe% ,,Hide
}
