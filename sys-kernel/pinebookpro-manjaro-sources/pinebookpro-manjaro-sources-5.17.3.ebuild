# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"
ETYPE="sources"
K_WANT_GENPATCHES="base extras experimental"
K_GENPATCHES_VER="5"
MANJARO_COMMIT="efa85f06d63f56f2ce03916bac6ef15d0b8345db"

# When bumping the kernel version, be sure to update K_GENPATCHES_VER as well.
# <https://dev.gentoo.org/~mpagano/genpatches/kernels.html>

inherit kernel-2
detect_version
detect_arch

KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sparc ~x86"
HOMEPAGE="https://dev.gentoo.org/~mpagano/genpatches"
IUSE="experimental"

DESCRIPTION="Full sources including the Gentoo patchset for the ${KV_MAJOR}.${KV_MINOR} kernel tree"
SRC_URI="${KERNEL_URI} ${GENPATCHES_URI} ${ARCH_URI}"
SRC_URI+="
	https://gitlab.manjaro.org/manjaro-arm/packages/core/linux/-/raw/${MANJARO_COMMIT}/config
		-> kernel-aarch64-manjaro.config-${PV}
	https://gitlab.manjaro.org/manjaro-arm/packages/core/linux/-/archive/${MANJARO_COMMIT}/linux-${MANJARO_COMMIT}.tar.gz
		-> manjaro-patches-${PV}.tar.gz
"

src_unpack() {
	unpack "manjaro-patches-${PV}.tar.gz"
	kernel-2_src_unpack
}

src_prepare() {
	local MANJARO_PATCHES="
        '1001-arm64-dts-allwinner-add-hdmi-sound-to-pine-devices.patch'
        '1002-arm64-dts-allwinner-add-ohci-ehci-to-h5-nanopi.patch'
        '1003-drm-bridge-analogix_dp-Add-enable_psr-param.patch'
        '1004-gpu-drm-add-new-display-resolution-2560x1440.patch'
        '1005-panfrost-Silence-Panfrost-gem-shrinker-loggin.patch'
        '1006-arm64-dts-rockchip-Add-Firefly-Station-p1-support.patch'
        '1007-drm-rockchip-add-support-for-modeline-32MHz-e.patch'
        '1008-rk3399-rp64-pcie-Reimplement-rockchip-PCIe-bus-scan-delay.patch'
        '1009-drm-meson-encoder-add-YUV422-output-support.patch'
        '1010-arm64-dts-amlogic-add-initial-Beelink-GT1-Ultimate-dev.patch'
        '1011-arm64-dts-amlogic-add-meson-g12b-ugoos-am6-plus.patch'
        '1012-drm-panfrost-scheduler-improvements.patch'
        '1013-arm64-dts-rockchip-Add-PCIe-bus-scan-delay-to-RockPr.patch'
        '1014-drm-rockchip-support-gamma-control-on-RK3399.patch'
        '1015-media-rockchip-rga-do-proper-error-checking-in-probe.patch'
        '1016-arm64-dts-rockchip-switch-to-hs200-on-rockpi4.patch'
        '1017-arm64-dts-meson-remove-CPU-opps-below-1GHz-for-G12B-boards.patch'
        '1018-arm64-dts-meson-remove-CPU-opps-below-1GHz-for-SM1-boards.patch'
        '1019-arm64-dts-rockchip-Add-PCIe-bus-scan-delay-to-Rock-P.patch'
        '2001-Bluetooth-Add-new-quirk-for-broken-local-ext-features.patch'
        '2002-Bluetooth-btrtl-add-support-for-the-RTL8723CS.patch'
        '2003-arm64-allwinner-a64-enable-Bluetooth-On-Pinebook.patch'
        '2004-arm64-dts-allwinner-enable-bluetooth-pinetab-pinepho.patch'
        '2005-staging-add-rtl8723cs-driver.patch'
        '2006-arm64-dts-allwinner-pinetab-add-accelerometer.patch'
        '2007-arm64-dts-allwinner-pinetab-enable-jack-detection.patch'
        '2008-brcmfmac-USB-probing-provides-no-board-type.patch'
        '2009-dts-rockchip-Adapt-and-adopt-Type-C-support-from-Pin.patch'
        '3170-arm64-dts-rk3399-pinebook-pro-Fix-USB-PD-charging.patch'
        '3172-arm64-dts-rk3399-pinebook-pro-Improve-Type-C-support.patch'
        '3174-arm64-dts-rk3399-pinebook-pro-Remove-redundant-pinct.patch'
        '3178-arm64-dts-rk3399-pinebook-pro-Don-t-allow-usb2-phy-d.patch'
        '3339-drm-rockchip-cdn-dp-Disable-CDN-DP-on-disconnect.patch'
        '3355-usb-typec-fusb302-Set-the-current-before-enabling-pu.patch'
        '3359-usb-typec-fusb302-Update-VBUS-state-even-if-VBUS-int.patch'
        '3361-usb-typec-fusb302-Add-OF-extcon-support.patch'
        '3362-usb-typec-fusb302-Fix-register-definitions.patch'
        '3363-usb-typec-fusb302-Clear-interrupts-before-we-start-t.patch'
        '3364-usb-typec-typec-extcon-Add-typec-extcon-bridge-drive.patch'
        '3365-phy-rockchip-typec-Make-sure-the-plug-orientation-is.patch'
        '3372-phy-rockchip-inno-usb2-More-robust-charger-detection.patch'
        '3373-usb-typec-extcon-Don-t-touch-charger-proprties.patch'
	"
	for patch in ${MANJARO_PATCHES}; do
		eapply "${WORKDIR}/linux-${MANJARO_COMMIT}/$(echo ${patch} | tr -d "\'")"
	done

	cp "${DISTDIR}/kernel-aarch64-manjaro.config-${PV}" "${S}/.config" || die
	cp "${DISTDIR}/kernel-aarch64-manjaro.config-${PV}" "${S}/manjaro_config" || die

	kernel-2_src_prepare
}

pkg_postinst() {
	kernel-2_pkg_postinst
	einfo "For more info on this patchset, and how to report problems, see:"
	einfo "${HOMEPAGE}"
}

pkg_postrm() {
	kernel-2_pkg_postrm
}
