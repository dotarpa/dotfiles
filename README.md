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
// CentOS8
# sed -i -e s/enabled=0/enabled=1/g /etc/yum.repos.d/CentOS-PowerTools.repo
# dnf install ninja-build libtool autoconf automake cmake gcc gcc-c++ make pkgconfig unzip patch


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
# pip3.6 install pynvim
```

- Env: CentOS7

```
# yum install -y python3
# pip3.6 install --upgrade pip
# pip3.6 install pynvim
```

- Env: CentOS8

```
# dnf install -y python3
# pip3 install --upgrade pip
# pip3 install pynvim
```

#### Note. lsp server

```
$ go get -u golang.org/x/tools/cmd/gopls
# pip3 install python-language-server
```

#### Note. add/fix plugins

- 20190308 add [LanguageClient-neovim](https://github.com/autozimu/LanguageClient-neovim)  
- 20190805 add pyls  
- 20201027 add CentOS8 Setup  
