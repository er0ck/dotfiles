yep, it's my dotfiles
=====================

* clone me with --recursive to update various submodules included herein

* install using install.sh
    * (backs-up old files; creates a bunch of symlinks into your cloned dir)

shell
-----

* `shell/zshrc` + `shell/zprofile` are the zsh config (default shell on
  modern macOS). The prompt is developer-oriented, colored, and git-aware
  with zero external dependencies: no starship, no plugin manager, no
  extra sourced files. Git status and colors come from zsh's built-in
  `vcs_info` and prompt escapes.
* `shell/bashrc` + `shell/bash_profile` are the older bash config, kept
  for Linux servers and other non-zsh boxes.
