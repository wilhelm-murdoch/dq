docker_inspect() {
  docker inspect $(docker ps -q)
}
