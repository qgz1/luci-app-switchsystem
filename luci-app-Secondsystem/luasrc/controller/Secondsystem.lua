module("luci.controller.Secondsystem", package.seeall)

function index()
    entry({"admin", "system", "Secondsystem"}, alias("admin", "system", "Secondsystem", "settings"), _("官方系统"), 50)
    entry({"admin", "system", "Secondsystem", "settings"}, template("Secondsystem/settings"), _("Settings"), 10)
    entry({"admin", "system", "Secondsystem", "switch"}, call("action_switch"), nil)
    entry({"admin", "system", "Secondsystem", "reboots"}, call("action_reboots"), nil)
    entry({"admin", "system", "Secondsystem", "status"}, call("action_status"), nil)
end

function action_switch()
    local sys = require "luci.sys"
    local http = require "luci.http"
    local confirm = http.formvalue("confirm")
    
    if confirm == "yes" then
        sys.call("fw_setenv boot_system 0")
        sys.call("reboot")
    else
        luci.http.redirect(luci.dispatcher.build_url("admin", "system", "Secondsystem", "settings"))
    end
end

function action_reboots()
    local sys = require "luci.sys"
    local http = require "luci.http"
    local confirm = http.formvalue("confirm")
    
    if confirm == "yes" then
        sys.call("python3 /usr/bin/at.py 'AT+CFUN=1,1'")
        sys.call("reboot")
    else
        luci.http.redirect(luci.dispatcher.build_url("admin", "system", "Secondsystem", "settings"))
    end
end

function action_status()
    local sys = require "luci.sys"
    local http = require "luci.http"
    local boot_system = sys.exec("fw_printenv boot_system 2>/dev/null | cut -d'=' -f2"):gsub("\n","")
    local status = "未知系统"

    if boot_system == "0" then
        status = "官方系统"
    elseif boot_system == "1" then
        status = "备用系统"
    end

    http.prepare_content("application/json")
    http.write_json({ status = status })
end
