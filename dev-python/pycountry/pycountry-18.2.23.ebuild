# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 python3_{3,4,5,6} )
inherit distutils-r1

DESCRIPTION="Python wrapper for ISO country codes."
HOMEPAGE="https://bitbucket.org/flyingcircus/pycountry"
SRC_URI="https://bitbucket.org/flyingcircus/pycountry/get/${PV}.tar.bz2 -> ${P}.tar.bz2"

LICENSE="LGPLv2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_unpack() {
	default
	( cd ${WORKDIR} && mv flying* ${P} )
}
