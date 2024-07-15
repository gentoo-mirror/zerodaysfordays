EAPI=7

inherit git-r3

DESCRIPTION="Aa freeware C compiler for 6502 based systems"
HOMEPAGE="https://cc65.github.io/cc65/"
EGIT_REPO_URI="https://github.com/cc65/cc65.git"

LICENSE="zlib"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

DEPEND="doc? ( app-text/linuxdoc-tools )"
RDEPEND=""

src_compile() {
    PREFIX=/usr emake
    use doc && emake -C doc 
}

src_install() {
    PREFIX=/usr DESTDIR=${D} emake install
}
