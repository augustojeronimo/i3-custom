# My Custom i3wm Configuration  

This repository contains a custom configuration for **i3wm** after installing Arch Linux. It is recommended to apply these settings right after installation to avoid dependency conflicts.  

This setup includes pre-configured **shortcuts, themes, and essential applications** for better usability and appearance.  

## Clone this repository  

To apply this configuration, clone the repository into your `~/.config` directory:  

```bash
cd ~/.config && git clone https://github.com/augustojeronimo/i3-custom.git
```

## Backup original files  

Before proceeding, it's recommended to back up your existing i3wm configuration:  

```bash
cp -r ~/.config/i3 ~/.config/i3.backup
```

## Install dependencies  

First, update and synchronize your system:  

```bash
sudo pacman -Syu
```

Then, install the required packages:  

### Required dependencies  

```bash
yay -S picom-git ttf-jetbrains-mono ttf-hack papirus-icon-theme brightnessctl feh dunst terminator rofi flameshot
```
> [Picom](https://github.com/yshui/picom) needs to be installed via `yay`, as the official `pacman` version lacks some features.  

## Apply the configuration  

Copy the **i3** configuration file:  

```bash
cp  ~/.config/i3-custom/config ~/.config/i3/config
```

Then, restart your system to apply the changes.

## Post-installation customization  

You can further tweak settings and customize components by editing the configuration files inside the project folder.
 
> The original configuration files remain preserved in their default locations. If you are following a tutorial that refers to modifying files for Picom, rofi, etc., remember that this configuration uses files stored inside the project folder. Any modifications should be made inside the files in this repository, not in the default system paths.
