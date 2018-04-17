
EAPI=5

PYTHON_COMPAT=( python2_7 python3_{4,5,6} )

inherit distutils-r1
MY_PN="social-core"
MY_P="${MY_PN}-${PV}"
DESCRIPTION="Easy to setup social auth mechanism with support for several frameworks and auth providers"
HOMEPAGE="http://python-social-auth.readthedocs.org/"
SRC_URI="https://github.com/${PN}/${MY_PN}/archive/${PV}.tar.gz -> ${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="*"
IUSE="doc examples test"

RDEPEND="
	$(python_gen_cond_dep \
	    '>=dev-python/python-openid-2.2.5[${PYTHON_USEDEP}]' 'python2*')
	$(python_gen_cond_dep \
		'>=dev-python/defusedxml-0.5.0_rc1[${PYTHON_USEDEP}]' 'python3*')
	$(python_gen_cond_dep \
		'>=dev-python/python3-openid-3.0.10[${PYTHON_USEDEP}]' 'python3*')
	>=dev-python/oauthlib-0.3.8[${PYTHON_USEDEP}]
	>=dev-python/pyjwt-1.4.0[${PYTHON_USEDEP}]
	>=dev-python/requests-2.9.1[${PYTHON_USEDEP}]
	>=dev-python/requests-oauthlib-0.6.1[${PYTHON_USEDEP}]
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

S="${WORKDIR}/${MY_P}"

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
