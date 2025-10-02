# Fish-shell for Unraid - Slackware

## Fish package for Unraid (Slackware)

- This release includes:
  - Slackware package: **fish-4.1.1-x86_64-1_da.txz**
  - Built from upstream fish release: **fish-4.1.1-linux-x86_64.tar.xz**
  - Contains a single standalone `fish` binary for any Linux.
  - Packaged for Unraid.
  - Installation instructions in README.md.

## Old compiled versions for Slackware

<https://github.com/masterwishx/Develop-Project/tree/main/Fish>

## How to use

### Method 1 - Manual install

1. Copy the package file to your USB disk - `/boot/extra/` for auto-install on boot.  
   Quick install without reboot needed:
   ```sh
   wget -O /boot/extra/fish-4.1.1-x86_64-1_da.txz https://raw.githubusercontent.com/deepfriedmind/unraid-fish-shell/slackware-repo/slackware/fish-4.1.1-x86_64-1_da.txz && installpkg /boot/extra/fish-4.1.1-x86_64-1_da.txz
   ```
2. Run `fish` command in console.
3. Enjoy.

### Method 2 - Install via [un-get](https://github.com/ich777/un-get)

```sh
# Add the repo to un-get
echo "https://raw.githubusercontent.com/deepfriedmind/unraid-fish-shell/slackware-repo/slackware/ unraid-fish-shell" >> /boot/config/plugins/un-get/sources.list

# Update un-get sources
un-get update

# Install fish
un-get install fish

# Upgrade fish in the future
un-get update && un-get upgrade fish
```

### Bonus: Change default shell to fish

Add `chsh -s "$(which fish)"` to `/boot/config/go` to change the default shell to fish on boot.

```sh
echo -e '\n# Change default shell to fish\nchsh -s "$(which fish)"' >> /boot/config/go
```

## About Fish

- Fish - fish is a smart and user-friendly command line
  shell for Linux, macOS, and the rest of the family.

![image](https://user-images.githubusercontent.com/28630321/193850149-76a497c7-cb1a-4fb5-86f9-7d5e8aad77e5.png)

<https://fishshell.com/>

<https://github.com/fish-shell/fish-shell>
