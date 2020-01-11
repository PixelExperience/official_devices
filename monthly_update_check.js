let fs = require('fs');
var XMLHttpRequest = require("xmlhttprequest").XMLHttpRequest;
var moment = require('moment');

function httpGet(theUrl) {
    var xmlHttp = new XMLHttpRequest();
    xmlHttp.open("GET", theUrl, false); // false for synchronous request
    xmlHttp.send(null);
    return xmlHttp.responseText;
}

function getdevices(obj) {
    var devices = [];
    for (var i = 0; i < obj.length; i++)
        devices.push(obj[i]["codename"]);
    return devices;
}

function istensupported(devices, codename) {
    for (var i = 0; i < devices.length; i++)
        if (devices[i]["codename"] == codename) {
            for (var j = 0; j < devices[i]["supported_versions"].length; j++) {
                if (devices[i]["supported_versions"][j]["version_code"] ==
                    "ten")
                    return true;
            }
            return false;
        }
}

function getmaintainer(devices, codename) {
    for (var i = 0; i < devices.length; i++)
        if (devices[i]["codename"] == codename) {
            for (var j = 0; j < devices[i]["supported_versions"].length; j++) {
                if (devices[i]["supported_versions"][j]["version_code"] ==
                    "ten")
                    return devices[i]["supported_versions"][j]["maintainer_url"]
            }
        }
}

function getmaintainername(devices, codename) {
    for (var i = 0; i < devices.length; i++)
        if (devices[i]["codename"] == codename) {
            for (var j = 0; j < devices[i]["supported_versions"].length; j++) {
                if (devices[i]["supported_versions"][j]["version_code"] ==
                    "ten")
                    return devices[i]["supported_versions"][j][
                        "maintainer_name"
                    ]
            }
        }
}

function getdeprecation(devices, codename) {
    if (!istensupported(devices, codename))
        return true;
    for (var i = 0; i < devices.length; i++)
        if (devices[i]["codename"] == codename) {
            return devices[i]["supported_versions"][0]["deprecated"]
        }
}

var devices_to_kick = "`These devices need to update ASAP or respond. Else they "+
                      "will be kicked`%0A%0A";

try {
    console.log("Starting Maintainer Update Check....");
    var whitelist_device = process.env.WHITELIST_DEVICE;
    var whitelist_maintainer = process.env.WHITELIST_MAINTAINER;
    let data = fs.readFileSync("devices.json");
    let json_data = JSON.parse(data);
    var devices = getdevices(json_data);
    let i;
    for (i = 0; i < devices.length; i++) {
        if (whitelist_device.includes(devices[i])) {
            continue;
        }
        let url = "https://download.pixelexperience.org/ota_v3/" + devices[i] +
            "/ten";
        //console.log(httpGet(url));
        var device = JSON.parse(httpGet(url));
        if (!device["error"]) {
            var build_date = moment.unix(device["datetime"]);
            var time_to_now = build_date.toNow();
            if (time_to_now.includes("days") || time_to_now.includes("hours") ||
                time_to_now.includes("minutes") || time_to_now.includes("day")
            ) {
                //console.log(devices[i] + " is okay");
            } else {
                if(whitelist_maintainer.includes(getmaintainername(json_data, devices[i]))) {
                    continue;
                }
                if (!getdeprecation(json_data, devices[i]))
                    if (getmaintainer(json_data, devices[i]).includes(
                            "github") || getmaintainer(json_data, devices[i])
                        .includes("xda")) {
                        devices_to_kick += "- `" + getmaintainername(json_data, devices[
                                i]) + "` maintaining `" + devices[i] +
                            "` doesnt have tg url" + "%0A%0A";
                    } else if (getmaintainer(json_data, devices[i]).includes(
                        "https://t.me/")) {
                    devices_to_kick += "- `" + getmaintainername(json_data, devices[
                            i]) + "` @" + getmaintainer(json_data, devices[i])
                        .slice(
                            13, ) + " maintaining `" + devices[i] + "`%0A%0A";
                }
            }
        } else {
            if (istensupported(json_data, devices[i])) {
                if(whitelist_maintainer.includes(getmaintainername(json_data, devices[i]))) {
                    continue;
                }
                if (getmaintainer(json_data, devices[i]).includes("github") ||
                    getmaintainer(json_data, devices[i]).includes("xda")) {
                    devices_to_kick += "- `" + getmaintainername(json_data, devices[
                            i]) + "` maintaining and hasnt pushed a build yet for `" + devices[i] +
                        "` doesnt have tg url" + "%0A%0A";
                } else if (getmaintainer(json_data, devices[i]).includes(
                        "https://t.me/")) {
                    devices_to_kick += "- `"+getmaintainername(json_data, devices[
                            i]) + "` @" + getmaintainer(json_data, devices[i])
                        .slice(13, ) + " maintaining `" + devices[i] + "` hasnt pushed a build yet.%0A%0A";
                }
            } else {
                //console.log(devices[i] + " is not supported on ten");
            }
        }
    }
} catch (e) {
    console.log(e);
    process.exit(1);
} finally {
    if(devices_to_kick=="**These devices need to update ASAP or respond. Else"+
                        "they will be kicked**%0A%0A")
      {
        devices_to_kick = "`No devices to kick. Keep up the good work guys!%0A%0A`";
      }
    if (whitelist_device==="")
    devices_to_kick += "`No device was whitelisted. %0A%0A`";
    else
    devices_to_kick += "`The following devices are whitelisted from these checks: `" + whitelist_device + "%0A%0A";
    if (whitelist_maintainer==="")
    devices_to_kick += "`No maintainer was whitelisted. %0A%0A`";
    else
    devices_to_kick += "`The following maintainers are whitelisted from these checks: `" + whitelist_maintainer + "%0A%0A";
    devices_to_kick += "`If build is below the one month limit, ignore this warn.%0A%0A`"
    devices_to_kick += "@AndroidPie9 @Hlcpereira `please pin this`"
    fs.writeFileSync("/tmp/devices_to_kick", devices_to_kick)  
    console.log("Process Exited with 0");
}
