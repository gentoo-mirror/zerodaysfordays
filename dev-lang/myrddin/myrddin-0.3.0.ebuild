# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="A simple modern programming language"
HOMEPAGE="https://myrlang.org/"
SRC_URI="https://myrlang.org/releases/${PN}-${PV}.tar.bz2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

S="${WORKDIR}/mc/"

src_configure() {
    ./configure --prefix=/usr
    make bootstrap
}
