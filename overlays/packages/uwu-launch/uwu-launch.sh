run () {
	umu-run "$@"
}

write-config-file () {
	EXE_PATH=$1
	NAME=$(basename "$EXE_PATH" .exe)
	DST_PATH="$WINEPREFIX/$NAME.toml"

	cat <<- CONF > "$DST_PATH"
	[umu]
	prefix=$WINEPREFIX
	exe=$EXE_PATH
	CONF

	echo "$DST_PATH"
}

extract-icon () {
	EXE_PATH=$1
	NAME=$(basename "$EXE_PATH" .exe)

	DST_DIR="$HOME/.local/share/icons/hicolor/256x256/apps"
	DST_PATH="$DST_DIR/$NAME.png"
	mkdir -p "$DST_DIR"

	wrestool -x -t 14 "$EXE_PATH" | \
		magick ico:- -thumbnail 256x256 -alpha on -background none -flatten "$DST_PATH"

	echo "$NAME"
}

create-desktop-file () {
	EXE_PATH=$1
	NAME=$2
	ICON_NAME=$3

	DST_DIR="$HOME/.local/share/applications"
	DST_PATH="$DST_DIR/$NAME.desktop"

	cat <<- CONF > "$DST_PATH"
	[Desktop Entry]
	Type=Application
	Version=1.5
	Exec=uwu-launch -p "$WINEPREFIX" run "$EXE_PATH"
	Name=$NAME
	Icon=$ICON_NAME
	CONF

	chmod +x "$DST_PATH"
}

export WINEPREFIX="$HOME/Games/umu"

while getopts ":p:" o; do
	case "${o}" in
		p)
			export WINEPREFIX=${OPTARG}
			;;
		*)
			;;
	esac
done
shift $((OPTIND - 1))

CMD_NAME=$1
shift

case $CMD_NAME in
	run)
		# Setup env vars for shader caching
		export MESA_SHADER_CACHE_DIR="$WINEPREFIX"
		export __GL_SHADER_DISK_CACHE_PATH="$WINEPREFIX"

		run "$@"
		;;

	create-desktop-file)
		EXE_PATH=$1
		NAME=$2

		ICON_NAME=$(extract-icon "$EXE_PATH")
		create-desktop-file "$EXE_PATH" "$NAME" "$ICON_NAME"
		;;

	*)
		echo "Unknown command $CMD_NAME"
		;;
esac
