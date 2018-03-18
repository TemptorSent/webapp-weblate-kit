# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 python3_6 )
inherit distutils-r1

DESCRIPTION="Pure python implementation of the BiDi layout algorithm."
HOMEPAGE="https://github.com/MeirKriheli/python-bidi"
SRC_URI="https://github.com/MeirKriheli/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPLv3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
