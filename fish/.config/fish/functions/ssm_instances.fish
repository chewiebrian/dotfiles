function ssm_instances
  aws ssm describe-instance-information | jq -r '.InstanceInformationList[] | map_values(strings) | map_values(ascii_downcase) | .Name + " => " + .InstanceId'
end
