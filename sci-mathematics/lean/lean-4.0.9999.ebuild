# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MAJOR=$(ver_cut 1)
CMAKE_IN_SOURCE_BUILD="ON"
CMAKE_MAKEFILE_GENERATOR=emake


inherit flag-o-matic cmake readme.gentoo-r1

DESCRIPTION="The Lean Theorem Prover"
HOMEPAGE="https://leanprover-community.github.io/"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/leanprover/lean4.git"
else
	SRC_URI="https://github.com/leanprover-community/lean/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="Apache-2.0"
SLOT="0/${MAJOR}"
IUSE="debug +threads"

RDEPEND="dev-libs/gmp:="
DEPEND="${RDEPEND}"

src_configure() {
	local CMAKE_BUILD_TYPE
	if use debug; then
		CMAKE_BUILD_TYPE="Debug"
	else
		CMAKE_BUILD_TYPE="Release"
	fi

	filter-lto

	local mycmakeargs=(
		-DALPHA=ON
		-DAUTO_THREAD_FINALIZATION=ON
		-DLEAN_EXTRA_CXX_FLAGS="${CXXFLAGS}"
		-DMULTI_THREAD=$(usex threads)
		-DUSE_GITHASH=OFF
	)
	cmake_src_configure
}

src_test() {
	local myctestargs=(
		# Disable problematic "style_check" cpplint test,
		# this also removes the python test dependency
		--exclude-regex style_check
	)
	cmake_src_test
}

src_install() {
	cmake_src_install
}
