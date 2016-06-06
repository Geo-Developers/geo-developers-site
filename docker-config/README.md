# GeoDevelopers with docker

1. First you need to install [docker](https://docs.docker.com/engine/installation/) on your machine
2. Then you need open a terminal and to go to this directory (*docker-config*) and run: `docker-compose up -d`

At this point you will have:
* An instance of Mysql ready to use at port 9876 (user//pass: root/1234)
* An instance of PhpMyAdmin ready on port 8080
* An instance of Apache configured and ready to use on port 9090

Now you will need to:
1. Run `composer install` if you haven't done it yet in the root folder<sup>1</sup>
2. Load the [DB schema](../install/database.sql) to your Mysql (you can use PhpMyAdmin)
3. Setup you config.php settings (use [config.php.sample.php](config.php.sample.php) template)

> 1) If you don't have composer installed you can do it from the container running
`docker exec -it server bash` and then `cd /var/www/html/ && composer install`

## First time using docker?

You will find some useful commands here.

If you are running docker on Windows or Mac and you need to know the IP of
the docker container that is running the website you can run `docker-machine ls`.
Then you can access to it at port <ip-address>:9090.

This tool is also very useful when you are learning who docker works:
`docker run -d -p 9000:9000 --privileged -v //var/run/docker.sock:/var/run/docker.sock --name=dockerui kevan/dockerui`

It allows you to monitor your resources, containers, images, volumnes, etc.

## Get ready for deployment

** Pending**
