rustc ./test.rs && ./test

rustup install stable
rustup default stable

# 
# get the linker
# 
if [[ "$OSTYPE" == "darwin"* ]] 
then
    brew tap SergioBenitez/osxct;brew install FiloSottile/musl-cross/musl-cross
else
    apt-get install musl-tools # or also nix has the linux-only "musl" package
fi

# 
# get the toolchain
# 
rustup target add x86_64-unknown-linux-musl
# rustup target add arm-unknown-linux-gnueabi
# rustup target add x86_64-apple-darwin

TARGET_CC=x86_64-linux-musl-gcc RUSTFLAGS="-C linker=x86_64-linux-musl-gcc" cargo build --target=x86_64-unknown-linux-musl
# FIXME: cant find the linker inside of nix-shell but can find it outside

rustc ./test.rs --target x86_64-unknown-linux-musl --print target-spec-json && ./test
cargo build --target x86_64-unknown-linux-musl