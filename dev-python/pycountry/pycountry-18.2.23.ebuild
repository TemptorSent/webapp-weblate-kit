
EAPI=6

PYTHON_COMPAT=( python2_7 python3_{3,4,5,6} )
inherit distutils-r1

DESCRIPTION="Python wrapper for ISO country codes."
HOMEPAGE="https://bitbucket.org/flyingcircus/pycountry"
SRC_URI="https://bitbucket.org/flyingcircus/pycountry/get/${PV}.tar.bz2 -> ${P}.tar.bz2"

LICENSE="LGPLv2"
SLOT="0"
KEYWORDS="*"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_unpack() {
	default
	( cd ${WORKDIR} && mv flying* ${P} )
}
