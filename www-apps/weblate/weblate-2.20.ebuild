# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 python3_{4,5,6} )
DISTUTILS_IN_SOURCE_BUILD=1
DISTUTILS_SINGLE_IMPL=1

inherit distutils-r1 webapp

DESCRIPTION="Web-based translation management system."
HOMEPAGE="https://weblate.org"

MY_PN="Weblate"
MY_P="$MY_PN-${PV}"

if [ "${PV}" = "9999" ]  ; then
	inherit git-r3
	EGIT_URI="https://github.com/WeblateOrg/weblate.git"
else
	SRC_URI="https://dl.cihar.com/${PN}/${MY_P}.tar.xz"
fi

LICENSE=""
KEYWORDS="*"

IUSE="mercurial subversion avatar bidi ocr akismet php memcached doc"

DEPEND="
	${PYTHON_DEPS}
	$(python_gen_cond_dep '=dev-python/django-1*[${PYTHON_USEDEP}]' 'python2*')
	$(python_gen_cond_dep '>=dev-python/django-1.11[${PYTHON_USEDEP}]' 'python3*')
	>=dev-python/siphashc-0.8[${PYTHON_USEDEP}]
	>=dev-python/whoosh-2.7.0[${PYTHON_USEDEP}]
	>=dev-python/translate-toolkit-2.3.0[${PYTHON_USEDEP}]
	>=dev-python/lxml-3.1.0[${PYTHON_USEDEP}]
	dev-python/pillow[${PYTHON_USEDEP}]
	>=dev-python/six-1.7.0[${PYTHON_USEDEP}]
	dev-python/python-dateutil[${PYTHON_USEDEP}]
	>=dev-python/social-auth-core-1.3.0[${PYTHON_USEDEP}]
	>=dev-python/social-app-django-1.2.0[${PYTHON_USEDEP}]
	>=dev-python/django-crispy-forms-1.6.1[${PYTHON_USEDEP}]
	>=dev-python/oauthlib-0.6.3[${PYTHON_USEDEP}]
	>=dev-python/django-compressor-2.1.1[${PYTHON_USEDEP}]
	>=dev-python/django-rest-framework-3.8[${PYTHON_USEDEP}]
	>=dev-python/defusedxml-0.4[${PYTHON_USEDEP}]
	>=dev-python/django-appconf-1.0[${PYTHON_USEDEP}]
	>=dev-python/python-user-agents-1.1.0[${PYTHON_USEDEP}]
	>=dev-python/py-filelock-3.0.1[${PYTHON_USEDEP}]

	>=dev-python/pyuca-1.1[${PYTHON_USEDEP}]
	avatar? ( dev-python/pylibravatar[${PYTHON_USEDEP}] )
	$(python_gen_cond_dep 'dev-python/pydns:2[${PYTHON_USEDEP}]' 'python2*')
	$(python_gen_cond_dep 'dev-python/pydns:3[${PYTHON_USEDEP}]' 'python3*')
	dev-python/pytz[${PYTHON_USEDEP}]
	dev-python/Babel[${PYTHON_USEDEP}]
	php? ( dev-python/phply[${PYTHON_USEDEP}] )
	dev-python/chardet[${PYTHON_USEDEP}]
	mercurial? ( >=dev-vcs/mercurial-2.8[$(python_gen_usedep 'python2*')] )
	memcached? ( dev-python/python-memcached[${PYTHON_USEDEP}] )
	bidi? ( >=dev-python/python-bidi-0.4.0[${PYTHON_USEDEP}] )
	>=dev-python/pyyaml-3.0[${PYTHON_USEDEP}]
	ocr? (
		app-text/tesseract
		>=dev-python/tesserocr-2.0.0[${PYTHON_USEDEP}]
	)
	akismet? ( >=dev-python/akismet-1.0[${PYTHON_USEDEP}] )
	dev-python/python-levenshtein[${PYTHON_USEDEP}]

	dev-python/psycopg:2[${PYTHON_USEDEP}]

	>=dev-vcs/git-1.6[subversion?]
	dev-vcs/hub
	dev-python/git-review[${PYTHON_USEDEP}]

	doc? (
		dev-python/sphinxcontrib-httpdomain
		dev-python/pygments
	)
"
RDEPEND="${DEPEND}"

REQUIRED_USE="${PYTHON_REQUIRED_USE} mercurial? ( || ( $(python_gen_useflags 'python2*') ) )"

S="${WORKDIR}/${MY_P}"


pkg_setup() {
	webapp_pkg_setup
	python_setup
}

src_install() {
	# webapp install pre
	webapp_src_preinst

	# Copy everything to the HOSTROOTDIR/MY_PN

	local WEBLATE_ROOT="${MY_HOSTROOTDIR}/${PN}"
	dodir "${WEBLATE_ROOT}" && cp -r . "${D}/${WEBLATE_ROOT}" || die "Failed to copy source files!"

	# Copy configuration templates to HOSTROOTDIR/conf and mark them as config files.
	local WEBLATE_CONF="${MY_HOSTROOTDIR}/conf/${PN}"
	dodir "${WEBLATE_CONF}/default" && cp "${FILESDIR}/conf/"/* "${D}/${WEBLATE_CONF}/default" || die "Failed to copy conf templates!"

	# Fix up python module for uWSGI
	sed -e 's/WEBLATE_PYTHON_MODULE/'"${EPYTHON/./}"'/g' -i "${D}/${WEBLATE_CONF}/default"/* || die "Failed to fix uWSGI python module name!."

	# Create data and media directories an set ownership to server.
	dodir "${WEBLATE_ROOT}"/data
	webapp_serverowned -R "${WEBLATE_ROOT}"/data
	dodir "${WEBLATE_ROOT}"/media
	webapp_serverowned -R "${WEBLATE_ROOT}"/media

	ln -s "weblate/static" "${D}/${WEBLATE_ROOT}/static" || die "Failed to symlink static content!"

	# Set up sockets directory
	dodir "${MY_HOSTROOTDIR}"/sockets
	webapp_serverowned -R "${MY_HOSTROOTDIR}"/sockets

	# Set up log directory
	local WEBLATE_LOGDIR="${MY_HOSTROOTDIR}/logs/${PN}"
	dodir "${WEBLATE_LOGDIR}"
	webapp_serverowned -R "${WEBLATE_LOGDIR}"

	webapp_hook_script "${FILESDIR}/webapp-config.${PN}.hook"
	webapp_postinst_txt en "${FILESDIR}/weblate-postinstall-en.txt"

	# webapp install post
	webapp_src_install
}
