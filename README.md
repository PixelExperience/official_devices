# Pixel Experience
## Official devices application

Devices repository: [PixelExperience-Devices](https://github.com/PixelExperience-Devices)

Before you open a pull request to add your device into our list of official devices, you should know a few things:

Any failure in following the below instructions will make you unfit for the maintainership. No questions asked.

### 1. To turn into a maintainer of PixelExperience:

1.2 - You must own the device. Blind and untested builds aren't allowed.

1.3 - You must have knowledge of git.

1.4 - You must do an unofficial build for atleast 2 weeks,  be sure that the build is stable for daily usage before applying. Stability context may differ for different devices, so explain for any exceptions.

1.5 - You must have your device sources public.

### 2. Maintainers conduct notes:

2.2 - The maintainers mustn't do any unofficial modifications, except if they're going to push it for acceptance on our [gerrit](https://gerrit.pixelexperience.org).
Also, a maintainer mustn't send an update to users with unmerged gerrit changes.

2.3 - The maintainers must upload theirs trees on [PixelExperience-Devices](https://github.com/PixelExperience-Devices) organisation. The trees should fully reflect the changes when a new build is pushed for that specific device tree. Last but not the least, it should be fully buildable.

2.4 - The maintainers must test every build before sending OTA update to user.

2.5 - The maintainers must keep authorship of git commits that are pushed, mandatory for all repository. Force-pushes are acceptable.

2.6 - Relationships fights can be done in PM on Telegram or XDA.

2.7 - The maintainers mustn't add any features in their device specific packages, eg. configpanel, XiaomiParts, etc., like KCAL, force Camera API2 label, etc. Features that are device specific and are available at stock firmware, eg. Alert Slider and Offscreen gestures for some OnePlus Devices, Fingerprint Gestures and MotoActions for Motorola Devices, are allowed, so does Dirac Sound Options for any device.

### 3. Hosting

Our files are hosted on our FTP server, you will receive the credentials when you join the team.

### 4. Changelog
For each new version, you need to upload the changelog to this repository in the device specific folder.

The changelog file name must match the **.zip** file name and should end with **.txt**

Eg: **.zip** is **PixelExperience_potter-8.1.0-20180207-0418-OFFICIAL.zip**, changelog file name should be **PixelExperience_potter-8.1.0-20180207-0418-OFFICIAL.txt**

Maintainers should always try to write a user understable changelog.

### 5. Over-the-air (OTA) updates
Our system is automatic, you should not worry about updating some script, just upload the new build to the FTP server and send a pull request with the changelog and also edit your device JSON file (**builds/your_device_codename.json**) in this repository.

Eg: Moto G 2013 is called **falcon**, so the device JSON file is **builds/falcon.json**

**Note:** New builds can take up to 30 minutes to appear on the site and in the OTA application.

### 6. JSON params

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
