_t(){
  _arguments -s : \
    '-e[Open editor.]' \
    '-d[Delete task.]'
  _files -W "$TODOS"/
}

compdef _t t

t() {
  edit(){
    $EDITOR "$1"
  }

  delete(){
    rm "$1" -r
  }

  all(){
    ls "$TODOS" -1
  }

  show(){
    cat $1
  }

  new(){
    touch $1
  }

  show_or_create(){
    if test -f $1
    then
      show $1
    else
      new $1
    fi
  }

  analize_options(){
    while getopts e:d: opt
    do
      case "$opt" in
        e) edit "$TODOS"/"$OPTARG";;
        d) delete "$TODOS"/"$OPTARG";;
      esac
    done
  }

  case $# in
    0) all;;
    1) show_or_create "$TODOS"/"$1";;
    2) analize_options $1 $2 ;;
  esac
}
