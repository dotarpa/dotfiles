# README

### install dein

```
$ cd ~; pwd
$ git clone git@github.com:Bentham3314/dotfiles.git
$ ln -s ~/dotfiles/.vim/ ~/
$ ln -s ~/dotfiles/.config ~/
```

### change log

- vim -> nvim
- dein


#### Note. install nvim

- [prerequisites](https://github.com/neovim/neovim/wiki/Building-Neovim#build-prerequisites)  

```
# cd /usr/local/src/ ; pwd
# git clone https://github.com/neovim/neovim
# cd neovim
# git tag
# git checkout [stable release or most-recent tag]
# make
# make install
```

#### Note. install Python3

- Env: CnetOS6

```
# yum install -y https://centos6.iuscommunity.org/ius-release.rpm
# yum install -y python36*
# pip3.6 install --upgrade pip
# pip3.6 install neovim
```

- Env: CentOS7

```
# yum install -y https://centos7.iuscommunity.org/ius-release.rpm
# yum install -y python36*
# pip3.6 install --upgrade pip
# pip3.6 install neovim
```
