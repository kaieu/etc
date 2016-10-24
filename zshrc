# configuration for zsh

umask 002

# ¥³¥Þ¥ó¥ÉÍúÎò¤ÎÀßÄê
HISTFILE=~/etc/zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt hist_ignore_dups
setopt share_history

# Complete command options
autoload -U compinit
compinit
setopt complete_aliases

# auto_cd, auto_pushd
setopt auto_cd
setopt auto_pushd
setopt list_packed

# Command prompt
[ -f ~/etc/zsh_prompt ] && . ~/etc/zsh_prompt

# Command alias
[ -f ~/etc/alias.sh ] && . ~/etc/alias.sh

# Environmental variables
[ -f ~/etc/env.sh ] && . ~/etc/env.sh

# Ctrl-R ¤Ç¤ÎÍúÎò¤Î¥¤¥ó¥¯¥ê¥á¥ó¥¿¥ë¥µ¡¼¥Á
bindkey '^R' history-incremental-search-backward
#bindkey -e

zstyle ':completion:*' list-colors 'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'

# Ctrl-P/N ¤Ç¤ÎÍúÎò¤Î¥µ¡¼¥Á
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^p" history-beginning-search-backward-end
bindkey "^n" history-beginning-search-forward-end

show_window_title() {
  if [ "$TERM" = "screen" -o -n "$WINDOW" ]; then
    chpwd() { echo -n "k`dirs`\\" }
    preexec() {
      emulate -L zsh
      local -a cmd
      cmd=(${(z)2})
      case $cmd[1] in
      fg)
        if (( $#cmd == 1 )); then
          cmd=(builtin jobs -l %+)
        else
          cmd=(builtin jobs -l $cmd[2])
        fi
        ;;
      %*)
        cmd=(builtin jobs -l $cmd[1])
        ;;
      cd)
        if (( $#cmd == 2 )); then
          cmd[1]=$cmd[2]
        fi
        ;;
      ls|clear)
        echo -n "k$ZSH_NAME\\"
        return
        ;;
      screen|pwd)
        return
        ;;
      *)
        echo -n "k${cmd[1]:t}\\"
        return
        ;;
      esac
      local -A jt; jt=(${(kv)jobtexts})
      $cmd >>(read num rest
          cmd=(${(z)${(e):-\$jt$num}})
      echo -n 'k$cmd[1]:t\\') 2>/dev/null
    }
    chpwd
  fi
}

#show_window_title

# vim:set ts=2 sw=2 et:
