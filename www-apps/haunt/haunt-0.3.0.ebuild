# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

GUILE_COMPAT=( 2-2 3-0 )
inherit guile autotools

DESCRIPTION="Simple, functional, hackable static site generator."
HOMEPAGE="https://dthompson.us/projects/haunt.html"
SRC_URI="https://files.dthompson.us/haunt/haunt-${PV}.tar.gz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
REQUIRED_USE="${GUILE_REQUIRED_USE}"
IUSE=""

RDEPEND="${GUILE_DEPS}"
DEPEND="${RDEPEND}"
