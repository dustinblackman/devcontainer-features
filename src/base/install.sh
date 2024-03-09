#!/usr/bin/env bash

set -e

echo "Installing dependencies"
apt-get update
apt-get install -y curl git gnupg2 htop jq openssh-client procps sudo zsh
apt-get clean
apt-get autoclean

echo "Installing prezto"
git clone --recursive https://github.com/sorin-ionescu/prezto.git "$_REMOTE_USER_HOME/.zprezto"
(cd "$_REMOTE_USER_HOME"/.zprezto && git checkout d03bc03fddbd80ead45986b68880001ccbbb98c1)
rm -rf "$_REMOTE_USER_HOME"/.zprezto/**/.git "$_REMOTE_USER_HOME"/.zprezto/.git

ls "$_REMOTE_USER_HOME"/.zprezto/runcoms | grep -v README | while read rcfile; do
	if [[ ! -f "$_REMOTE_USER_HOME/.${rcfile}" ]]; then
		ln -s "$_REMOTE_USER_HOME"/.zprezto/runcoms/"$rcfile" "$_REMOTE_USER_HOME/.${rcfile:t}"
	fi
done
rm -f "$_REMOTE_USER_HOME"/.zlogout "$_REMOTE_USER_HOME"/.zshrc

sudo chsh -s /usr/bin/zsh "$_REMOTE_USER"
echo "cd /workspace" >>"$_REMOTE_USER_HOME"/.zlogin

cp "$(dirname "$0")/zshrc" "$_REMOTE_USER_HOME"/.zshrc
