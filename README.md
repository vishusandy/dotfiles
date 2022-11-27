# Dotfiles

These are just some config files.

Everything interesting is in the `.bashrc.d` folder.  Maybe you'll find some useful bash snippets there.  Or just a mess of shell scripts.

## Organization

The `.bashrc` file includes files in `~/.bashrc.d/vars/` to intialize some variables.  The variables can then be used by the files in `~/.bashrc.d/`, which get included next.

## Git Repo

Instead of symlinking the dotfiles into a folder with a git repo I used the techniques described in [The best way to store your dotfiles](https://www.ackama.com/what-we-think/the-best-way-to-store-your-dotfiles-a-bare-git-repository-explained/) and [Managing dotfiles with a bare git repo](https://marcel.is/managing-dotfiles-with-git-bare-repo/).  I am not using a bare repo, in case I need a place to store files related to this.

Git tracks the changes so I don't have to worry about maintaining symlinks.  The only downside is having to use an alias instead of just the `git` command, but on the plus side it works from **any** directory.






