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

### 2. OTA and Hosting

Our OTA system is automatic, you should not worry about updating some script. The builds are hosted on our own server. You must build the official releases on our CI, no builds outside of it can be released as official. After the build tested, you can release.

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

If you agree with everything, please [fill this form](https://forms.gle/b7kjDzsT2RrRh7WCA)
