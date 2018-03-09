# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 python3_6 )
inherit distutils-r1

DESCRIPTION="Library to identify/detect devices and their capabilities by parsing HTTP headers."
HOMEPAGE="https://github.com/selwin/python-user-agents"
SRC_URI="https://github.com/selwin/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	dev-python/pyyaml
	dev-python/ua-parser"

RDEPEND="${DEPEND}"
