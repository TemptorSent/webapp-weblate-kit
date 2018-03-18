# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 python3_{3,4,5,6} )
inherit distutils-r1

DESCRIPTION="A simple, Pillow-friendly, Python wrapper around tesseract-orc API using Cython."
HOMEPAGE="https://github.com/sirfz/tesserocr"
SRC_URI="https://github.com/sirfz/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	>=dev-python/cython-0.23[${PYTHON_USEDEP}]
	dev-python/pillow[${PYTHON_USEDEP}]
	>=app-text/tesseract-3.04
	>=media-libs/leptonica-1.71
"
RDEPEND="${DEPEND}"
