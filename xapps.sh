#/bin/bash
# install terminator from repo
sudo apt-get install terminator || exit $?

# download atom
wget -O /tmp/atom-amd64.deb https://atom.io/download/deb || exit $?

# install aotm
sudo dpkg -i /tmp/atom-amd64.deb || exit $?

# install phpcs
sudo pear install PHP_CodeSniffer || exit $?

# Install atom packages
apm install file-icons linter linter-jshint linter-phpcs merge-conflicts minimap
