function ec2_instanceid
        switch $argv
	    case 'i-*'
              echo $argv
	    case 'mi-*'
	      echo $argv
            case '*'
	      set BYSSM (aws ssm describe-instance-information | jq -r ".InstanceInformationList[] | map_values(strings) | map_values(ascii_downcase) | select(.PingStatus == \"online\") | select(.Name == \"$argv\") | .InstanceId ")
	      [ -n "$BYSSM" ] && echo $BYSSM || aws ec2 describe-instances --filters Name=tag:Name,Values=$argv | jq -r .Reservations[].Instances[].InstanceId
        end	
end
