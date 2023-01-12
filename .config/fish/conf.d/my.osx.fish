# brew utils have precedence over macOS utils
fish_add_path /opt/homebrew/bin

# Use brew GNU utils (gsed, gcut, gwc, ...) without the g prefix
fish_add_path /opt/homebrew/opt/coreutils/libexec/gnubin

# Use brew ruby by default (Ruby 2.7 for Jekyll 4.1.1)
# fish_add_path /usr/local/opt/ruby/bin

# Path to software installed with pip3 install --user
fish_add_path ~/Library/Python/3.9/bin
fish_add_path ~/Library/Python/3.10/bin
