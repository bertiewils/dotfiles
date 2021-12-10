#!/usr/bin/env bash
#
# Script to install my dotfiles
# Inspired by https://www.atlassian.com/git/tutorials/dotfiles

# CHANGE THESE as needed
ALIAS=dotfiles
REPO_URL=https://github.com/bertiewils/dotfiles.git

# CHANGE THIS to your chosen alias
dotfiles () {
   /usr/bin/git --git-dir="$HOME"/.dotfiles/ --work-tree="$HOME" "$@"
}

info () {
  # shellcheck disable=SC2059  # for clarity instead of format specifiers
  printf "INFO - $*\n"
}

warn () {
  # shellcheck disable=SC2059  # for clarity instead of format specifiers
  printf "${YELLOW}WARNING ${NC}- $*\n" >&2
}

# Main #########################################################################

# Update and exit early if ~/.dotfiles already exists
if [ -d ~/.dotfiles ]; then
  info "Dotfiles already installed"
  info "Pulling new changes"
  $ALIAS pull
  exit 2
fi

/usr/bin/git clone --bare $REPO_URL "$HOME/.dotfiles"

cd "$HOME" || exit 1

if $ALIAS checkout; then
  info "Checked out dotfiles"
else
  info "Backing up pre-existing dot files";
  BACKUP_DIR=~/.dotfiles-backup
  mkdir -p $BACKUP_DIR
  $ALIAS checkout 2>&1 \
    | grep -P '\t' \
    | awk '{ print $1 }' \
    | xargs -I {} mv {} $BACKUP_DIR/{}
  $ALIAS checkout && info "Checked out dotfiles"
fi

$ALIAS config --local status.showUntrackedFiles no

if ! alias $ALIAS &>/dev/null; then
  warn "Remember to add the alias permenantly (in .bashrc etc.)"
fi

cd - > /dev/null || exit
