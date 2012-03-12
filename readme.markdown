# Chris Kelly's (@amateurhuman) dotfiles

Most of the things were stolen from other people, think of this as crowdsourced
dotfiles. I tried to credit people where I could, but I have been assembling
these files for so long (and not tracking where it came from) that plenty of
hard work from others is not being credited to them.

## Structure

Credit for the basic organization of these files goes to [Zach
Holman](https://github.com/holman). To some, this may be overkill but I have
found that it makes the constant pruning of dotfiles very easy.

### Symlinks

Everything with a .symlink file extension ends up as a dotfile symlink in my $HOME
directory (usually with the same name proceeded with a dot), for example
rspec.symlink will be symlinked to $HOME/.rspec. At some point in the future,
I'll write a script that does all the symlinking, but right now its manual.

### ZSH

I use ZSH as my shell (this is not the place to debate it, but just know that
you should). Everything with a .zsh file extension gets sourced (see
zsh/zshrc.symlink).

### Secrets

Secrets are kept in a gitignored secrets directory, put things that you don't
want committed to the repo in that directory (such as private keys). For an
example of its use see aws/ec2.zsh
