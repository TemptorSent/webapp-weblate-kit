# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 python3_{3,4,5,6} )
inherit distutils-r1

UAP_CORE_VERSION=0.5.0
UAP_CORE="uap-core-${UAP_CORE_VERSION}"
DESCRIPTION="Python port of Broswerscope's user agent parser."
HOMEPAGE="https://github.com/ua-parser/uap-python"
SRC_URI="https://github.com/ua-parser/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz
https://github.com/ua-parser/uap-core/archive/v${UAP_CORE_VERSION}.tar.gz -> ${UAP_CORE}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/pyyaml[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"

src_unpack() {
	default
	cp -r "${WORKDIR}/${UAP_CORE}"/* "${WORKDIR}/${P}/uap-core" && rm -r "${WORKDIR}/${UAP_CORE}"
}

src_prepare() {
	# Skip .git dir check
	sed -e '55,80 { /if not os.path.exists(os.path.join(work_path/,/check_output(.*update.*/ d }' -i setup.py
	default
}

src_compile() {
	esetup.py build_regexes --inplace
	default
}
