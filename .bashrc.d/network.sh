#!/usr/bin/env bash

# network
#:: https://www.cyberciti.biz/faq/show-ethernet-adapter-ubuntu-linux/
alias network-adapters="ifconfig -s -a" # OR: netstat -i
alias list-adapters="network-adapters"
alias list-network-adapters="network-adapters"
alias network-devices="sudo lshw -short -c network"
alias ethernet-adapter-name="lspci | grep -i eth"
alias dhcp-renew="dhcp_renew"
alias release-renew="dhcp-renew"
alias renew-ip="dhcp-renew"
dhcp_renew() {
    if [[ "$1" ]]; then
        sudo dhclient -r "$1" && sudo dhclient "$1"
    fi
}
alias list-ports="sudo lsof -i -P -n"
alias listports="sudo lsof -i -P -n"
alias show-open-ports="rpcinfo -s"
alias show-ipv4="curl -4 icanhazip.com"
alias show-ip="curl -4 icanhazip.com"
alias show-ipv6="curl -6 icanhazip.com"
# shellcheck disable=SC2142
alias show-private-ips='ifconfig | grep -w inet | awk '\''{ print '\$'2}'\'
alias private-ips="show-private-ips"
alias private-ips6="show-all-private-ips"
# like show-private-ips but also include any IPv6 not just IPv4 addresses
alias show-all-private-ips="ifconfig -a | grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)' | awk '{ sub(/inet6? (addr:)? ?/, \"\"); print }' | sort" # https://github.com/mathiasbynens/dotfiles/blob/main/.aliases
alias show-private-ipv6="show-all-private-ips"
alias show-internet-connections="ss -A inet"
alias show-all-connections="ss -O"
alias show-listening-connections="ss -l"
# shellcheck disable=SC2142
alias show-subnets="ip a s | grep -w inet | awk '{ print \$2}'"
