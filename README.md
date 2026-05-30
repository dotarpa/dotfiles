# README

### install dein

```
$ cd ~; pwd
$ git clone git@github.com:dotarpa/dotfiles.git
$ ln -s ~/dotfiles/.config ~/
```

### change log

- vim -> nvim
- dein -> Lazy


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

#### Note. lsp server

```
$ go get -u golang.org/x/tools/cmd/gopls
# pip3 install python-language-server
```

#### Note. add/fix plugins

- 20190308 add [LanguageClient-neovim](https://github.com/autozimu/LanguageClient-neovim)
- 20190805 add pyls
