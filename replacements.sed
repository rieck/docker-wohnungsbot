#!/bin/sed -f

# Remove CtrlAltDelButton
/getElementById('sendCtrlAltDelButton')/,+1d
/<div id="sendCtrlAltDelButton.*$/d

# Replace window title, append favicon
s/\(<title>\)noVNC/\1Wohnungsbot/;T;a <link rel="icon" type="image\/x-icon" href="favicon.ico">