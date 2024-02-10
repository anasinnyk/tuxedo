#!/bin/sh
#
# Lock the screen using swaylock.
#

swaylock \
  --screenshots \
  --clock \
  --indicator \
  --indicator-radius 100 \
  --indicator-thickness 7 \
  --effect-blur 7x5 \
  --effect-vignette 0.5:0.5 \
  --ring-color b8bb26 \
  --line-color 00000000 \
  --separator-color 00000000 \
  --inside-color 00000088 \
  --grace 2 \
  --fade-in 0.2
