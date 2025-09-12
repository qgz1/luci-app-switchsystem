m = Map("Secondsystem", "官方系统切换",
    "通过本页面可以切换到官方系统或重启当前系统。请确保操作前已备份重要配置。")

s = m:section(TypedSection, "status", "")
s.anonymous = true

s:option(DummyValue, "tip", "提示信息").value = [[
NRadio C8-668 按键切换到官方系统方式：
断电 → 按住 WPS 互联键 (顶住 reset 键) → 接通电源 →
等待系统电源灯亮起后，马上松开 WPS 按键 → 切换成功。
]]

status = s:option(DummyValue, "current_status", "当前系统状态")
status.template = "Secondsystem/status"
status.rmempty = true

switch = s:option(Button, "switch_button", "切换系统")
switch.inputtitle = "切换到官方系统"
switch.inputstyle = "reload"
switch.write = function()
    luci.sys.call("fw_setenv boot_system 0")
    luci.sys.call("reboot")
end

reboot = s:option(Button, "reboot_button", "重启系统")
reboot.inputtitle = "重启系统"
reboot.inputstyle = "reload"
reboot.write = function()
    luci.sys.call("python3 /usr/bin/at.py 'AT+CFUN=1,1'")
    luci.sys.call("reboot")
end

return m
