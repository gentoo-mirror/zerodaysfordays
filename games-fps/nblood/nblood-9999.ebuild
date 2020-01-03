# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 toolchain-funcs

DESCRIPTION="Blood port based on EDuke32"
HOMEPAGE="https://nukeykt.retrohost.net/"
EGIT_REPO_URI="https://github.com/nukeykt/NBlood.git"

LICENSE="BUILDLIC GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~x86"
IUSE="flac fluidsynth gtk opengl png server sdk timidity vorbis vpx xmp"
REQUIRED_USE="
    vpx? ( opengl )
"

# There are no tests,
# instead it tries to build a test game, which does not compile
RESTRICT="bindist test"

RDEPEND="
    media-libs/libsdl2[joystick,opengl?,sound,video]
    media-libs/sdl2-mixer[flac?,fluidsynth?,midi,timidity?,vorbis?]
    sys-libs/zlib
    flac? ( media-libs/flac )
    gtk? ( x11-libs/gtk+:2 )
    opengl? (
        virtual/glu
        virtual/opengl
    )
    png? ( media-libs/libpng:0= )
    vpx? ( media-libs/libvpx:= )
    vorbis? (
        media-libs/libogg
        media-libs/libvorbis
    )
    xmp? ( media-libs/exempi:2= )
"

DEPEND="
    ${RDEPEND}
    timidity? ( media-sound/timidity++ )
"

BDEPEND="
    app-arch/unzip
    x86? ( dev-lang/nasm )
"

src_compile() {
    local myemakeopts=(
        ALLOCACHE_AS_MALLOC=0
        AS=$(tc-getAS)
        CC=$(tc-getCC)
        CXX=$(tc-getCXX)
        CLANG=0
        CPLUSPLUS=1
        CUSTOMOPT=""
        DEBUGANYWAY=0
        F_JUMP_TABLES=""
        FORCEDEBUG=0
        HAVE_FLAC=$(usex flac 1 0)
        HAVE_GTK2=$(usex gtk 1 0)
        HAVE_VORBIS=$(usex vorbis 1 0)
        HAVE_XMP=$(usex xmp 1 0)
        LINKED_GTK=$(usex gtk 1 0)
        LTO=1
        LUNATIC=0
        KRANDDEBUG=0
        MEMMAP=0
        MIXERTYPE=SDL
        NETCODE=$(usex server 1 0)
        NOASM=0
        OPTLEVEL=0
        OPTOPT=""
        PACKAGE_REPOSITORY=1
        POLYMER=$(usex opengl 1 0)
        PRETTY_OUTPUT=0
        PROFILER=0
        RELEASE=1
        RENDERTYPE=SDL
        SDL_TARGET=2
        SIMPLE_MENU=0
        STRIP=""
        TANDALONE=0
        STARTUP_WINDOW=$(usex gtk 1 0)
        USE_OPENGL=$(usex opengl 1 0)
        USE_LIBVPX=$(usex vpx 1 0)
        USE_LIBPNG=$(usex png 1 0)
        USE_LUAJIT_2_1=0
        WITHOUT_GTK=$(usex gtk 0 1)
    )

    emake "${myemakeopts[@]}" blood
}

src_install() {
    dobin nblood
}
