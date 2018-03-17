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
	_fix_setup_nogit
	default
}

src_compile() {
	esetup.py build_regexes --inplace
	default
}

_fix_setup_nogit() {
	pushd "${WORKDIR}/${P}"
	patch -p0 <<EOF
*** setup.py.orig	2018-03-16 23:14:03.578212293 -0000
--- setup.py	2018-03-16 23:16:15.442212060 -0000
***************
*** 58,69 ****
  
      def run(self):
          work_path = self.work_path
-         if not os.path.exists(os.path.join(work_path, '.git')):
-             return
- 
-         log.info('initializing git submodules')
-         check_output(['git', 'submodule', 'init'], cwd=work_path)
-         check_output(['git', 'submodule', 'update'], cwd=work_path)
  
          yaml_src = os.path.join(work_path, 'uap-core', 'regexes.yaml')
          if not os.path.exists(yaml_src):
--- 58,63 ----
EOF
	popd
}

