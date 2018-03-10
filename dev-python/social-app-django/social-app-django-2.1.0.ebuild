# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

PYTHON_COMPAT=( python2_7 python3_{4,5,6} )

inherit distutils-r1
DESCRIPTION="Easy to setup social auth mechanism with support for several frameworks and auth providers"
HOMEPAGE="http://python-social-auth.readthedocs.org/"
SRC_URI="https://github.com/python-social-auth/${PN}/archive/${PV}.tar.gz -> $P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64"
IUSE="doc examples test"

RDEPEND="
	>=dev-python/python-social-auth-1.2.0[${PYTHON_USEDEP}]
	>=dev-python/six-1.10.0[${PYTHON_USEDEP}]
"
DEPEND="${DEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
	doc? ( dev-python/sphinx[${PYTHON_USEDEP}] )
"
# tests require internet
#"
#	test? (
#		dev-python/coverage[${PYTHON_USEDEP}]
#		dev-python/httpretty[${PYTHON_USEDEP}]
#		dev-python/mock[${PYTHON_USEDEP}]
#		dev-python/nose[${PYTHON_USEDEP}]
#		dev-python/sure[${PYTHON_USEDEP}]
#	)
#"

python_compile_all() {
	use doc && emake -C docs html
}

python_install_all() {
	use doc && local HTML_DOCS=( docs/_build/html/. )
	use examples && local EXAMPLES=( examples/. )
	distutils-r1_python_install_all
}

#python_test() {
#	"${S}"/social/tests/run_tests.sh || die "Tests failed on ${EPYTHON}"
#}
