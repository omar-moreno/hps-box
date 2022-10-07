
export hps_base=$(cd ..; pwd -P)

__help() { 
    echo "Hellpppppp"
}

__run() {
 
  _pwd=$(pwd -P)/.

  docker run --rm \
    -e hps_base \
    -v $hps_base:$hps_base \
    -u $(id -u ${USER}):$(id -g ${USER}) \
    hps-dev $_pwd "$@"
  return $?

}

hps_run() {
  # Arguments are required to run
  [[ "$#" == "0" ]] && __help;

  case $1 in
    # List all available docker images
    list) 
      docker images
      ;;
    # By default, run all passed commands in the current directory
    *)
      __run $@
      ;;
  esac 
}
