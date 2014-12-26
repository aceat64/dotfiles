#/bin/bash
# Update package list
sudo apt-get update || exit $?
# Install needed packages
sudo apt-get install wget mariadb-client php5-cli php-pear php5-curl php5-gd php5-imagick php5-json php5-mcrypt php5-mysql php5-sqlite rake git ack-grep byobu htop nmap || exit $?

if [ -d "$HOME/.dotfiles" ]
then
    echo "Dotfiles directory already exists!";
    exit 1;
fi

cd $HOME

# Clone our dotfiles repo
git clone git@github.com:aceat64/dotfiles.git .dotfiles || exit $?

# Install the dotfiles
cd $HOME/.dotfiles && rake install

install_xapps ()
{
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
}

while true; do
    read -p "Do you wish to install terminator and atom? (y/N)" yn
    case $yn in
        [Yy]* ) install_xapps; break;;
        * ) break;;
    esac
done
