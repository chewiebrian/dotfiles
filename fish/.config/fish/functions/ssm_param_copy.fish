function ssm_param_copy
  if test -z "$AWS_PROFILE"          
   set AWS_PROFILE (cat ~/.aws/config | grep -Po "(?<=\\[).*(?=\\])" | grep "profile" | cut -f2 -d' ' | fzf -e --height 1% --header 'Select AWS profile' --reverse --info=hidden)
   test -z "$AWS_PROFILE" && return
   export AWS_PROFILE=$AWS_PROFILE
   export AWS_DEFAULT_REGION=(aws --profile $AWS_PROFILE ec2 describe-regions | jq -r .Regions[].RegionName | fzf -e --height 1% --header 'Select AWS region' --reverse --info=hidden --query (crudini --get ~/.aws/config "profile $AWS_PROFILE" region | cut -c-5) --preview 'aws --profile='$AWS_PROFILE' ssm get-parameter --name /aws/service/global-infrastructure/regions/{}/longName | jq -r .Parameter.Value')
  end

  AWS_PROFILE=$AWS_PROFILE AWS_DEFAULT_REGION=$AWS_DEFAULT_REGION aws ssm get-parameter --name $argv --with-decryption | jq -r .Parameter.Value | xclip -r -selection clipboard
end
