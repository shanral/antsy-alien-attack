#!/usr/bin/env bash

attract-mode() {
  if ((TITLE_SCREEN_ATTRACT_COUNT >= TITLE_SCREEN_ATTRACT_MAX)); then
    blank-screen
    if ((TITLE_SCREEN_ATTRACT_MODE == 0)); then
      lol-draw-centered $((SCREEN_HEIGHT / 2 - 1)) "P L A Y E R 1   C O N T R O L S"
      lol-draw-centered $((SCREEN_HEIGHT / 2 + 0)) "-------------------------------"
      lol-draw-centered $((SCREEN_HEIGHT / 2 + 1)) "W"
      lol-draw-centered $((SCREEN_HEIGHT / 2 + 2)) "↑"
      lol-draw-centered $((SCREEN_HEIGHT / 2 + 3)) "A ←   → D"
      lol-draw-centered $((SCREEN_HEIGHT / 2 + 4)) "↓"
      lol-draw-centered $((SCREEN_HEIGHT / 2 + 5)) "S"
      lol-draw-centered $((SCREEN_HEIGHT / 2 + 6)) ""
      lol-draw-centered $((SCREEN_HEIGHT / 2 + 7)) "[X] Unleash the lasers"
      lol-draw-centered $((SCREEN_HEIGHT / 2 + 8)) ""
      lol-draw-centered $((SCREEN_HEIGHT / 2 + 9)) "Press [1] for one player, [2] for two player or [Q] to Quit"
    elif ((TITLE_SCREEN_ATTRACT_MODE == 1)); then
      lol-draw-centered $((SCREEN_HEIGHT / 2 - 1)) "P L A Y E R 2   C O N T R O L S"
      lol-draw-centered $((SCREEN_HEIGHT / 2 + 0)) "-------------------------------"
      lol-draw-centered $((SCREEN_HEIGHT / 2 + 1)) "I"
      lol-draw-centered $((SCREEN_HEIGHT / 2 + 2)) "↑"
      lol-draw-centered $((SCREEN_HEIGHT / 2 + 3)) "J ←   → L"
      lol-draw-centered $((SCREEN_HEIGHT / 2 + 4)) "↓"
      lol-draw-centered $((SCREEN_HEIGHT / 2 + 5)) "K"
      lol-draw-centered $((SCREEN_HEIGHT / 2 + 6)) ""
      lol-draw-centered $((SCREEN_HEIGHT / 2 + 7)) "[,] Unleash the lasers"
      lol-draw-centered $((SCREEN_HEIGHT / 2 + 8)) ""
      lol-draw-centered $((SCREEN_HEIGHT / 2 + 9)) "Press [1] for one player, [2] for two player or [Q] to Quit"
    elif ((TITLE_SCREEN_ATTRACT_MODE == 2)); then
      lol-draw-centered $((SCREEN_HEIGHT / 2 - 1)) "C O N F I G U R A T I O N"
      lol-draw-centered $((SCREEN_HEIGHT / 2 + 0)) "-------------------------"
      lol-draw-centered $((SCREEN_HEIGHT / 2 + 1)) ""
      lol-draw-centered $((SCREEN_HEIGHT / 2 + 2)) "M = Toggle Music"
      lol-draw-centered $((SCREEN_HEIGHT / 2 + 3)) ""
      lol-draw-centered $((SCREEN_HEIGHT / 2 + 4)) "S = Toggle Sound"
      lol-draw-centered $((SCREEN_HEIGHT / 2 + 5)) ""
      lol-draw-centered $((SCREEN_HEIGHT / 2 + 6)) "F = Toggle FPS"
      lol-draw-centered $((SCREEN_HEIGHT / 2 + 7)) ""
      lol-draw-centered $((SCREEN_HEIGHT / 2 + 8)) ""
      lol-draw-centered $((SCREEN_HEIGHT / 2 + 9)) "Press [1] for one player, [2] for two player or [Q] to Quit"
    elif ((TITLE_SCREEN_ATTRACT_MODE == 3)); then
      lol-draw-centered $((SCREEN_HEIGHT / 2 - 1)) "C R E D I T S"
      lol-draw-centered $((SCREEN_HEIGHT / 2 + 0)) "-------------"
      lol-draw-centered $((SCREEN_HEIGHT / 2 + 1)) "Programming: Martin Wimpress"
      lol-draw-centered $((SCREEN_HEIGHT / 2 + 2)) ""
      lol-draw-centered $((SCREEN_HEIGHT / 2 + 3)) "Graphics: Agatha Wimpress"
      lol-draw-centered $((SCREEN_HEIGHT / 2 + 4)) ""
      lol-draw-centered $((SCREEN_HEIGHT / 2 + 5)) "Music: Patrick de Arteaga"
      lol-draw-centered $((SCREEN_HEIGHT / 2 + 6)) ""
      lol-draw-centered $((SCREEN_HEIGHT / 2 + 7)) "Sound effects: Kenney Vleugels & Viktor Hahn"
      lol-draw-centered $((SCREEN_HEIGHT / 2 + 8)) ""
      lol-draw-centered $((SCREEN_HEIGHT / 2 + 9)) "Press [1] for one player, [2] for two player or [Q] to Quit"
    fi
    ((TITLE_SCREEN_ATTRACT_MODE >= TITLE_SCREEN_ATTRACT_MODE_MAX)) && TITLE_SCREEN_ATTRACT_MODE=0 || ((TITLE_SCREEN_ATTRACT_MODE++))
  fi
  ((TITLE_SCREEN_ATTRACT_COUNT >= TITLE_SCREEN_ATTRACT_MAX)) && TITLE_SCREEN_ATTRACT_COUNT=0 || ((TITLE_SCREEN_ATTRACT_COUNT++))
}

title-mode() {
  export KEY=
  export TITLE_MUSIC_THREAD=
  export TITLE_SCREEN=()
  export TITLE_SCREEN_OFFSET=
  export TITLE_SCREEN_ATTRACT_MAX=200
  export TITLE_SCREEN_ATTRACT_COUNT=200
  export TITLE_SCREEN_ATTRACT_MODE=0
  export TITLE_SCREEN_ATTRACT_MODE_MAX=3

  reset-timers
  music title
  TITLE_MUSIC_THREAD=$!

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
  elif [[ $KEY == 'm' ]]; then
    if ((MUSIC_ENABLED == 1)); then
      MUSIC_ENABLED=0
      music-setup
      kill-thread ${TITLE_MUSIC_THREAD}
      cfg-save
    elif ((MUSIC_ENABLED == 0)); then
      MUSIC_ENABLED=1
      music-setup
      music title
      TITLE_MUSIC_THREAD=$!
      cfg-save
    fi
  elif [[ $KEY == 's' ]]; then
    if ((SFX_ENABLED == 1)); then
      SFX_ENABLED=0
      sound-setup
      cfg-save
    elif ((SFX_ENABLED == 0)); then
      SFX_ENABLED=1
      sound-setup
      cfg-save
    fi
  elif [[ $KEY == 'f' ]]; then
    if ((FPS_ENABLED == 1)); then
      FPS_ENABLED=0
      fps-counter-erase
      cfg-save
    elif ((FPS_ENABLED == 0)); then
      FPS_ENABLED=1
      reset-counters
      cfg-save
    fi
  else
    attract-mode
    wave-picture "${TITLE_SCREEN_OFFSET}" "${TITLE_SCREEN[@]}"
    render
  fi
  KEY=
}
