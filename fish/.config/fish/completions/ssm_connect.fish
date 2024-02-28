complete -c ssm_connect -f -a '(ssm_instances | grep -oe "\((.*)\)" | tr -d \(\) )'

