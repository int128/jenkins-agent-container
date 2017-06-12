# Jenkins Agent Container

This is an image of Jenkins Agent for running `docker` and `docker-compose` command.


## How to Use

Run a container with mount `docker` and `docker-compose` command.

```yaml
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

Connect to the container.

Create a job with following Jenkinsfile.

```groovy
node('jenkins-agent') {
  sh 'docker ps'
}
```
