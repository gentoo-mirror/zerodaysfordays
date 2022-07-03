# Copyright 1999-2022 Jakob L. Kreuze
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="Scriptable music files tags tool and editor"
HOMEPAGE="https://github.com/kaworu/tagutil"
SRC_URI="https://github.com/kaworu/tagutil/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${P}/src"

LICENSE="BSD"
SLOT="0"
IUSE="id3 flac json vorbis taglib"

RDEPEND="
    dev-libs/libyaml
    json? ( dev-libs/jansson )
    flac? ( media-libs/flac )
    vorbis? ( media-libs/libvorbis )
    taglib? ( media-libs/taglib )
    id3? ( media-sound/id3 )"
DEPEND="
	${RDEPEND}
    virtual/pkgconfig"

src_prepare() {
    cmake_src_prepare
	eapply_user
    sed -i 's/-o aslr//' CMakeLists.txt || die "Sed failed!"
}

