# bash does /etc/profile then looks for
#  ~/.bash_profile, ~/.bash_login, ~/.profile
# and does the first in that list ... the present file.
source ~/.aliases
source ~/.functions
HISTSIZE=500

export GIT_PS1_SHOWDIRTYSTATE=1
source ~/.git-completion.sh
##export PATH=$PATH:~/Library/Haskell/ghc-7.0.3/lib/pandoc-1.8.1.1/bin
export PATH=${PATH}:/Users/kelley/bin
##export PATH="/usr/local/sbin:$PATH"
##export PATH=${PATH}:/Developer/usr/bin/
## function parse_git_dirty {
##     #[[ $(git status 2> /dev/null | tail -n1) != "nothing to commit (working directory clean)" ]] && echo "*"
##     [[ $(git status 2> /dev/null | tail -n1 | grep -v "nothing to commit") ]] && echo "*"
## }
## function parse_git_branch {
##   #git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/[\1$(parse_git_dirty)]/"
##   git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/[\1]/"
## }

IGNOREEOF=3

export LANG="en_CA.UTF-8"
export LC_ALL="en_CA.UTF-8"
if [ ! -n "$SSH_TTY" ]; then
    #export EDITOR='/Users/kelley/bin/mvim'
    export EDITOR='/usr/bin/vim'
else
    export EDITOR='/usr/bin/vim'
    alias mvim=/usr/bin/vim
fi

# Setting PATH for EPD-6.1-1
# The orginal version is saved in .bash_profile.pysave
## PATH="/Library/Frameworks/Python.framework/Versions/Current/bin:${PATH}"
export PATH

#MKL_NUM_THREADS=1
#export MKL_NUM_THREADS

## bashmarks
source ~/.local/bin/bashmarks.sh

function last_two_dirs {
pwd |rev| awk -F / '{print $1,$2}' | rev | sed s_\ _/_
}

function Rmd {
R --no-save -e 'library(rmarkdown); render("'$1'", "pdf_document")'
}

#PS1="\h:\W"
PS1="\h:"
export PS1="$PS1\$(last_two_dirs)"
#export PS1="$PS1\$(parse_git_branch)"
#export PS1="$PS1<\$(nb_count)> "
export PS1="$PS1$ "
#echo -n -e "k\033]0;emit\007"

export _R_CHECK_FORCE_SUGGESTS_=false

### pass, used to store passwords. Share work-home via dropbox
export PASSWORD_STORE_DIR=~/Dropbox/.password-store

# added by Anaconda3 2019.03 installer
# >>> conda init >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$(CONDA_REPORT_ERRORS=false '/anaconda3/bin/conda' shell.bash hook 2> /dev/null)"
if [ $? -eq 0 ]; then
    \eval "$__conda_setup"
else
    if [ -f "/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/anaconda3/etc/profile.d/conda.sh"
        CONDA_CHANGEPS1=false conda activate base
    else
        \export PATH="/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda init <<<
