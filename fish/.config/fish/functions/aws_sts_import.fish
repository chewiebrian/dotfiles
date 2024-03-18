function aws_sts_import
  set --local files (find . $HOME/Descargas $HOME/Downloads -maxdepth 1 -name "aws_sts*" 2>/dev/null)
  
  if test (count $files) -gt 1;
    set --global filetoload (find . $HOME/Descargas $HOME/Downloads -maxdepth 1 -name "aws_sts*" 2>/dev/null | fzf --height 1% --header 'Select file to load' --reverse --info=hidden)
  else 
    set --global filetoload $files
  end

  if test -z "$filetoload"; 
    return
  end

  echo Will load STS token from $filetoload

  set --local profile (crudini --get "$filetoload")
  aws_clear_sts

  cat "$filetoload" >> $HOME/.aws/credentials

  export AWS_PROFILE=$profile
  export AWS_DEFAULT_REGION=eu-central-1
  export AWS_DEFAULT_REGION=(aws ec2 describe-regions | jq -r .Regions[].RegionName | fzf -e --height 1% --header 'Select AWS region' --reverse --info=hidden --query $AWS_DEFAULT_REGION --preview 'aws ssm get-parameter --name /aws/service/global-infrastructure/regions/{}/longName | jq -r .Parameter.Value')

  rm "$filetoload"
end
