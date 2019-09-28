# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Crossplatform music editor for creating Commodore 64 music"
HOMEPAGE="http://covertbitops.c64.org/"
SRC_URI="https://downloads.sourceforge.net/goattracker2/GoatTracker_2.75.zip"

LICENSE="GPL-2"
SLOT="0"

RDEPEND="media-libs/libsdl"
DEPEND="${RDEPEND}"

S="${WORKDIR}/goattrk2/src"

src_prepare() {
    sed -i '/strip \$@/d' makefile.common
    make clean
    default
}

src_install() {
    dobin ../linux/goattrk2
    dobin ../linux/gt2reloc
    dobin ../linux/ins2snd2
    dobin ../linux/mod2sng
    dobin ../linux/sngspli2

    dodoc ../{authors,copying,goat_tracker_commands.pdf}
    dodoc ../readme*
}
