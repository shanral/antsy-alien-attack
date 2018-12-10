# Bash 'em Up!

A game, written in Bash, that is a somewhat retro-a-like shoot 'em up. Hopefully.

## Requirements

  - `coreutils` for `stty`
  - [`joy2key`](https://sourceforge.net/projects/joy2key/)
  - `lolcat`
  - `mpg123`
  - `ncurses-bin` for `tput`
  - `ogg123`
  - `procpc` for `kill`, `pkill`
  - `xterm` fr `resize`

The following will get you want you need on Ubuntu.

    sudo apt install lolcat mpg123 procps vorbis-tools 

### Compile joy2key

```
sudo apt install libx11-dev x11-utils
wget -c http://sourceforge.net/projects/joy2key/files/joy2key/1.6.3/joy2key-1.6.3.tar.bz2
wget -c http://sourceforge.net/p/joy2key/patches/_discuss/thread/e73f20a1/33d7/attachment/button_list_segfault.patch
tar xvf joy2key-1.6.3.tar.bz2
patch -p0 -i ../button_list_segfault.patch
cd joy2key-1.6.3
./configure --prefix=/usr/local
make
sudo make install
```

### Xbox 360

#### AXIS

  * 0 = left analog stick X-axis
  * 1 = left analog stick Y-axis
  * 2 = left trigger
  * 3 = right analog stick X-axis
  * 4 = right analog stick Y-axis
  * 5 = right trigger
  * 6 = hat (d-pad) X-axis
  * 7 = hat (d-pad) Y-axis

#### Buttons

  * 0 = A
  * 1 = B
  * 2 = X
  * 3 = Y
  * 5 = left shoulder
  * 6 = right shoulder

## Title Screen

The title graphics are made with `toilet` and `lolcat`.

Create a preview of all the font styles.

```
for FONT in /usr/share/figlet/*.tlf; do echo $(basename $FONT) && toilet -t -f $(basename $FONT) --filter border "Bash'em Up!" | lolcat -f -F 0.2; done
```

I settled on `ascii9` for the main title graphic.

```
toilet -t -f ascii9 --filter border "Bash'em Up!" | lolcat -f -F 0.2 > gfx/title.ans
toilet -t -f ascii9 --filter border "Game Over!" | lolcat -f -F 0.2 > gfx/gameover.ans
toilet -t -f ascii9 --filter border "Victory!" | lolcat -f -F 0.2 > gfx/victory.ans
```

## References

### Applications

  * https://www.gnu.org/software/termutils/manual/termutils-2.0/html_chapter/tput_1.html
  * https://ubuntuforums.org/showthread.php?t=646564

### Game Assets

  * https://opengameart.org
  * https://patrickdearteaga.com
    * Chiptronical           - `title.ogg`
    * Intergalactic Odyssey  - `level1.ogg`
    * Interstellar Odyssey   - `level2.ogg`
    * Interplanetary Odyssey - `level3.ogg`
    * Ruined Planet          - `gameover.ogg`
    * Friends                - `victory.ogg`

### Fonts

Consolas TTF Looks like a Unicode complete option.

#### Terminal fonts

  * https://int10h.org/oldschool-pc-fonts/
  * http://www.fixedsysexcelsior.com/
  * https://github.com/ansilove/BlockZone

### ANSI & ASCII

  * https://shiroyasha.svbtle.com/escape-sequences-a-quick-guide-1

#### Editors

  * http://bruxy.regnet.cz/web/linux/EN/ansi-art-sh-paint/
  * http://www.syaross.org/thedraw/
  * http://picoe.ca/products/pablodraw/
  * http://tetradraw.sourceforge.net/
  * https://sourceforge.net/projects/tundradraw/
  * https://sourceforge.net/projects/mysticdraw/
  * http://syncdraw.bbsdev.net/
  * https://www.gridsagegames.com/rexpaint/index.html

#### Fonts

  * http://patorjk.com/blog/2014/01/22/thedraws-lost-ansi-art-fonts/
    * http://patorjk.com/software/taag
  * https://www.roysac.com/thedrawfonts-tdf.html

#### Artwork

  * https://theasciicode.com.ar/
  * https://textart.io/
  * https://asciiart.website/
  * http://ascii.co.uk/
  * http://www.ascii-art.de/
  * http://asciiartist.com/
  * http://www.asciiworld.com/
  * https://www.asciiart.eu
  * https://text-symbols.com
  * https://www.ansilove.org/
  * https://asciiart.club/
  * https://16colo.rs