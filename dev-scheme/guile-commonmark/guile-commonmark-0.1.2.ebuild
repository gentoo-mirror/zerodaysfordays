# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Implementation of CommonMark for Guile "
HOMEPAGE="https://github.com/OrangeShark/guile-commonmark"
SRC_URI="https://github.com/OrangeShark/guile-commonmark/releases/download/v${PV}/${P}.tar.gz"

LICENSE="LGPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="strip"

RDEPEND=">=dev-scheme/guile-2.0.11:="
DEPEND="${RDEPEND}"

# guile generates ELF files without use of C or machine code
# It's a portage's false positive. bug #677600
QA_PREBUILT='*[.]go'

src_prepare() {
	default

	# http://debbugs.gnu.org/cgi/bugreport.cgi?bug=38112
	find "${S}" -name "*.scm" -exec touch {} + || die
}
