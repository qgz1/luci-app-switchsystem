include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-Secondsystem
PKG_VERSION:=1.0
PKG_RELEASE:=1

PKG_MAINTAINER:=zcy-Manper <you@example.com>
PKG_LICENSE:=GPL-2.0

LUCI_TITLE:=LuCI app for NRadio C8-668 system switch
LUCI_DEPENDS:=+luci

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
  SECTION:=luci
  CATEGORY:=LuCI
  SUBMENU:=3. Applications
  TITLE:=$(LUCI_TITLE)
  DEPENDS:=$(LUCI_DEPENDS)
endef

define Package/$(PKG_NAME)/description
This package provides a LuCI interface to switch NRadio C8-668 between official system and secondary system,
with reboot function and real-time status display.
endef

define Build/Compile
# No compilation required
endef

define Package/$(PKG_NAME)/install
	# 控制器
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/controller
	$(INSTALL_DATA) ./luasrc/controller/Secondsystem.lua $(1)/usr/lib/lua/luci/controller/Secondsystem.lua

	# CBI model
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/model/cbi
	$(INSTALL_DATA) ./luasrc/model/cbi/Secondsystem.lua $(1)/usr/lib/lua/luci/model/cbi/Secondsystem.lua

	# 前端模板
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/view/Secondsystem
	$(INSTALL_DATA) ./luasrc/view/Secondsystem/settings.htm $(1)/usr/lib/lua/luci/view/Secondsystem/settings.htm
	$(INSTALL_DATA) ./luasrc/view/Secondsystem/status.htm $(1)/usr/lib/lua/luci/view/Secondsystem/status.htm
endef

$(eval $(call BuildPackage,$(PKG_NAME)))

