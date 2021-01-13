pp_arrowFastShuttle(direction="Right") {
  While GetKeyState(direction, "P")
  {
      Send, +{%direction%}
      Sleep, 1
  }
}
