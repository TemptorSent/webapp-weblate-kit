# Distributed under the terms of the GNU General Public License v2

EAPI=6

MY_PN="${PN/-toolkit}"
MY_PV="${PV/_beta/b}"
PYTHON_COMPAT=( python2_7 python3_{3,4,5,6} )
PYTHON_REQ_USE="sqlite"

inherit distutils-r1

DESCRIPTION="Toolkit to convert between many translation formats"
HOMEPAGE="https://github.com/translate/translate"
#SRC_URI="https://github.com/${MY_PN}/${MY_PN}/archive/${MY_PV}.tar.gz -> ${P}.tar.gz"
SRC_URI="https://github.com/${MY_PN}/${MY_PN}/releases/download/${MY_PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="*"
IUSE="doc +html +ical +ini +php +subtitles +yaml"

COMMON_DEPEND="
	>=dev-python/six-1.10.0[${PYTHON_USEDEP}]
"
DEPEND="${COMMON_DEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
	doc? ( dev-python/sphinx[${PYTHON_USEDEP}] )
"
RDEPEND="${COMMON_DEPEND}
	!dev-python/pydiff
	app-text/iso-codes
	>=dev-python/chardet-3.0.4[${PYTHON_USEDEP}]
	>=dev-python/pycountry-18.2.23[${PYTHON_USEDEP}]
	=dev-python/diff-match-patch-20121119[${PYTHON_USEDEP}]
	>=dev-python/lxml-3.5[${PYTHON_USEDEP}]
	>=dev-python/python-levenshtein-0.12.0[${PYTHON_USEDEP}]
	sys-devel/gettext
	html? ( dev-python/utidylib[${PYTHON_USEDEP}] )
	ical? ( >=dev-python/vobject-0.9.5[${PYTHON_USEDEP}] )
	ini? ( >=dev-python/iniparse-0.4[${PYTHON_USEDEP}] )
	php? ( >=dev-python/phply-1.2.4[${PYTHON_USEDEP}] )
	subtitles? ( $(python_gen_cond_dep 'dev-python/aeidon[${PYTHON_USEDEP}]' 'python3*') )
	yaml? ( >=dev-python/pyyaml-3.12[${PYTHON_USEDEP}] )
"

REQUIRED_USE="
	subtitles? ( || ( $(python_gen_useflags 'python3*') ) )
"


python_prepare_all() {
	# Prevent unwanted d'loading in doc build
	sed -e "/^    'sphinx.ext.intersphinx',/d" \
		-e "/html_theme/ s/sphinx-bootstrap/classic/" \
		-i docs/conf.py || die
	# Opt-out of things we don't want to build.
	if ! use html ; then sed -e "/('html2po',/ d ; /('po2html',/ d" -i setup.py || die ; fi
	if ! use ical ; then sed -e "/('ical2po',/ d ; /('po2ical',/ d"  -i setup.py || die ; fi
	if ! use ini ; then sed -e "/('ini2po',/ d ; /('po2ini',/ d"  -i setup.py || die ; fi
	if ! use php ; then sed -e "/('php2po',/ d ; /('po2php',/ d ; /('phppo2pypo',/ d ; /('pypo2phppo',/ d"  -i setup.py || die ; fi
	if ! use subtitles ; then sed -e "/('sub2po',/ d ; /('po2sub',/ d"  -i setup.py || die ; fi
	if ! use yaml ; then sed -e "/('yaml2po',/ d ; /('po2yaml',/ d"  -i setup.py || die ; fi
	distutils-r1_python_prepare_all
}

python_compile_all() {
	if use doc; then
		emake -C docs html
		HTML_DOCS=( "${S}"/docs/_build/html/. )
	fi
}

python_install_all() {
	distutils-r1_python_install_all

	rm -Rf docs || die

	if ! use html; then
		find "${ED}" \( -name '*html2*' -o -name '*2html*' -o -name 'html.*' \) -delete || die
		rm "${ED%/}"/usr/bin/{html2po,po2html} || die
	fi

	if ! use ical; then
		find "${ED}" \( -name '*ical2*' -o -name '*2ical*' -o -name 'ical.*' \) -delete || die
		rm "${ED%/}"/usr/bin/{ical2po,po2ical} || die
	fi

	if ! use ini; then
		find "${ED}" \( -name 'ini2*' -o -name '*2ini*' -o -name 'ini.*' \) -delete || die
		rm "${ED%/}"/usr/bin/{ini2po,po2ini} || die
	fi

	if ! use php; then
		find "${ED}" -name '*php*' -delete || die
	fi

	if ! use subtitles; then
		find "${ED}" \( -name '*sub2*' -o -name '*2sub*' -o -name 'subtitles.*' \) -delete || die
	fi
}
