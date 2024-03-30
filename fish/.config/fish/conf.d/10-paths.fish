# Ruby binaries
fish_add_path $GEM_HOME/bin

# Rust binaries
set -gx CARGO_PATH $HOME/.cargo/bin
fish_add_path $CARGO_PATH

# Nim binaries
set -gx NIMBLE_PATH $HOME/.nimble/bin
fish_add_path $NIMBLE_PATH

# Local scripts
fish_add_path $HOME/.local/bin
