# Jenkins Agent Container

This is an image of Jenkins Agent for running `docker` and `docker-compose` command.


## How to Use

Run a container with mount Docker socket and host commands.

```sh
# Docker
docker build -t jenkins-agent .
docker run -d -e ssh_passwd=jenkins \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v /usr/bin/docker:/usr/bin/docker:ro \
  -v /usr/local/bin/docker-compose:/usr/local/bin/docker-compose:ro \
  jenkins-agent
```

```yaml
# Docker Compose
version: "2"
services:
  jenkins-agent:
    build: jenkins-agent
    environment:
      ssh_passwd: jenkins
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
      - /usr/bin/docker:/usr/bin/docker:ro
      - /usr/local/bin/docker-compose:/usr/local/bin/docker-compose:ro
```

Connect to the container via SSH.

Create a job with following Jenkinsfile.

```groovy
node('jenkins-agent') {
  sh 'docker ps'
}
```
