# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 python3_{3,4,5,6} )
inherit distutils-r1

MY_PN="pyLibravatar"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Python module for Libravatar"
HOMEPAGE="https://launchpad.net/pylibravatar"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="*"
IUSE=""

DEPEND="
	$(python_gen_cond_dep 'dev-python/pydns:2[${PYTHON_USEDEP}]' 'python2*')
	$(python_gen_cond_dep 'dev-python/pydns:3[${PYTHON_USEDEP}]' 'python3*')
"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"
