# add Fish to /etc/shells
grep -qe '^/usr/bin/fish$' /etc/shells || echo '/usr/bin/fish' >> /etc/shells
