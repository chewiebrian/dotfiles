complete -c aws_setenv -n 'test (count (commandline -opc)) -eq 2' -f -a '(aws --profile bunt ec2 describe-regions | jq -r .Regions[].RegionName)'
complete -c aws_setenv -n 'test (count (commandline -opc)) -lt 2' -f -a '(cat ~/.aws/config | grep -Po "(?<=\\[).*(?=\\])" | grep "profile" | cut -f2 -d" ")'
