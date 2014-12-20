curl -s getpe.delivery.puppetlabs.net | grep 3.7/ci-ready | grep 1480 | grep -oE "3.4.0-rc[0-9]-1480-g[0-9a-zA-Z]{7}" | uniq
