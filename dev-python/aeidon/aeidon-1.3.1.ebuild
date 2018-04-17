# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_{4,5,6} )

inherit distutils-r1

MY_PN="gaupol"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="A subtitle editor for text-based subtitles"
HOMEPAGE="http://otsaloma.io/gaupol/"
SRC_URI="https://github.com/otsaloma/${MY_PN}/archive/${PV}.tar.gz -> ${MY_P}.tar.gz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="+spell"

RDEPEND="app-text/iso-codes
	dev-python/chardet[${PYTHON_USEDEP}]
	spell? ( >=dev-python/pyenchant-1.4[${PYTHON_USEDEP}] )
"

DEPEND="${RDEPEND}
	dev-util/intltool
	sys-devel/gettext
"

DOCS=( AUTHORS.md NEWS.md TODO.md README.md README.aeidon.md )

S="${WORKDIR}/${MY_P}"

python_compile() {
	mydistutilsargs=( --without-gaupol )
	distutils-r1_python_compile
}

python_install() {
	mydistutilsargs=( --without-gaupol )
	distutils-r1_python_install
}

pkg_postinst() {
	if [[ -z ${REPLACING_VERSIONS} ]]; then
		if use spell; then
			elog "Spell-checking requires a dictionary, any of the following:"
			elog "Aspell/Pspell, Ispell, MySpell, Uspell, Hspell or AppleSpell."
		fi
	fi
}

