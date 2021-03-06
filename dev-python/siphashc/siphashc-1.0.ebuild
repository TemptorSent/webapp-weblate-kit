# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 python3_{3,4,5,6} )
inherit distutils-r1

DESCRIPTION="Python module (in C) for siphash-2-4."
HOMEPAGE="https://github.com/WeblateOrg/siphashc"
SRC_URI="https://github.com/WeblateOrg/${PN}/archive/v${PV}.tar.gz"

LICENSE=""
SLOT="0/1.0"
KEYWORDS="*"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
