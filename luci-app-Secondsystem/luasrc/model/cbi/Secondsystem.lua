m = Map("Secondsystem", "官方系统切换",
    "通过本页面可以切换到官方系统或重启当前系统。请确保操作前已备份重要配置。")

s = m:section(TypedSection, "status", "")
s.anonymous = true

-- 提示信息展示
s:option(DummyValue, "tip", "提示信息").value = [[
NRadio C8-668 按键切换到官方系统方式：<br>
断电 → 按住 WPS 互联键 (顶住 reset 键) → 接通电源 →<br>
等待系统电源灯亮起后，马上松开 WPS 按键 → 切换成功。
]]

-- 当前系统状态展示
status = s:option(DummyValue, "current_status", "当前系统状态")
status.template = "Secondsystem/status"
status.rmempty = true

-- 切换系统按钮（带确认和响应优化）
switch = s:option(Button, "switch_button", "切换系统")
switch.inputtitle = "切换到官方系统"
switch.inputstyle = "reload"
-- 添加确认对话框
switch.write = function(self, section)
    -- 显示确认提示
    luci.http.write([[
        <script type="text/javascript">
            if(confirm("确定要切换到官方系统吗？操作后系统将立即重启！")){
                window.location.href = "]] .. luci.dispatcher.build_url("admin", "system", "Secondsystem", "switch") .. [[?confirm=yes";
            } else {
                window.location.reload();
            }
        </script>
    ]])
    luci.http.close()
end

-- 重启系统按钮（带确认和响应优化）
reboot = s:option(Button, "reboot_button", "重启系统")
reboot.inputtitle = "重启系统"
reboot.inputstyle = "reload"
-- 添加确认对话框
reboot.write = function(self, section)
    -- 显示确认提示
    luci.http.write([[
        <script type="text/javascript">
            if(confirm("确定要重启系统吗？操作后系统将立即重启！")){
                window.location.href = "]] .. luci.dispatcher.build_url("admin", "system", "Secondsystem", "reboots") .. [[?confirm=yes";
            } else {
                window.location.reload();
            }
        </script>
    ]])
    luci.http.close()
end

return m
    
