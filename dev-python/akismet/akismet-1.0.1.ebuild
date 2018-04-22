# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 python3_{3,4,5,6} )
inherit distutils-r1

DESCRIPTION="Python library wrapping the Wordpress Akismet spam-detection service."
HOMEPAGE="https://github.com/ubernostrum/akismet/"
SRC_URI="https://github.com/ubernostrum/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="*"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
