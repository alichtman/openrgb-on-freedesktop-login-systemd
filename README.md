# The Problem

- My keyboard LEDs turn off when I lock my computer.
- My keyboard LEDs do not turn on when I log back into the session.

My keyboard is a `Razer Chroma Ornata`, and I'm using `Ubuntu 22.04`.

# The Solution

A bash script can listen for `org.freedesktop.login1` `Unlock` signals on the dbus interface of `systemd-login`. When it detects one, the default openrgb profile is loaded.

- [org.freedesktop.login1 Documentation](https://www.freedesktop.org/software/systemd/man/org.freedesktop.login1.html)
- [OpenRGB](https://gitlab.com/CalcProgrammer1/OpenRGB)

This bash script is managed by a systemd service. **You will probably need to set your `XDG_CONFIG_HOME` in `openrgb-on-freedesktop-login.service`.**

## Installation

```bash
$ git clone THIS_REPO
$ cd THIS_REPO
$ chmod +x install.sh
$ sudo ./install.sh
```

## Uninstallation

```bash
$ sudo ./uninstall.sh
```
