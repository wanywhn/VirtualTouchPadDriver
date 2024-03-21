# Maintainer: Jia Qingtong <jiaqingtong97@gmail.com>

_pkgbase=virtual-touchpad-driver
pkgname=virtual-touchpad-driver-dkms
pkgver=1.0
pkgrel=0
pkgdesc="The Virtual Touchpad Driver (DKMS)"
arch=('x86_64' 'aarch64' 'loongarch64')
url="https://github.com/wanywhn/VirtualTouchPadDriver"
license=('GPL2')
depends=('dkms')
conflicts=("${_pkgbase}")
source=("${_pkgbase}::git+${url}"
        )

md5sums=(
		'SKIP'
)

prepare() {
  cd ${_pkgbase}
}

package() {

  mkdir "${pkgdir}"/usr/src/${_pkgbase}-${pkgver} -p

  # Copy sources (including Makefile)
  cp -r ${_pkgbase}/* "${pkgdir}"/usr/src/${_pkgbase}-${pkgver}/

  # Copy dkms.conf
  install -Dm644 ${_pkgbase}/dkms_arch.conf "${pkgdir}"/usr/src/${_pkgbase}-${pkgver}/dkms.conf

  # Set name and version
  sed -e "s/@_PKGBASE@/${_pkgbase}/" \
      -e "s/@PKGVER@/${pkgver}/" \
      -i "${pkgdir}"/usr/src/${_pkgbase}-${pkgver}/dkms.conf

  # Blacklists conflicting module
  #install -Dm644 ${pkgname}.conf "${srcdir}/usr/lib/modprobe.d/${pkgname}.conf"
}
