# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 python3_{4,5,6} )
DISTUTILS_SINGLE_IMPL=1
MYINHERIT="distutils-r1 eutils versionator webapp"
DESCRIPTION="Web-based translation management system."
HOMEPAGE="https://weblate.org"

MY_PN="Weblate"
MY_P="$MY_PN-${PV}"

if [ "${PV}" = "9999" ]  ; then
	MYINHERIT+=" git-r3"
	EGIT_URI="https://github.com/WeblateOrg/weblate.git"
else
	SRC_URI="https://dl.cihar.com/${PN}/${MY_P}.tar.xz"
fi

inherit $MYINHERIT

LICENSE=""
#SLOT="2.19/2.19.1"
KEYWORDS="~amd64 ~x86"

IUSE="mercurial subversion avatar bidi ocr akismet"

DEPEND="
	${PYTHON_DEPS}
	>=dev-python/django-1.11[${PYTHON_USEDEP}]
	>=dev-python/siphashc-0.8[${PYTHON_USEDEP}]
	>=dev-python/translate-toolkit-2.2.0[${PYTHON_USEDEP}]
	>=dev-python/six-1.7.0[${PYTHON_USEDEP}]
	>=dev-python/py-filelock-3.0.1[${PYTHON_USEDEP}]
	mercurial? ( >=dev-vcs/mercurial-2.8 )
	>=dev-python/python-social-auth-1.3.0[${PYTHON_USEDEP}]
	>=dev-python/social-app-django-1.2.0[${PYTHON_USEDEP}]
	>=dev-python/django-appconf-1.0[${PYTHON_USEDEP}]
	>=dev-python/whoosh-2.7.0[${PYTHON_USEDEP}]
	dev-python/pillow[${PYTHON_USEDEP}]
	>=dev-python/lxml-3.1.0[${PYTHON_USEDEP}]
	>=dev-python/pyyaml-3.0[${PYTHON_USEDEP}]
	>=dev-python/defusedxml-0.4[${PYTHON_USEDEP}]
	dev-python/python-dateutil[${PYTHON_USEDEP}]
	>=dev-python/django-compressor-2.1.1[${PYTHON_USEDEP}]
	>=dev-python/django-crispy-forms-1.6.1[${PYTHON_USEDEP}]
	>=dev-python/django-rest-framework-3.7[${PYTHON_USEDEP}]
	>=dev-python/python-user-agents-1.1.0[${PYTHON_USEDEP}]
	avatar? ( dev-python/pylibravatar[${PYTHON_USEDEP}] )
	>=dev-python/pyuca-1.1[${PYTHON_USEDEP}]
	dev-python/Babel[${PYTHON_USEDEP}]
	dev-python/pytz[${PYTHON_USEDEP}]
	bidi? ( dev-python/python-bidi[${PYTHON_USEDEP}] )
	ocr? (
		app-text/tesseract
		>=dev-python/tesserocr-2.0.0[${PYTHON_USEDEP}]
	)
	akismet? ( >=dev-python/akismet-1.0[${PYTHON_USEDEP}] )
	>=dev-vcs/git-1.6[subversion?]
	dev-vcs/hub
	dev-python/git-review[${PYTHON_USEDEP}]
"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"


pkg_setup() {
	webapp_pkg_setup
	python_setup
}


src_install() {
	webapp_src_preinst
	distutils-r1_python_install_all --install-lib="${MY_HOSTROOTDIR}" --install-data="${MY_HOSTROOTDIR}" --install-scripts "bin/${MY_HOSTROOTDIR}"
	distutils-r1_python_install --install-lib="${MY_HOSTROOTDIR}" --install-data="${MY_HOSTROOTDIR}" --install-scripts "bin/${MY_HOSTROOTDIR}"
#	pushd "${D}/${MY_HOSTROOTDIR}/lib/weblate"
#	mv static/* "${D}/${MY_HTDOCSDIR}"
#	rmdir static && ln -s "../../../htdocs" "static"
#	insinto "${MY_HTDOCSDIR}"
#	doins -r .
#	webapp_serverowned -R "${MY_HTDOCSDIR}"/apps
#	webapp_serverowned -R "${MY_HTDOCSDIR}"/data
#	webapp_serverowned -R "${MY_HTDOCSDIR}"/config
#	webapp_configfile "${MY_HTDOCSDIR}"/.htaccess
	webapp_src_install

}
