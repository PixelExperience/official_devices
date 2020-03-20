# Pixel Experience
## Official devices application

Devices repository: [PixelExperience-Devices](https://github.com/PixelExperience-Devices)

Before you apply to add your device into our list of official devices, you should know a few things:

### 1. How to apply?

You must fulfill the following requirements before applying:

- [Maintainers requirements](https://github.com/PixelExperience/docs/blob/master/maintainers_requirements.md)

- [Device requirements](https://github.com/PixelExperience/docs/blob/master/device_requirements.md)

- [Maintainers' code of conduct](https://github.com/PixelExperience/docs/blob/master/maintainers_code_of_conduct.md)

You must be aware that just fulfilling these requirements doesn't necessarily mean that you're going to be accepted. We will also consider some other points if necessary, like experience or how your behavior is towards other people (users or otherwise), and even with some technical stuff.

### 2. OTA and Hosting

Our OTA system is automatic, you should not worry about updating some script. The builds are hosted on our own server. You must build the official releases on our CI, no builds outside of it can be released as official. After the build is tested, you may release it.

### 3. JSON params

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

##### team/maintainers.json
| Param | Description | Required |
|--|--|--|
| name | Your name (or nickname) | Yes |
| country | ISO-3166 Alpha 2 code of your country (2 digits, you can get from https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2) | Yes |
| github_username | Your github username (eg: https://github.com/jhenrique09/) | Yes |
| devices | Array with the device and the respective version that you maintain | Yes |
| xda_url | Direct url of your XDA profile (eg: https://forum.xda-developers.com/member.php?u=6519039) | No |
| telegram_url | Direct url of your telegram profile | No |

### 4. Device Image

We need a .png image with transparent background with sane quality with at least the device front being shown for our website. Those will go to the images folder with the filename being called as <device_codename>.png.

If you agree with everything, please [fill this form](https://forms.gle/b7kjDzsT2RrRh7WCA)
