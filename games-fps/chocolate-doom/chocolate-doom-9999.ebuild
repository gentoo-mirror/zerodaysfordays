# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools git-r3

DESCRIPTION="Doom source port that accurately reproduces the experience of Doom as it was played in the 1990s"
HOMEPAGE="http://www.chocolate-doom.org/"
EGIT_REPO_URI="https://github.com/chocolate-doom/chocolate-doom.git"

LICENSE="GPL-2"
SLOT="0"

RDEPEND="media-libs/libsamplerate
         media-libs/libsdl2
         media-libs/sdl2-mixer
         media-libs/sdl2-net"
DEPEND="${RDEPEND}"

src_prepare() {
    eautoreconf
    default
}

src_install() {
    dobin src/chocolate-doom
    dobin src/chocolate-setup
    dobin src/chocolate-server
    dobin src/chocolate-doom-setup

    doman man/chocolate-doom.6
    doman man/chocolate-doom-setup.6

    doman man/default.cfg.5
    doman man/chocolate-doom.cfg.5

    dodoc AUTHORS ChangeLog HACKING.md NEWS.md NOT-BUGS.md README* TODO.md
}

pkg_postinst() {
    einfo
    einfo "To play the original Doom levels, place doom.wad and/or doom2.wad"
    einfo "into ${GAMES_DATADIR}/doom-data, then run: ${PN}"
    einfo
    einfo "To configure game options run: chocolate-setup"
    einfo
}
