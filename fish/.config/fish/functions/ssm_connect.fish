function ssm_connect
        if not test -z "(crudini --get ~/.aws/credentials | grep arn:aws:sts)"
          set AWS_PROFILE (crudini --get ~/.aws/credentials | grep arn:aws:sts)
          export AWS_PROFILE=$AWS_PROFILE
          export AWS_DEFAULT_REGION=eu-central-1
          export AWS_DEFAULT_REGION=(aws --profile "$AWS_PROFILE" ec2 describe-regions | jq -r .Regions[].RegionName | fzf -e --height 1% --header 'Select AWS region' --reverse --info=hidden --query $AWS_DEFAULT_REGION --preview 'aws --profile='$AWS_PROFILE' ssm get-parameter --name /aws/service/global-infrastructure/regions/{}/longName | jq -r .Parameter.Value')
        end
        if test -z "$AWS_PROFILE"          
          set AWS_PROFILE (cat ~/.aws/config | grep -Po "(?<=\\[).*(?=\\])" | grep "profile" | cut -f2 -d' ' | fzf -e --height 1% --header 'Select AWS profile' --reverse --info=hidden)
          test -z "$AWS_PROFILE" && return
          export AWS_PROFILE=$AWS_PROFILE
          export AWS_DEFAULT_REGION=(aws --profile $AWS_PROFILE ec2 describe-regions | jq -r .Regions[].RegionName | fzf -e --height 1% --header 'Select AWS region' --reverse --info=hidden --query (crudini --get ~/.aws/config "profile $AWS_PROFILE" region | cut -c-5) --preview 'aws --profile='$AWS_PROFILE' ssm get-parameter --name /aws/service/global-infrastructure/regions/{}/longName | jq -r .Parameter.Value')
        end
	AWS_PROFILE=$AWS_PROFILE AWS_DEFAULT_REGION=$AWS_DEFAULT_REGION aws ssm start-session --target (ec2_instanceid $argv)
end
