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

echo "Prep complete, please run the following commands:\ncd $HOME/.dotfiles\nrake install"
