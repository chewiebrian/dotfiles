function sslcheck --description "Run the docker image drwetter/testssl.sh against host"
  docker run --rm -ti  drwetter/testssl.sh $argv
end
