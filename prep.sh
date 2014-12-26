#/bin/bash
# Update package list
sudo apt-get update || exit $?
# Install needed packages
sudo apt-get install wget mariadb-client php5-cli php-pear php5-curl php5-gd php5-imagick php5-json php5-mcrypt php5-mysql php5-sqlite rake git ack-grep byobu htop nmap || exit $?

while true; do
    read -p "Do you wish to install terminator and atom? (y/N)" yn
    case $yn in
        [Yy]* ) install_graphical_apps; break;;
        * ) break;;
    esac
done

install_graphical_apps ()
{
    # install terminator from repo
    sudo apt-get install terminator || exit $?

    # download atom
    wget https://atom.io/download/deb || exit $?

    # install aotm
    sudo dpkg -i /tmp/atom-amd64.deb || exit $?

    # install phpcs
    sudo pear install PHP_CodeSniffer || exit $?
}

if [ -d "$HOME/.dotfiles" ]
then
    echo "Dotfiles directory already exists!";
    exit 1;
fi

# Clone our dotfiles repo
git clone WHATERVER .dotfiles || exit $?

# Install the dotfiles
cd $HOME/.dotfiles && rake install
