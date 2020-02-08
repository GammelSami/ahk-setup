pp_deleteNextMarker() {
  ; m and +m are the default Premiere shortcuts for edit/create marker and jump to next marker
  Send, +m
  Sleep, 10
  Send, m
  Sleep, 10
  Send, +{Tab}
  Sleep, 10
  Send, +{Tab}
  Sleep, 10
  Send, {Enter}
}
