#!/bin/bash

# define layouts array

# mimic dwm style layout symbols
typeset -A layouts=(
[tile]="[]="
[mono]="[M]"
[none]="><>"
[grid]="###"
[spiral]="(@)"
[dwindle]="[\\]"
[tstack]="F^F"
)

# or use iconic font
# mimic dwm style layout symbols
#typeset -A layouts=(
#[tile]="󰙀"
#[mono]="󰃚"
#[none]="󰕯"
#[grid]="󰕰"
#[spiral]="󰕬"
#[dwindle]="󰕴"
#[tstack]="󱒉"
#)

layout=$(dkcmd status num=1 | grep '^L' | sed 's/^L//')
layout="${layouts[$layout]}"
# echo "${$layout:-???}"  # ??? If current layout is unknown # error line 18: ${$layout:-???}: bad substitution

echo $layout

exit 0;
