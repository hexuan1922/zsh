```
docker build --rm -t local/he-c7-systemd .
docker run --name centos7 --privileged -itd -p 8880:80 -p 8881:81 -p 8882:82 -p 8883:83 -p 8884:84 -p 22:22 -v c:/:/mnt/c -v d:/:/mnt/d -v e:/:/mnt/e local/he-c7-systemd

docker exec -it  centos7 zsh
docker stop centos7  && docker rm centos7 && docker rmi local/he-c7-systemd
```

## install plugins
git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions  
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting  
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

Press prefix + I (capital i, as in Install) to fetch the tmux plugin.
You're good to go! The plugin was cloned to ~/.tmux/plugins/ dir and sourced.


## Power Line font for secureCRT or putty
1. move font/* to C:\Windows\Fonts  
2. reboot you secureCRT and set font to “DejaVu for Powerline”