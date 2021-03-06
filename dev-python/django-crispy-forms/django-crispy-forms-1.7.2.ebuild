# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 python3_{4,5,6} pypy )

inherit distutils-r1

DESCRIPTION="Best way to have Django DRY forms"
HOMEPAGE="
	https://pypi.python.org/pypi/django-crispy-forms/
	https://github.com/django-crispy-forms/django-crispy-forms
	https://django-crispy-forms.readthedocs.org/en/latest/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

SLOT="0"
LICENSE="MIT"
KEYWORDS="*"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
"

# Seems to be incompletely packed
RESTRICT=test

python_test() {
	DJANGO_SETTINGS_MODULE=crispy_forms.tests.test_settings py.test crispy_forms/tests || die
}
