# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 python3_{2,3,4,5,6} )
inherit distutils-r1

DESCRIPTION="REST Framework for Django"
HOMEPAGE="http://www.django-rest-framework.org/"
SRC_URI="https://github.com/encode/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-python/django-1.10[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"
