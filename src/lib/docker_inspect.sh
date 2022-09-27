docker_inspect() {
  container_ids=$(docker ps -q)
  [[ $(echo -n "${container_ids}" | wc -l | tr -d ' ') == 0 ]] && { 
    echo '[]'
    return
  }

  docker inspect ${container_ids}
}