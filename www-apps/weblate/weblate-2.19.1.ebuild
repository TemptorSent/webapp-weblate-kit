# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 python3_{4,5,6} )

MYINHERIT="distutils-r1 eutils versionator webapp"
DESCRIPTION="Web-based translation management system."
HOMEPAGE="https://weblate.org"

if [ "${PV}" = "9999" ]  ; then
	MYINHERIT+=" git-r3"
	EGIT_URI="https://github.com/WeblateOrg/weblate.git"
else
	SRC_URI="https://dl.cihar.com/weblate/Weblate-${PV}.tar.xz"
fi

inherit $MYINHERIT

LICENSE=""
#SLOT="2.19/2.19.1"
KEYWORDS="~amd64 ~x86"
IUSE="mercurial subversion avatar bidi ocr akismet"

DEPEND="
	>=dev-python/django-1.11
	>=dev-python/siphashc-0.8
	>=dev-python/translate-toolkit-2.2.0
	>=dev-python/six-1.7.0
	>=dev-python/py-filelock-3.0.1
	mercurial? ( >=dev-vcs/mercurial-2.8 )
	>=dev-python/python-social-auth-1.3.0
	>=dev-python/social-app-django-1.2.0
	>=dev-python/django-appconf-1.0
	>=dev-python/whoosh-2.7.0
	dev-python/pillow
	>=dev-python/lxml-3.1.0
	>=dev-python/pyyaml-3.0
	>=dev-python/defusedxml-0.4
	dev-python/python-dateutil
	>=dev-python/django-compressor-2.1.1
	>=dev-python/django-crispy-forms-1.6.1
	>=dev-python/django-rest-framework-3.7
	>=dev-python/python-user-agents-1.1.0
	avatar? ( dev-python/pylibravatar )
	>=dev-python/pyuca-1.1
	dev-python/Babel
	dev-python/pytz
	bidi? ( dev-python/python-bidi )
	ocr? (
		app-text/tesseract
		>=dev-python/tesserocr-2.0.0
	)
	akismet? ( >=dev-python/akismet-1.0 )
	>=dev-vcs/git-1.6[subversion?]
	dev-vcs/hub
	dev-python/git-review
"
RDEPEND="${DEPEND}"

pkg_setup() {
	webapp_pkg_setup
}
