# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3 eutils

DESCRIPTION="Blender addon. Sverchok is a powerful parametric tool for architects"
HOMEPAGE="http://nikitron.cc.ua/sverchok_en.html"
EGIT_REPO_URI="https://github.com/nortikin/sverchok.git"
EGIT_BRANCH="master"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="freecad"

DEPEND=""
RDEPEND="media-gfx/blender[addons]
        dev-python/numpy
        dev-python/cython
        sci-libs/scipy
        dev-python/geomdl
        dev-python/PyMCubes
        freecad? ( media-gfx/freecad )
        "

src_install() {
	egit_clean
    insinto ${BLENDER_ADDONS_DIR}/addons/${PN}
	doins -r "${S}"/*
    if use freecad ; then
        insinto /usr/lib/python3.7/site-packages/
        echo "/usr/lib64/freecad/lib64/" > ${D}/usr/lib/python3.7/site-packages/freecad_path.pth || die
    fi
}

pkg_postinst() {
	elog
	elog "This blender addon installs to system subdirectory"
	elog "${BLENDER_ADDONS_DIR}"
	elog "You can set it to make.conf before"
	elog "Please, set it to PreferencesFilePaths.scripts_directory"
	elog "More info you can find at page "
	elog "https://docs.blender.org/manual/en/latest/preferences/file.html#scripts-path"
	elog
}
