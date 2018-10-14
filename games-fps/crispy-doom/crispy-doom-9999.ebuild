# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

EGIT_REPO_URI="https://github.com/fabiangreffrath/crispy-doom"

inherit eutils autotools git-r3

DESCRIPTION="Limit-raising medium-resolution Doom source port based on Chocolate Doom"
HOMEPAGE="http://fabiangreffrath.github.io/crispy-doom"

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
    dobin src/crispy-doom
    dobin src/crispy-setup
    dobin src/crispy-server
    dobin src/crispy-doom-setup

    doman man/crispy-doom.6
    doman man/crispy-doom-setup.6

    doman man/default.cfg.5
    doman man/crispy-doom.cfg.5

    # local opt game game_full
    # for opt in "doom Doom" \
    #                "heretic Heretic" \
    #                "strife Strife" \
    #                "hexen Hexen"

    # if use server ; then
    #     dogamesbin src/chocolate-server
    #     doman man/chocolate-server.6
    # fi

    # domenu src/${PN}-screensaver.desktop
    dodoc AUTHORS ChangeLog HACKING.md NEWS.md NOT-BUGS.md README* TODO.md
}

pkg_postinst() {
    einfo
    einfo "To configure game options run: chocolate-setup"
    einfo
}
