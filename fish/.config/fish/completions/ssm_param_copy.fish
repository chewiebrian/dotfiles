if test -n "$AWS_DEFAULT_REGION";
  set --local CACHE_FILE /tmp/.ssm_param_cache.{$AWS_PROFILE}.{$AWS_DEFAULT_REGION}
  if test ! -f $CACHE_FILE ;
     aws ssm describe-parameters | jq -r .Parameters[].Name > $CACHE_FILE
  end

  set ALL_PARAMS (cat $CACHE_FILE)
else
  set ALL_PARAMS (aws ssm describe-parameters | jq -r .Parameters[].Name)
end

complete -c ssm_param_copy -f -a '$ALL_PARAMS'

