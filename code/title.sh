#!/usr/bin/env bash


title-mode() {
  export KEY=
  export TITLE_MUSIC_THREAD=
  export TITLE_SCREEN=()
  export TITLE_SCREEN_OFFSET=

  blank-screen
  reset-timers
  music title
  TITLE_MUSIC_THREAD=$!

  lol-draw-centered $((SCREEN_HEIGHT / 2 - 1)) "C O N T R O L S"
  lol-draw-centered $((SCREEN_HEIGHT / 2 + 1)) "W"
  lol-draw-centered $((SCREEN_HEIGHT / 2 + 2)) "↑"
  lol-draw-centered $((SCREEN_HEIGHT / 2 + 3)) "A ←   → D"
  lol-draw-centered $((SCREEN_HEIGHT / 2 + 4)) "↓"
  lol-draw-centered $((SCREEN_HEIGHT / 2 + 5)) "S"
  lol-draw-centered $((SCREEN_HEIGHT / 2 + 7)) "[L] Unleash the lasers"
  lol-draw-centered $((SCREEN_HEIGHT / 2 + 9)) " Press [1] for one player, [2] for two player or [Q] to Quit"

  readarray -t TITLE_SCREEN < gfx/title.ans
  TITLE_SCREEN_LONGEST_LINE=$(wc -L gfx/title.txt | cut -d' ' -f1)
  TITLE_SCREEN_OFFSET=$(center ${TITLE_SCREEN_LONGEST_LINE})

  export LOOP=title-loop
}

title-loop() {
  if [[ $KEY == '1' ]] || [[ $KEY == '2' ]]; then
    kill-thread ${TITLE_MUSIC_THREAD}
    game-mode ${KEY}
  elif [[ $KEY == 'q' ]]; then
    kill-thread ${TITLE_MUSIC_THREAD}
    teardown
  else
    wave-picture "${TITLE_SCREEN_OFFSET}" "${TITLE_SCREEN[@]}"
    render
  fi
}
