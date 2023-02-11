# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
aho-corasick-0.7.18
android_system_properties-0.1.5
anyhow-1.0.68
async-io-1.7.0
atty-0.2.14
autocfg-1.1.0
base64-0.13.0
bitflags-1.2.1
bitvec-1.0.0
bumpalo-3.10.0
byteorder-1.4.3
bytes-1.3.0
cache-padded-1.2.0
cc-1.0.73
cfg-if-1.0.0
chrono-0.4.22
clap-3.2.23
clap_complete-3.2.5
clap_derive-3.2.18
clap_lex-0.2.3
concurrent-queue-1.2.2
core-foundation-sys-0.8.3
darling-0.14.1
darling_core-0.14.1
darling_macro-0.14.1
derivative-2.2.0
derive-where-1.0.0
enumflags2-0.6.4
enumflags2_derive-0.6.4
env_logger-0.9.1
evdev-0.12.0
fastrand-1.7.0
fnv-1.0.7
fork-0.1.20
funty-2.0.0
futures-0.3.21
futures-channel-0.3.21
futures-core-0.3.21
futures-executor-0.3.21
futures-io-0.3.21
futures-lite-1.12.0
futures-macro-0.3.21
futures-sink-0.3.21
futures-task-0.3.21
futures-util-0.3.21
gethostname-0.2.3
hashbrown-0.12.1
heck-0.4.0
hermit-abi-0.1.19
hermit-abi-0.2.6
hex-0.4.3
humantime-2.1.0
hyprland-0.2.4
iana-time-zone-0.1.48
ident_case-1.0.1
indexmap-1.9.1
indoc-1.0.8
instant-0.1.12
itoa-1.0.2
js-sys-0.3.59
lazy_static-1.4.0
libc-0.2.139
lock_api-0.4.9
log-0.4.17
memchr-2.5.0
memoffset-0.6.5
memoffset-0.7.1
mio-0.8.5
nb-connect-1.2.0
nix-0.20.2
nix-0.23.1
nix-0.25.1
nix-0.26.1
num-integer-0.1.45
num-traits-0.2.15
num_cpus-1.15.0
num_threads-0.1.6
once_cell-1.14.0
os_str_bytes-6.1.0
parking-2.0.0
parking_lot-0.12.1
parking_lot_core-0.9.5
pin-project-lite-0.2.9
pin-utils-0.1.0
polling-2.2.0
proc-macro-crate-0.1.5
proc-macro-crate-1.1.3
proc-macro-error-1.0.4
proc-macro-error-attr-1.0.4
proc-macro2-1.0.49
quote-1.0.20
radium-0.7.0
redox_syscall-0.2.16
regex-1.6.0
regex-syntax-0.6.27
ryu-1.0.10
scoped-tls-1.0.0
scopeguard-1.1.0
serde-1.0.152
serde_derive-1.0.152
serde_json-1.0.85
serde_repr-0.1.8
serde_with-2.0.1
serde_with_macros-2.0.1
serde_yaml-0.9.14
signal-hook-registry-1.4.0
slab-0.4.6
smallvec-1.10.0
socket2-0.4.4
static_assertions-1.1.0
strsim-0.10.0
swayipc-3.0.1
swayipc-types-1.1.0
syn-1.0.107
tap-1.0.1
termcolor-1.1.3
textwrap-0.16.0
thiserror-1.0.31
thiserror-impl-1.0.31
time-0.3.12
tokio-1.24.1
tokio-macros-1.8.2
toml-0.5.9
unicode-ident-1.0.1
unsafe-libyaml-0.2.4
version_check-0.9.4
waker-fn-1.1.0
wasi-0.11.0+wasi-snapshot-preview1
wasm-bindgen-0.2.82
wasm-bindgen-backend-0.2.82
wasm-bindgen-macro-0.2.82
wasm-bindgen-macro-support-0.2.82
wasm-bindgen-shared-0.2.82
wepoll-ffi-0.1.2
winapi-0.3.9
winapi-i686-pc-windows-gnu-0.4.0
winapi-util-0.1.5
winapi-wsapoll-0.1.1
winapi-x86_64-pc-windows-gnu-0.4.0
windows-sys-0.42.0
windows_aarch64_gnullvm-0.42.0
windows_aarch64_msvc-0.42.0
windows_i686_gnu-0.42.0
windows_i686_msvc-0.42.0
windows_x86_64_gnu-0.42.0
windows_x86_64_gnullvm-0.42.0
windows_x86_64_msvc-0.42.0
wyz-0.5.0
x11rb-0.11.0
x11rb-protocol-0.11.0
xremap-0.8.0
zbus-1.9.2
zbus_macros-1.9.2
zvariant-2.10.0
zvariant_derive-2.10.0"

inherit cargo rust-toolchain

DESCRIPTION="Key remapper for X11 and Wayland "
HOMEPAGE="https://github.com/k0kubun/xremap"
SRC_URI="https://github.com/k0kubun/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
$(cargo_crate_uris)"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~aarch64 ~amd64"
IUSE="gnome hypr sway X"

src_configure() {
        local myfeatures=(
            $(usex X x11 '')
            $(usev gnome)
            $(usev sway)
            $(usev hypr)
        )
        cargo_src_configure --no-default-features
}
