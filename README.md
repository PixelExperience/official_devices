# Pixel Experience
## Official devices application

Devices repository: [PixelExperience-Devices](https://github.com/PixelExperience-Devices)

Before you apply to add your device into our list of official devices, you should know a few things:

### 1. How to apply?

You must fulfill the following requirements before applying:

- [Maintainers requirements](https://github.com/PixelExperience/docs/blob/master/maintainers_requirements.md)

- [Device requirements](https://github.com/PixelExperience/docs/blob/master/device_requirements.md)

- [Maintainers' code of conduct](https://github.com/PixelExperience/docs/blob/master/maintainers_code_of_conduct.md)

You must be aware that just fulfilling those requirements doesn't mean that you're going to be accept. We will also consider some other points if necessary, like experience or how's your behavior with other people (users or not) and even with some technical stuff.

### 2. Hosting

Our files are hosted on our FTP server, you will receive the credentials when you join the team.

### 3. Changelog
For each new version, you need to upload the changelog to this repository in the device specific folder.

The changelog file name must match the **.zip** file name and should end with **.txt**

Eg: **.zip** is **PixelExperience_potter-8.1.0-20180207-0418-OFFICIAL.zip**, changelog file name should be **PixelExperience_potter-8.1.0-20180207-0418-OFFICIAL.txt**

Maintainers should always try to write a user understable changelog.

### 4. Over-the-air (OTA) updates
Our system is automatic, you should not worry about updating some script, just upload the new build to the FTP server and send a pull request with the changelog and also edit your device JSON file (**builds/your_device_codename.json**) in this repository.

Eg: Moto G 2013 is called **falcon**, so the device JSON file is **builds/falcon.json**

**Note:** New builds can take up to 30 minutes to appear on the site and in the OTA application.

### 5. JSON params

##### devices.json
| Param | Description | Required |
|--|--|--|
| name | Device name | Yes |
| brand | Device manufacturer | Yes |
| codename | Device codename, eg: falcon | Yes |
| version_code | Version code, lowercase, eg: pie | Yes |
| version_name | Version name, will be shown on download portal, eg: Pie | Yes |
| maintainer_name | Your name | Yes |
| maintainer_url | Your personal URL, eg: https://github.com/jhenrique09/ or https://forum.xda-developers.com/member.php?u=6519039 | No  |
| xda_thread | XDA thread URL, eg: https://forum.xda-developers.com/g5-plus/development/rom-pixel-experience-t3704064 | No |

##### builds/your_device_codename.json
| Param | Description | Required |
|--|--|--|
| file_name | Build file (.zip) name | Yes |
| file_size | Build file (.zip) size (in bytes) | Yes |
| md5 | Build file (.zip) md5 hash | Yes |

If you agree with everything, please [fill this form](https://forms.gle/b7kjDzsT2RrRh7WCA)
