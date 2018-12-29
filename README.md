# Pixel Experience
## Official devices application

Devices repository: https://github.com/PixelExperience-Devices

Before you open a pull request to add your device into our list of official devices, you should know a few simple things:

### 1. Hosting

Our files are hosted on our FTP server, you will receive the credentials when you join the team.

### 2. Changelog
For each new version, you need to upload the changelog to this repository in the device specific folder.

The changelog file name must match the **.zip** file name and should end with **.txt**
Eg: **.zip** is **PixelExperience_potter-8.1.0-20180207-0418-OFFICIAL.zip**, changelog file name should be **PixelExperience_potter-8.1.0-20180207-0418-OFFICIAL.txt**

### 3. Over-the-air (OTA) updates
Our system is automatic, you should not worry about updating some script, just upload the new build to the FTP server and send a pull request with the changelog and also edit your device JSON file (**builds/your_device_codename.json**) in this repository.

Eg: Moto G 2013 is called **falcon**, so the device JSON file is **builds/falcon.json**

**Note:** New builds can take up to 30 minutes to appear on the site and in the OTA application.

### 4. JSON params

##### devices.json
| Param | Description | Required |
|--|--|--|
| name | Device name | Yes |
| brand | Device manufacturer | Yes |
| codename | Device codename, eg: falcon | Yes |
| version_code | Version code, lowercase, eg: oreo | Yes |
| version_name | Version name, will be shown on download portal, eg: Oreo | Yes |
| maintainer_name | Your name | Yes |
| maintainer_url | Your personal URL, eg: https://github.com/jhenrique09/ or https://forum.xda-developers.com/member.php?u=6519039 | No  |
| xda_thread | XDA thread URL, eg: https://forum.xda-developers.com/g5-plus/development/rom-pixel-experience-t3704064 | No |

##### builds/your_device_codename.json
| Param | Description | Required |
|--|--|--|
| file_name | Build file (.zip) name | Yes |
| file_size | Build file (.zip) size (in bytes) | Yes |
| md5 | Build file (.zip) md5 hash | Yes |

### 5. Build type
You need to add 'export CUSTOM_BUILD_TYPE=OFFICIAL' in your build environment so OTA app will be included.

### 6. Device tree
Maintainers should upload the device tree on https://github.com/PixelExperience-Devices
