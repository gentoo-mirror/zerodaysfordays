# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit eutils autotools git-r3

DESCRIPTION="Limit-raising medium-resolution Doom source port based on Chocolate Doom."
HOMEPAGE="http://fabiangreffrath.github.io/crispy-doom"
EGIT_REPO_URI="https://github.com/fabiangreffrath/crispy-doom"

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
    # Currently, support for games such as heretc is disabled. See
    # <https://github.com/fabiangreffrath/crispy-doom/issues/132>.
    dobin src/crispy-doom
    dobin src/crispy-setup
    dobin src/crispy-server
    dobin src/crispy-doom-setup

    doman man/crispy-doom.6
    doman man/crispy-doom-setup.6

    doman man/default.cfg.5
    doman man/crispy-doom.cfg.5

    dodoc AUTHORS ChangeLog HACKING.md NEWS.md NOT-BUGS.md README* TODO.md
}

pkg_postinst() {
    einfo
    einfo "To play the original Doom levels, place doom.wad and/or doom2.wad"
    einfo "into ${GAMES_DATADIR}/doom-data, then run: ${PN}"
    einfo
    einfo "To configure game options run: crispy-setup"
    einfo
}
