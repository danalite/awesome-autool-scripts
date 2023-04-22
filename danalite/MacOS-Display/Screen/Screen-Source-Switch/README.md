
### Steps
- Install : https://github.com/kfix/ddcctl
- Example:

```bash
# DisplayPort-1    15
# DisplayPort-2	   16
# HDMI-1           17
# HDMI-2	       18

# Change display 1's source to input HDMI-1
$ ddcctl -d 1 -i 17

```
