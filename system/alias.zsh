alias ls='ls -Fhal'
alias l='ls -lAh'
alias ll='ls -l'
alias la='ls -A'
alias lf='ls | grep -v ^d'
alias ld='ls -ld */'

# Pipe public key to my clipboard.
alias pubkey="more ~/.ssh/id_rsa.pub | pbcopy | echo '=> Public key copied to pasteboard.'"
