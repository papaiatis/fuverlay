EAPI=6
inherit eutils
PVERSION="10.0.4"
#EAP="-EAP"

HOMEPAGE="http://www.jetbrains.com/phpstorm/"
DESCRIPTION="PhpStorm"
SRC_URI="http://download.jetbrains.com/webide/PhpStorm${EAP}-${PVERSION:-${PV}}.tar.gz -> ${P}.tar.gz"

if [[ x${PVERSION} != 'x' ]]; then
	KEYWORDS="x86 amd64"
else
	KEYWORDS="~x86 ~amd64"
fi

PROGNAME="PHP Storm"

RESTRICT="strip mirror"

QA_PREBUILT="
    opt/${PN}/bin/fsnotifier-arm
"

DEPEND="|| ( >=virtual/jre-1.8 >=virtual/jdk-1.8 )"
SLOT="0"
S=${WORKDIR}

src_install() {
	dodir /opt/${PN}

	cd PhpStorm*/
	sed -i 's/IS_EAP="true"/IS_EAP="false"/' bin/phpstorm.sh
	insinto /opt/${PN}
	doins -r *

	fperms a+x /opt/${PN}/bin/phpstorm.sh || die "Chmod failed"
	fperms a+x /opt/${PN}/bin/fsnotifier || die "Chmod failed"
	fperms a+x /opt/${PN}/bin/fsnotifier64 || die "Chmod failed"
	dosym /opt/${PN}/bin/phpstorm.sh /usr/bin/${PN}

	mv "bin/webide.png" "bin/${PN}.png"
	doicon "bin/${PN}.png"
	make_desktop_entry ${PN} "${PROGNAME}" "${PN}"
}

pkg_postinst() {
    elog "Run /usr/bin/${PN}"
}


