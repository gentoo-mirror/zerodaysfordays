# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake-utils git-r3

DESCRIPTION="Recreation of Doom64 with additional modding features"
HOMEPAGE="http://doom64ex.wordpress.com/"
EGIT_REPO_URI="https://github.com/svkaiser/Doom64EX.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="system-fluidsynth"

RDEPEND="
    media-libs/libsdl2
    media-libs/sdl2-net
    media-libs/libpng
    sys-libs/zlib
    system-fluidsynth? ( media-sound/fluidsynth )"
DEPEND="${RDEPEND}"

# S="${WORKDIR}/MilkyTracker-${PV}"

src_configure() {
    local mycmakeargs=(
        "-DENABLE_SYSTEM_FLUIDSYNTH=$(usex system-fluidsynth)"
    )
    cmake-utils_src_configure
}

src_install() {
    cmake-utils_src_install
}
