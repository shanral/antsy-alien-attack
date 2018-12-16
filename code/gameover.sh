#!/usr/bin/env bash

gameoverMusicThread=

gameover-mode() {
  export KEY=
  export DELAY=0.01
  tput clear

  reset-timers
  music gameover
  GAMEOVER_MUSIC_THREAD=$!

  local gameoverScreenOffset=$(center 73)
  draw-picture "$gameoverScreenOffset" 1 gameover

  lol-draw-centered $((SCREEN_HEIGHT / 2 - 1)) "You failed! But you may try again."
  lol-draw-centered $((SCREEN_HEIGHT / 2 + 1)) "Press [R] to seek revenge or [Q] to Quit"

  export LOOP=gameover-loop
}

gameover-loop() {
  if [[ $KEY == 'r' ]]; then
    kill-thread ${GAMEOVER_MUSIC_THREAD}
    title-mode
  elif [[ $KEY == 'q' ]]; then
    kill-thread ${GAMEOVER_MUSIC_THREAD}
    teardown
  else
    render
  fi
}
