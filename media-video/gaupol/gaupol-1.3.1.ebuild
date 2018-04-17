# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_{4,5,6} )

inherit distutils-r1 gnome2-utils virtualx xdg-utils

MY_PN="gaupol"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="A subtitle editor for text-based subtitles"
HOMEPAGE="http://otsaloma.io/gaupol/"
SRC_URI="https://github.com/otsaloma/${MY_PN}/archive/${PV}.tar.gz -> ${MY_P}.tar.gz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~x86"


RDEPEND="
	=dev-python/aeidon-${PVR}
	dev-python/pygobject:3[${PYTHON_USEDEP}]
	x11-libs/gtk+:3[introspection]
	gstreamer? ( >=media-libs/gstreamer-1.6 )
	spell? ( app-text/gtkspell:3 )
"
IUSE="spell gstreamer test"
TDEPEND="
	test? (
	dev-python/pytest[${PYTHON_USEDEP}]
		dev-python/pytest-runner[${PYTHON_USEDEP}]
	)
"

DEPEND="${RDEPEND}
	dev-util/intltool
	sys-devel/gettext
	${TDEPEND}
"

DOCS=( AUTHORS.md NEWS.md TODO.md README.md )

S="${WORKDIR}/${MY_P}"

python_compile() {
	mydistutilsargs=( --without-aeidon )
	distutils-r1_python_compile
}

python_install() {
	mydistutilsargs=( --without-aeidon )
	distutils-r1_python_install
}

python_test() {
	virtx py.test
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
	gnome2_icon_cache_update

	if [[ -z ${REPLACING_VERSIONS} ]]; then
		elog "Previewing support needs MPV, MPlayer or VLC."
	fi

	if [[ -z ${REPLACING_VERSIONS} ]]; then
		if use spell; then
			elog "Additionally, spell-checking requires a dictionary, any of"
			elog "Aspell/Pspell, Ispell, MySpell, Uspell, Hspell or AppleSpell."
		fi
	fi
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
	gnome2_icon_cache_update
}
