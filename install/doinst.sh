# Install binary Fish
echo yes | /usr/bin/fish --install

# add Fish to /etc/shells
grep -qe '^/usr/bin/fish$' /etc/shells || echo '/usr/bin/fish' >> /etc/shells
