#!/bin/bash
backupPath=/mnt/Yedek/Bacups/dotsmanager
proccess=5
echo -e "\n

##--------------------##
|                      |
| Welcome To Dotsman   |
|                      |
##--------------------##
|                      |
| Please change your   |
|      proccess        |
|                      |
##--------------------##
|                      |
| 0.) Install Apps     |
| 1.) Restore Files    |
| 2.) Backup Files     |
| Press Enter For Exit |
|                      |
##--------------------##
\n"

read proccess

backup(){
echo "System Bacup Starting"
cp -fr $HOME/.config/nvim $backupPath
cp -fr $HOME/.config/alacritty $backupPath/config
cp -fr $HOME/.themes $backupPath
cp -fr $HOME/.icons $backupPath
cp $HOME/Pictures/*.jpg $backupPath/walls
cp -fr $HOME/.oh-my-zsh $backupPath
cp -fr $HOME/.local/share/gnome-shell/extensions $backupPath
cp -fr $HOME/.local/share/plank $backupPath
cp -f $HOME/.zshrc $backupPath
cp -f $HOME/.tmux.conf $backupPath
cp -f $HOME/.config/ufetch.sh $backupPath 
cp -f $HOME/.wakatime.cfg $backupPath 
dconf dump / > $backupPath/gnome-backup.dconf
}

restore(){
echo "System File Restore Starting"
cp -r $backupPath/nvim $HOME/.config
cp -r $backupPath/alacritty $HOME/.config
cp -r $backupPath/.themes $HOME
cp -r $backupPath/icons $HOME
cp $backupPath/walls/*.jpg $HOME/Pictures
cp -r $backupPath/.oh-my-zsh $HOME
cp -r $backupPath/extensions $HOME/.local/share/gnome-shell
cp -r $backupPath/plank $HOME/.local/share
cp  $backupPath/.zshrc $HOME
cp  $backupPath/.tmux.conf $HOME
cp  $backupPath/ufetch.sh $HOME/.config
cp  $backupPath/.wakatime.cfg $HOME
cp  $backupPath/.zshrc $HOME
dconf load / < $backupPath/gnome-backup.dconf
echo "System Files Restored"
}

appsInstall(){
sudo apt install tilix gnome-tweak-tool alacarte python-nautilus gparted gnome-mpv zsh rhythmbox flameshot plank git neovim curl simplescreenrecorder steam unrar fonts-powerline -y
sudo sed -i 's/NoDisplay=true/NoDisplay=false/g' /etc/xdg/autostart/*.desktop  #show hidden startups
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" -y
}


if [[ $proccess -eq 0 ]]; then
  appsInstall
  echo "Applications Installed"
elif [[ proccess -eq 1 ]]; then
  restore
  echo "System Restore Finished"
elif [[ $proccess -eq 2 ]]; then
  backup
  echo "System Bacup Finished"
  else
    exit
fi
