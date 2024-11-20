package main

import (
	"fmt"
	"net"
	"os"
)

func main() {
	for _, host := range os.Args[1:] {
		ips, err := net.LookupIP(host)
		if err != nil {
			fmt.Printf("%s: %v\n", host, err)
			continue
		}

		for _, ip := range ips {
			if ipv4 := ip.To4(); ipv4 != nil {
				fmt.Printf("%s: %v\n", host, ipv4)
			}
		}
	}
}
