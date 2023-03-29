#!/bin/bash

# setup mac ports;
curl -L -o macports.pkg https://github.com/macports/macports-base/releases/download/v2.6.4/MacPorts-2.6.4-10.13-HighSierra.pkg && open macports.pkg
port selfupdate

# setup gnu pgp2 whit pinentry_mac
port install gnupg2 +pinentry_mac

# compile kitty
port install python39 pkgconfig libpng lcms2 librsync harfbuzz
port select --set python python39
port select --set python3 python39

cd $TMPDIR && git clone https://github.com/kovidgoyal/kitty && cd kitty
CFLAGS=-I/opt/local/include LDFLAGS=-L/opt/local/lib make app
cp -R ./kitty.app /Applications/

# setup fonts
cd -
mkdir .fonts
curl -L -o hack-font.zip https://github.com/tonsky/FiraCode/releases/download/6.2/Fira_Code_v6.2.zip
unzip -j Fira_Code_v6.2.zip -d .fonts/ && rm Fira_Code_v6.2.zip
fc-cache -fv

# install FZF
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install

# install ag
port  install the_silver_searcher
echo "export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g \"\"'" >> .bashrc
mv ~/.bashrc ~/.profile

# compile neovim
port install ninja cmake autoconf automake
cd $TMPDIR
git clone https://github.com/neovim/neovim.git && cd neovim
make install CMAKE_BUILD_TYPE=Release

# setup fish shell
port install fish && chpass -s /opt/local/bin/fish ${USER}
# curl https://git.io/fisher --create-dirs -sLo ~/.config/fish/functions/fisher.fish

# install go and others
#echo "download latest go package, then return ot install"
#open https://go.dev/dl/

#read -n 1 -s -r -p "Press any key to continue"

#go install golang.org/x/tools/gopls@latest
#go install golang.org/x/lint@latest
#go install golang.org/x/tools/cmd/godoc@latest

# install cmake lsp
port install py39-pip
port select --set pip pip39
port select --set pip3 pip39
pip install cmake-language-server

# install lua lsp
git clone https://github.com/sumneko/lua-language-server ~/lualsp
cd ~/lualsp
git submodule update --init --recursive
cd 3rd/luamake
./compile/install.sh
cd ../..
./3rd/luamake/luamake rebuild

# install clangd
curl -L -o clangd.zip https://github.com/clangd/clangd/releases/download/10.0.0/clangd-mac-10.0.0.zip
unzip clangd.zip && cd clangd_10.0.0
cp bin/clangd /usr/local/bin/

# install cppman
port install -u cppman
cppman -s cppreference.com > /dev/null && cppman -c > /dev/null &
echo "please wait ..."
sleep 15
echo "continue ..."
cd ~/.local && mkdir man && cd man && ln -s ~/.cache/cppman/man3 . &

echo "setup finished, now open kitty.app"
