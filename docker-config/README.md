# GeoDevelopers with docker

1. First you need to install docker on your machine: [Mac OS X](https://docs.docker.com/engine/installation/mac/), [Windows](https://docs.docker.com/engine/installation/windows/) or [Linux](https://docs.docker.com/engine/installation/#on-linux)
2. Test that you have docker-compose running: `docker-compose --version`. If it doesn't work try to open the [**Quickstart terminal**](https://www.google.es/webhp?ion=1&espv=2&ie=UTF-8#q=docker%20quickstart%20terminal)
3. Then you need open a terminal (CMD on Windows) and to go to this directory (*docker-config*) and run: `docker-compose up -d`

> **Informative note**: when this command finish you will have installed and running:
* An instance of Mysql ready to use at port 9876 (user//pass: root/1234)
* An instance of PhpMyAdmin ready on port 8080
* An instance of Apache configured and ready to use on port 80

At this point you will need to:

1. Run `composer install` if you haven't done it yet in the root folder <br>
**Note**: if you don't have composer installed you can do it from the container running:
  
  1.1. `docker exec -it server bash` (this command is used to enter to the virtual container)

  1.2. And then `cd /var/www/html/ && composer install && mkdir /var/www/html/smarty/templates_c && chmod 777 /var/www/html/smarty/templates_c` (this will install all the PHP depedencies)
  
  1.3 Run: `exit`
  
2. Load the [DB schema](../install/database.sql) to your Mysql (you can use PhpMyAdmin)
3. Setup you config.php settings (you can just rename `/config.php.sample.php` file from the root folder to `/config.php`)

## First time using docker?

You will find some useful commands here.

If you are running docker on Windows or Mac and you need to know the IP of
the docker container that is running the website you can run `docker-machine ls`. This will return something like this:
````
NAME      ACTIVE   DRIVER       STATE     URL                         SWARM   DOCKER    ERRORS
default   *        virtualbox   Running   tcp://192.168.99.100:2376           v1.11.1
dev       -        virtualbox   Stopped                                       Unknown
```
Then you can access to it at port &lt;ip-address&gt;:80 over HTTP, in this case to: http://192.168.99.100:80

---

**About DockerUI**: This tool is also very useful when you are learning who docker works:
`docker run -d -p 9000:9000 --privileged -v //var/run/docker.sock:/var/run/docker.sock --name=dockerui kevan/dockerui`

It allows you to monitor your resources, containers, images, volumnes, etc.

## Troubleshooting

* What to do when you Docker machine cant connect with the proper IP `Docker machine status timeout`:

	1. Delete our virtual machine (named dev in this case):

	  * `docker-machine rm dev`

	2. Create a new virutal machine
	  
	  * `docker-machine create --driver virtualbox dev`
	  
	3. Set the enviroments

	  * `docker-machine env dev`
	  * `eval $(docker-machine env dev)`
	  
	4. Compose up the containers and set up the network
	  
	  * `docker-compose up -d`

	5. Run `docker-machine ls` to know our virtual machine IP

## Get ready for deployment

** Pending**
