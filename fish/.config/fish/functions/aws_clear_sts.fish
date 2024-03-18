function aws_clear_sts
  crudini --get "$HOME/.aws/credentials" | grep arn:aws:sts | xargs -I '{}' crudini --del "$HOME/.aws/credentials" '{}'
end
