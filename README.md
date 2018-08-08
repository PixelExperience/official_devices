# Pixel Experience
## Official devices application

Devices repository: https://github.com/PixelExperience-Devices

Before open a pull request to add your device into our list of official devices, you should know a few simple things:

### 1. Hosting

Our files are hosted on [Android File Host](http://androidfilehost.com/), this means you must have a developer account to host the builds of your device.

The folder must be in **hidden mode**, so our [download portal](https://download.pixelexperience.org/) can manage statistics correctly.

### 2. Changelog
For each new version, you need to upload the changelog to this repository in the device specific folder.

The changelog file name must match the **.zip** file name and should end with **.txt**
Eg: **.zip** is **PixelExperience_potter-8.1.0-20180207-0418-OFFICIAL.zip**, changelog file name should be **PixelExperience_potter-8.1.0-20180207-0418-OFFICIAL.txt**

### 3. Over-the-air (OTA) updates
Our system is automatic, you should not worry about updating some script, just upload the new build to the Android File Host device folder and send a pull request with the changelog in this repository.

**Note:** New builds can take up to 30 minutes to appear on the site and in the OTA application.

### 4. JSON params
| Param | Description | Required |
|--|--|--|
| name | Device name | Yes |
| brand | Device manufacturer | Yes |
| codename | Device codename, eg: falcon | Yes |
| version_code | Version code, lowercase, eg: oreo | Yes |
| version_name | Version name, will be shown on download portal, eg: Oreo | Yes |
| afh_folder | URL of your hidden AFH folder, eg: https://www.androidfilehost.com/?w=files&flid=229608 | Yes |
| maintainer_name | Your name | Yes |
| maintainer_url | Your personal URL, eg: https://github.com/jhenrique09/ or https://forum.xda-developers.com/member.php?u=6519039 | No  |
| xda_thread | XDA thread URL, eg: https://forum.xda-developers.com/g5-plus/development/rom-pixel-experience-t3704064 | No |

### 5. Build type
You need to add 'export CUSTOM_BUILD_TYPE=OFFICIAL' in your build environment so OTA app will be included

### 6. Device tree
Maintainers should upload the device tree on https://github.com/PixelExperience-Devices
