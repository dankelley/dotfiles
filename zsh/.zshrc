# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/kelley/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    git
    z
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  #export EDITOR='vim'
  export EDITOR='/Applications/MacVim.app/Contents/bin/vim'
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias clean='rm -rf *~'
alias cp='cp -i'
alias ctags='/usr/local/bin/ctags' # use homebrew, not mac, for R
alias hist='history|tail -33'
alias m=make
alias mvim='/Applications/MacVim.app/Contents/bin/mvim'
#alias nnvim='~/Downloads/nvim-osx64/bin/nvim'
alias nvim=~/nvim-macos/bin/nvim
alias n=nota
#alias r='open -a R.app .'
alias rm='rm -i'
#alias R='open -a R.app .'
alias rs='open -a Rstudio .'
alias skim='open -a skim'
alias v='~/bin/v'
alias vim='/Applications/MacVim.app/Contents/bin/vim'
alias t='tmux a'
alias n='PYTHONPATH=~/git/nota python3 -m nota'
# ssh tries to attach to a tmux session on remote host
function ssht() {
    ssh $* -t '/usr/local/bin/tmux a || /usr/local/bin/tmux || /bin/zsh'
}

# prevent ctrl-d from killing the terminal (I want this because I am
# in a ctrl-d habit in terminals, which kills a tmux session.
setopt ignore_eof

# create a pdf from an Rmarkdown file
function Rmd() {
    R --no-save -e 'library(rmarkdown); render("'$1'", "pdf_document", encoding="UTF-8")'
}
# create a docx from an Rmarkdown file
function Rmdw() {
    R --no-save -e 'library(rmarkdown); render("'$1'", "word_document")'
}
# create html from an Rmarkdown file
function Rmdhtml() {
    R --no-save -e 'library(rmarkdown); render("'$1'", "html_document", encoding="UTF-8")'
}
function Rmdmd() {
    R --no-save -e 'library(rmarkdown); render("'$1'", "md_document", encoding="UTF-8")'
}


export PATH="/usr/local/bin:/usr/local/sbin:/Users/kelley/bin:$PATH"

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"


#[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

function J() {
    tmux  send-keys "vim $1" Enter \; \
        split-window -v \; \
        rename-window julia \; \
        send-keys "julia" Enter \; \
        select-pane -t 0 \; 
        }

export _R_REGEX_MARK_NEW_RESULT_AS_BYTES_="TRUE"
