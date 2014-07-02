export LANG=ja_JP.UTF-8
HISTFILE=$HOME/.zsh-history
HISTSIZE=100000
SAVEHIST=100000

## 補完機能の強化
autoload -U compinit;
compinit -u

## 複数の zsh を同時に使う時など history ファイルに上書きせず追加する
setopt append_history

## コアダンプサイズを制限
limit coredumpsize 102400

## 出力の文字列末尾に改行コードが無い場合でも表示
unsetopt promptcr

## 色を使う
setopt prompt_subst

## ビープを鳴らさない
setopt nobeep

## 内部コマンド jobs の出力をデフォルトで jobs -l にする
setopt long_list_jobs

## 補完候補一覧でファイルの種別をマーク表示
setopt list_types

## サスペンド中のプロセスと同じコマンド名を実行した場合はリジューム
setopt auto_resume

## 補完候補を一覧表示
setopt auto_list

## 直前と同じコマンドをヒストリに追加しない
setopt hist_ignore_dups

## cd 時に自動で push
setopt autopushd

## 同じディレクトリを pushd しない
setopt pushd_ignore_dups

## ファイル名で #, ~, ^ の 3 文字を正規表現として扱う
setopt extended_glob

## TAB で順に補完候補を切り替える
setopt auto_menu

## zsh の開始, 終了時刻をヒストリファイルに書き込む
setopt extended_history

## =command を command のパス名に展開する
setopt equals

## --prefix=/usr などの = 以降も補完
setopt magic_equal_subst

## ヒストリを呼び出してから実行する間に一旦編集
setopt hist_verify

# ファイル名の展開で辞書順ではなく数値的にソート
setopt numeric_glob_sort

## 出力時8ビットを通す
setopt print_eight_bit

## ヒストリを共有
setopt share_history

## 補完候補のカーソル選択を有効に
zstyle ':completion:*:default' menu select=1

## 補完候補の色づけ
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

## ディレクトリ名だけで cd
setopt auto_cd

## カッコの対応などを自動的に補完
setopt auto_param_keys

## ディレクトリ名の補完で末尾の / を自動的に付加し、次の補完に備える
setopt auto_param_slash

## スペルチェック
setopt correct

# コマンドライン全てのスペルチェックをする
setopt correct_all


## Default shell configuration
#
# set prompt
#
autoload colors
colors


case ${UID} in
0)
    #PROMPT="%B%{${fg[red]}%}%/#%{${reset_color}%}%b "
    #PROMPT2="%B%{${fg[red]}%}%_#%{${reset_color}%}%b "
    SPROMPT="%B%{${fg[red]}%}%r is correct? [n,y,a,e]:%{${reset_color}%}%b "
    [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && 
        PROMPT="%{${fg[cyan]}%}$(echo ${HOST%%.*} | tr '[a-z]' '[A-Z]') ${PROMPT}"
    ;;
*)
    local dir="%{${fg[red]}%}[%/]"$'\n'
    local info="%{${fg[red]}%}%n%%%{${reset_color}%} "
    PROMPT="$dir$info"
    local dir2="%[${fg[red]}%}[%_]"$'\n'
    PROMPT2="$dir2$info"
    #PROMPT="%{${fg[red]}%}%/%%%{${reset_color}%} "
    #PROMPT2="%{${fg[red]}%}%_%%%{${reset_color}%} "
    SPROMPT="%{${fg[red]}%}%r is correct? [n,y,a,e]:%{${reset_color}%} "
    [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && 
        PROMPT="%{${fg[cyan]}%}$(echo ${HOST%%.*} | tr '[a-z]' '[A-Z]') ${PROMPT}"
    ;;
esac

# if input reach to right prompt, vanish right prompt.
setopt transient_rprompt

## terminal configuration
#
unset LSCOLORS
case "${TERM}" in
    xterm)
    export TERM=xterm-color
    ;;
    cons25)
    unset LANG
    export LSCOLORS=ExFxCxdxBxegedabagacad
    export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
    zstyle ':completion:*' list-colors \
    'di=;34;1' 'ln=;35;1' 'so=;32;1' 'ex=31;1' 'bd=46;34' 'cd=43;34'
    ;;
esac

## Keybind configuration
#
# emacs like keybind (e.x. Ctrl-a goes to head of a line and Ctrl-e goes 
#   to end of it)
#
bindkey -e

# historical backward/forward search with linehead string binded to ^P/^N
#
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^p" history-beginning-search-backward-end
bindkey "^n" history-beginning-search-forward-end
bindkey "\\ep" history-beginning-search-backward-end
bindkey "\\en" history-beginning-search-forward-end

# set terminal title including current directory
#
case "${TERM}" in
    kterm*|xterm*)
    precmd() {
        echo -ne "\033]0;${USER}@${HOST%%.*}:${PWD}\007"
    }
    export LSCOLORS=exfxcxdxbxegedabagacad
    export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
    zstyle ':completion:*' list-colors \
    'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'
    ;;
esac

setopt complete_aliases
alias ls='ls -G'

#bindkey "^H" backward-delete-char
#alias screen="TERM=screen screen -U"
#alias minicom="LANG=c sudo minicom"
#export SCHEME_LIBRARY_PATH=/usr/share/slib/

#export JAVA_HOME=/usr/java/jdk1.6.0_14

export MANPATH=/opt/local/man:$MANPATH
alias cemacs='/Applications/Emacs.app/Contents/MacOs/Emacs'
alias emacs='/usr/local/bin/emacs'

#alias javac='javac -encoding UTF-8'
alias javac='javac -J-Dfile.encoding=UTF-8'
alias java='java -Dfile.encoding=UTF-8'

#SVN
export SVN_EDITOR='emacs'

#llvm
#export C_INCLUDE_PATH=/usr/local/include:/opt/local/include
#export CPLUS_INCLUDE_PATH=/usr/local/include:/opt/local/include
#export LIBRARY_PATH=/usr/local/lib:/opt/local/lib
#export LD_LIBRARY_PATH=/usr/local/lib:/opt/local/lib
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" # Load RVM function

export PATH=$PATH:$HOME/.rbenv/bin
eval "$(rbenv init -)"

function gem(){
    $HOME/.rbenv/shims/gem $*
    if [ "$1" = "install" ] || [ "$1" = "i" ] || [ "$1" = "uninstall" ] || [ "$1" = "uni" ]
    then
        rbenv rehash
    fi
}

function bundle(){
    $HOME/.rbenv/shims/bundle $*
    if [ "$1" = "install" ] || [ "$1" = "update" ]
    then
        rbenv rehash
    fi
}

#gcc
alias ggcc='/usr/local/Cellar/gcc48/4.8.2/bin/gcc-4.8'
alias vim='/usr/local/bin/vim'

#export GOROOT=$HOME/Lang/go
export GOROOT=/usr/local/go
export GOPATH=$HOME/.golang
export PATH=$PATH:$GOROOT/bin
export PATH=$PATH:$GOPATH/bin

source ~/.zsh/zaw/zaw.zsh
zstyle ':filter-select' case-insensitive yes
bindkey '^xb' zaw-cdr
bindkey '^x^b' zaw-git-recent-branches
bindkey '^x^f' zaw-git-files
bindkey '^x^r' zaw-history

#Swift
export SWIFT_HOME=$HOME/Workspace/Swift
export PATH=$PATH:/$SWIFT_HOME/swift-0.94.1/bin

#llvm
export LLVM_HOME=/usr/local/Cellar/llvm/3.4.1
export PATH=$PATH:$LLVM_HOME/bin
