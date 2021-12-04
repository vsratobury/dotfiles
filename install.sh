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
curl -L -o hack-font.zip https://github.com/source-foundry/Hack/releases/download/v3.003/Hack-v3.003-ttf.zip
unzip -j hack-font.zip -d .fonts/ && rm hack-font.zip 
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

echo "setup finished, now open kitty.app"
