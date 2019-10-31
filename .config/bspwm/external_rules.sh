#! /bin/sh

wid=$1
class=$2
instance=$3
echo "$wid $class $instance" > /tmp/bspc-external-rules

if [ "$class" = Emacs ] ; then
	title=$(xtitle "$wid")
	case "$title" in
		floatmacs)
			echo "state=floating"
			echo "flag=sticky"
			echo "layer=above"
			echo "rectangle = 1366x768+0+0"
			;;
		*)
			echo "state = tiled"
	esac
fi
