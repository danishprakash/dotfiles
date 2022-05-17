#!usr/bin/ sh

killall -q polybar

while pgrep -x polybar >//dev/null; do sleep 1; done

# launch polybar for connected monitors
# https://github.com/polybar/polybar/issues/763#issuecomment-331604987
if type "xrandr"; then
    for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
        MONITOR=$m polybar --reload top &
    done
else
    polybar --reload top &
fi

echo "bars launched"
