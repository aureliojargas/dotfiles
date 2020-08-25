# Use brew GNU utils by default, without the g prefix: gsed, gwc, ...
add-to-path top /usr/local/opt/coreutils/libexec/gnubin

# Path to software installed with pip3 install --user
add-to-path top ~/Library/Python/3.8/bin

# txt2regex: use brew gettext binaries
add-to-path bottom /usr/local/Cellar/gettext/0.19.8.1/bin/
