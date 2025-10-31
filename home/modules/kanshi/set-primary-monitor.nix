{ 
  writeShellApplication,

  wlr-randr,
  xrandr,
  jq,

  ...
}: writeShellApplication {
  name = "set-primary-monitor";

  runtimeInputs = [
    wlr-randr
    xrandr
    jq
  ];

  text = ''
    DESC=$1

    # There's probably a nicer query, but I don't really know jq 
    NAME=$(wlr-randr --json | jq -r --arg desc "$DESC" '
        map(select(.description | contains($desc)))
      | .[0].name
      | select(. != null)
    ')

    if [ -z "$NAME" ]; then
        echo "no name found for monitor $DESC" >&2
        exit 1
    fi

    # Set monitor as primary monitor for XWayland
    xrandr --output "$NAME" --primary
  '';
}
