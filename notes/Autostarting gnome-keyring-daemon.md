# The autostarting part

If you aren't using any display manager, edit `/etc/pam.d/login` and replace the file with the following block:

```
#%PAM-1.0

auth       required     pam_securetty.so
auth       requisite    pam_nologin.so
auth       include      system-local-login
auth       optional     pam_gnome_keyring.so
account    include      system-local-login
session    include      system-local-login
session    optional     pam_gnome_keyring.so auto_start
```

The key lines are the ones marked as optional.

NOTE: If you're using a display manager, you probably don't need to do this. To check, you can verify that the two lines mentioned above (the ones marked as optional) are there in the display manager's PAM config or not. It can be found in the same folder i.e. `/etc/pam.d`. For eg. LightDM's PAM config lies in `/etc/pam.d/lightdm`.

# Using gnome-keyring to handle ssh-keys instead of `ssh-agent`

In my experience, when PAM autostarts gnome-keyring, it doesn't enable the ssh component. To enable that, we need to export `SSH_AUTH_SOCK` by enabling the ssh component of gnome-keyring. It contains the path of the unix file socket that the agent uses for communication with other processes. This is essential for `ssh-add`.

Just add the following lines in your autostart. I prefer adding them in my `.zprofile`.
```sh
eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCK

# NOTE: If you are launching the dbus interface in your autostart, 
# it is required that the above lines go below the dbus-launch call.
```
