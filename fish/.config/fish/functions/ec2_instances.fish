function ec2_instances
  aws ec2 describe-instances | jq ".Reservations[].Instances[] | {id: .InstanceId, name: .Tags[]? | select(.Key | contains(\"Name\")) | .Value , ip: .PrivateIpAddress } " | jq --slurp '.' | jq -Cr " .[] | .id + \" (\" + .name + \") => \" + .ip"
end
