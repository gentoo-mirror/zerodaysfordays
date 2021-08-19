# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Department of Defense Common Access Card PKCS#11 Provider"
HOMEPAGE="http://cackey.rkeene.org/fossil/home"
SRC_URI="http://cackey.rkeene.org/download/${PV}/${P}.tar.gz"

LICENSE="BSD GPL-2 MIT RSA"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="sys-apps/pcsc-lite sys-libs/zlib"
RDEPEND="${DEPEND}"
BDEPEND=""
