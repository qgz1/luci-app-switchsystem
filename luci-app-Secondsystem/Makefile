include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-Secondsystem
PKG_VERSION:=1.0.0
PKG_RELEASE:=2  # 升级版本号，标识优化后的版本
PKG_ARCH:=all  # Lua应用为跨架构，指定为all

# 元信息补充
PKG_MAINTAINER:=zcy-Manper <you@example.com>  # 维护者信息
PKG_LICENSE:=GPL-2.0  # 许可证声明
PKG_LICENSE_FILES:=LICENSE  # 建议添加LICENSE文件

# LuCI应用特有配置
LUCI_TITLE:=LuCI App for NRadio System Switch  # 应用标题
LUCI_DESCRIPTION:=Provides system switching and reboot functions for NRadio devices (C8-668/660/650/C5800/NB68/688-CPE)  # 详细描述
LUCI_DEPENDS:=+luci-base +luci-lib-nixio +luci-lib-jsonc  # 细化依赖，确保运行环境完整
LUCI_PKGARCH:=all  # 明确LuCI包架构

# 引入LuCI打包规则
include $(INCLUDE_DIR)/package.mk
include $(TOPDIR)/feeds/luci/luci.mk

define Package/$(PKG_NAME)
  SECTION:=luci
  CATEGORY:=LuCI
  SUBMENU:=3. Applications
  TITLE:=$(LUCI_TITLE)
  DEPENDS:=$(LUCI_DEPENDS)
  ARCH:=$(PKG_ARCH)  # 关联架构声明
  DESCRIPTION:=$(LUCI_DESCRIPTION)  # 关联描述信息
endef

# 扩展描述，展示更多功能细节
define Package/$(PKG_NAME)/description
$(LUCI_DESCRIPTION)

Key features:
- Switch between official system and secondary system
- One-click system reboot
- Real-time system status display
- Hardware button operation guide
- Configuration persistence across upgrades
endef

# 声明配置文件（升级时不覆盖）
define Package/$(PKG_NAME)/conffiles
/etc/config/Secondsystem  # 若存在配置文件，添加此声明
endef

# 编译阶段（Lua应用无需编译，保持为空）
define Build/Compile
# No compilation required for Lua-based LuCI apps
endef

# 安装逻辑优化
define Package/$(PKG_NAME)/install
	# 安装控制器文件
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/controller
	$(INSTALL_DATA) ./luasrc/controller/Secondsystem.lua $(1)/usr/lib/lua/luci/controller/

	# 安装CBI模型文件
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/model/cbi
	$(INSTALL_DATA) ./luasrc/model/cbi/Secondsystem.lua $(1)/usr/lib/lua/luci/model/cbi/

	# 安装视图模板文件（包含所有相关页面）
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/view/Secondsystem
	$(INSTALL_DATA) ./luasrc/view/Secondsystem/settings.htm $(1)/usr/lib/lua/luci/view/Secondsystem/
	$(INSTALL_DATA) ./luasrc/view/Secondsystem/status.htm $(1)/usr/lib/lua/luci/view/Secondsystem/  # 补充状态页模板

	# 安装配置文件（若有初始配置）
	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_CONF) ./files/Secondsystem $(1)/etc/config/  # 可选：添加初始配置文件

	# 安装版本信息文件（配合状态页显示）
	$(INSTALL_DIR) $(1)/etc
	$(INSTALL_DATA) ./files/secondsystem_version $(1)/etc/  # 可选：添加版本信息文件
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
    
