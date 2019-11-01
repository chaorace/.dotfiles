#!/usr/bin/env bash
if [[ $(bspc query -N -n .floating.above.focused) -ne 0 ]]; then
    bspc node any.floating.above.focused --layer below
    bspc query -N -n .\!below | xargs -I % compton-trans -w "%" 100
    bspc node last --focus
else
    bspc node any.floating.below --layer above --focus
    bspc query -N -n .floating.above.focused | xargs -I % compton-trans -w "%" 85
    bspc query -N -n .\!above | xargs -I % compton-trans -w "%" 100
fi
