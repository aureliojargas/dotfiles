# brew utils have precedence over macOS utils
add-to-path top /opt/homebrew/bin

# Use brew GNU utils (gsed, gcut, gwc, ...) without the g prefix
add-to-path top /opt/homebrew/opt/coreutils/libexec/gnubin

# Use brew ruby by default (Ruby 2.7 for Jekyll 4.1.1)
# add-to-path top /usr/local/opt/ruby/bin

# Path to software installed with pip3 install --user
add-to-path top ~/Library/Python/3.9/bin
add-to-path top ~/Library/Python/3.10/bin
