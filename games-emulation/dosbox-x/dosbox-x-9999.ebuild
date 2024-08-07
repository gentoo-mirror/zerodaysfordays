# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools flag-o-matic git-r3

DESCRIPTION="A fork of DOSBox, retaining compatibility with the wide base of DOS games and DOS gaming DOSBox was designed for."
HOMEPAGE="http://dosbox-x.com/"
EGIT_REPO_URI="https://github.com/joncampbell123/dosbox-x.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc64 ~x86"
IUSE="alsa debug hardened ffmpeg opengl"
#IUSE="alsa debug glide hardened ffmpeg opengl"

DEPEND="alsa? ( media-libs/alsa-lib )
        ffmpeg? ( media-video/ffmpeg )
        opengl? ( virtual/glu virtual/opengl )
        debug? ( sys-libs/ncurses:0 )
        media-libs/libpng
        media-libs/libsdl[joystick,video,X]
        media-libs/sdl-net
        media-libs/sdl-sound"
#       glide? ( media-libs/openglide )
RDEPEND=${DEPEND}

if [[ ${PV} = 9999 ]]; then
    S=${WORKDIR}/dosbox-x-9999
fi

src_prepare() {
    # Stolen from <https://aur.archlinux.org/packages/dosbox-x-git/>.
    sed -i 's/CODEC_FLAG2_FAST/AV_CODEC_FLAG2_FAST/g' src/hardware/hardware.cpp

    eautoreconf
    chmod +x vs2015/sdl/build-scripts/strip_fPIC.sh
    default
}

src_compile() {
    # Prefer to compile against the internal copy of SDL 1.x
    (cd vs2015/sdl && ./build-dosbox.sh) || exit 1

    chmod +x configure
    econf \
        $(use_enable alsa alsa-midi) \
        $(use_enable ffmpeg avcodec) \
        $(use_enable !hardened dynamic-core) \
        $(use_enable !hardened dynamic-x86) \
        $(use_enable debug) \
        $(use_enable opengl)
    emake
}
