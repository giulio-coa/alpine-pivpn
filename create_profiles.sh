#!/bin/bash

#########################################################################
#	Filename:		./create_profiles.sh																			#
#	Purpose:		Script that creates new Pi-VPN profiles.									#
#	Authors:		Giulio Coa <34110430+giulioc008@users.noreply.github.com>	#
#	License:		This file is licensed under the LGPLv3.										#
#	Pre-requisites:																												#
#									* docker																							#
#########################################################################

set -e

__create_clients() {
  local bold_grey
  local extra_parameters number_of_clients

  if ! command -v docker &> /dev/null; then
    echo -e "${bold_red}docker isn't installed${reset}" > /dev/stderr
    return 1
  fi

  # colors
  bold_grey='\e[1;39m'

  number_of_clients="${1:-1}"
  extra_parameters="${2:-}"

  printf 'Generating clients ... Please answer the prompts\n\n'

  # shellcheck disable=SC2034
  for i in $(seq 1 "${number_of_clients}"); do
    docker exec --interactive --tty pi-vpn pivpn add "${extra_parameters}"
  done

  docker cp pi-vpn:/home/pivpn/ovpns ovpns

  printf 'Done!\n\n'
  echo -e "All currently generated clients are in the ${bold_grey}/home/pivpn/ovpns${reset} directory of the Docker Container"
  echo -e "and in the ${bold_grey}${PWD}/ovpns${reset} directory of the host"
}

__help() {
  local underline_grey

  # colors
  underline_grey='\e[4;39m'

  printf 'create_profiles.sh [options]\n\nOptions:\n'
  printf '\t-c <NUM>, --clients <NUM>: Set how many clients you want to create\n'
  printf '\t-h, --help: Print this menu\n'
  printf '\t'
  echo -e "-n, --no-password: Creates ${underline_grey}ALL${reset} the clients with no password"
}

__main() {
  local reset bold_red
  local extra_parameters number_of_clients
  local options

  # colors
  reset='\e[0m'
  bold_red='\e[1;31m'

  extra_parameters=''
  number_of_clients=1

  if ! options="$(getopt --name "$0" --options 'c:hn' --longoptions 'clients:,help,no-password' -- "$@")"; then
    echo -e "${bold_red}getopt command has failed.${reset}" > /dev/stderr
    return 2
  fi

  eval set -- "${options}"

  while true; do
    case "$1" in
      -c | --clients)
        number_of_clients="$2"

        shift 2
        continue
        ;;
      -h | --help)
        __help

        shift
        break
        ;;
      -n | --no-password)
        extra_parameters='nopass'

        shift
        continue
        ;;
      --)
        shift
        break
        ;;
      *)
        echo -e "${bold_red}Internal error.${reset}" > /dev/stderr
        return 3
        ;;
    esac
  done

  __create_clients "${number_of_clients}" "${extra_parameters}"
}

__main "$@"
