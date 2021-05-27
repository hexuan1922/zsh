```
docker build --rm -t local/he-c7-systemd .
```

or
```
docker login --username=hi34256869@aliyun.com registry.cn-beijing.aliyuncs.com
docker pull registry.cn-beijing.aliyuncs.com/hetest/centos7:last
```


on wsl test dind 
```
docker run --name aa --privileged -d -p 22:22  -v /var/run/docker.sock:/tmp/docker.sock -v /mnt/g:/mnt/g  local/he-c7-systemd
docker run --name aa --privileged -d -p 22:22  -v //var/run/docker.sock:/tmp/docker.sock -v /mnt/g:/mnt/g  local/he-c7-systemd
docker run --name aa --privileged -d -p 22:22  -v tcp://127.0.0.1:2376:/tmp/docker.sock -v /mnt/g:/mnt/g  local/he-c7-systemd
```

on wsl support dind 
```
docker run --name centos7 --privileged -d -p 22:22 -p 80:80 -p 81:81 -p 82:82 -p 83:83 -p 84:84 -v /var/run/docker.sock:/tmp/docker.sock -v /mnt/c:/mnt/c -v /mnt/d:/mnt/d -v /mnt/e:/mnt/e -v /mnt/f:/mnt/f -v /mnt/g:/mnt/g  local/he-c7-systemd
```

on cmd does not support dind
```
docker run --name centos7 --privileged -d -p 22:22 -p 80:80 -p 81:81 -p 82:82 -p 83:83 -p 84:84 -v c:/:/mnt/c -v d:/:/mnt/d -v e:/:/mnt/e  local/he-c7-systemd
```

start container
```
docker exec -it centos7 zsh
echo $DOCKER_HOST && docker version
docker rm -f centos7 && docker rmi local/he-c7-systemd
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