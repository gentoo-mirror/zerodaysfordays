# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Simple, functional, hackable static site generator."
HOMEPAGE="https://dthompson.us/projects/haunt.html"
SRC_URI="https://files.dthompson.us/haunt/haunt-0.2.4.tar.gz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-scheme/guile-2.0:="
DEPEND="${RDEPEND}"
