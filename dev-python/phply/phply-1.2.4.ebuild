# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 python3_{3,4,5,6} )
inherit distutils-r1

DESCRIPTION="Lexer and parser for PHP source implemented using PLY."
HOMEPAGE="https://github.com/viraptor/phply/"
SRC_URI="https://github.com/viraptor/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/ply[${PYTHON_USEDEP}]"
RDEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
	${DEPEND}
"

src_prepare() {
	rm -r "${S}/tests"
	distutils-r1_src_prepare
}

python_install_all() {
	distutils-r1_python_install_all
	find "${ED}" -name '*.pth' -delete || die "Could not delete .pth files!"
}

