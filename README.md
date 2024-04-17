# GODOT 3D Game Template
<p align="center">
    <img width=500 src="https://github.com/MichaelOdermatt/BasicGameTemplate/assets/43145047/890e3d94-2582-485e-96cd-4ecc039b4558" />
</p>

# Menus
This template comes with a pre-built title screen and settings menu that can be easily expanded on or modified.

### Font
The menu's font can be easily changed by creating a new font in the `/Assets/Fonts` folder, then setting it to the _Default_ _Font_ for `/Assets/Themes/MenuTheme.tres` 

## Title Screen
<img width=600 src="https://github.com/MichaelOdermatt/BasicGameTemplate/assets/43145047/fd6efd3f-5844-4098-8714-bdfce7a77475" />

### Changing Title Screen Images
The two images on the title screen can be easily changed by opening `/Assets/Scenes/Menus/MainMenu.tscn` and changing the placeholder TextureRects.

![image](https://github.com/MichaelOdermatt/BasicGameTemplate/assets/43145047/8ed2d5aa-d5d2-4323-aee8-40ed10449c92)

## Settings Menu
<img width=600 src="https://github.com/MichaelOdermatt/BasicGameTemplate/assets/43145047/f50a9d95-5841-4d59-ac0b-6e16210cccc3" />

### Included Settings
**Video Settings**
- Window Mode
- Resolution
- Render Scale
- Anti Aliasing
- FOV

**Control Settings**
- Look Sensitivity

**Audio Settings**
- Master Volume

### How Settings Work
**Note: Settings do not persist between play sessions, meaning all settings will be reset back when the game is closed and reopened.

All of the setting values are saved in `/Assets/Scripts/AutoLoaded/Globals.gd` in the `setting_values` variable. The settings are saved as a `SettingsData` object which is not intended to be mutated but rather replaced with a new instance everytime a setting is changed. 

The function which build the new `SettingsData` object is called `get_settings_data()` in `/Assets/Scripts/Menus/SettingsMenu/SettingsMenu.gd`. It gets the value from every field in the settings menu and returns a new `SettingsData` object. So, when the Apply button is clicked in the settings menu, that `SettingsData` object is taken and stored in the autoloaded `Globals.gd` script so that it can be easily accessed from anywhere in the code.

## 3D Character Controller
Straightforward 3D Character Controller that handles all basic movement and allows you to modify things like walk speed, acceleration / decceleration, sprint speed, and more.
