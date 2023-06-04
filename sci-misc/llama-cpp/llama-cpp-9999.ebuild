# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic git-r3

DESCRIPTION="Port of Facebook's LLaMA model in C/C++"
HOMEPAGE="https://github.com/ggerganov/llama.cpp"
EGIT_REPO_URI="https://github.com/ggerganov/llama.cpp.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="blas"

DEPEND="blas? ( sci-libs/openblas )"
RDEPEND=${DEPEND}

if [[ ${PV} = 9999 ]]; then
    S=${WORKDIR}/llama-cpp-9999
fi

src_compile() {
    if use blas; then
        LLAMA_OPENBLAS="1" emake
    else
        emake
    fi
}

src_install() {
    mv main llama-cpp
	dobin llama-cpp
	dodoc README.md
}
