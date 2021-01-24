pp_arrowFastShuttle(direction="Right") {
  Send, {Shift Down}
  While GetKeyState(direction, "P")
  {
      Send, {%direction%}
      Sleep, 1
  }
  Send, {Shift Up}
}
