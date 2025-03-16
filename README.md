# Web-Hosting-Rocker-Container-Nginx-Proxy
This is a sample of a webpage launchable with [Rocker](https://rocker-project.org/images/versioned/shiny.html). [Rocker](https://rocker-project.org/images/versioned/shiny.html) makes it easy to deploy executables on a server host using [R language](https://cran.rstudio.org/) dependencies to create beautiful applications using the language. In particular, this application makes use of [R Shiny](https://shiny.posit.co/r/getstarted/shiny-basics/lesson1/).

You may read about the summarized documentation of Docker here:
https://github.com/kandrsn99/Web-Hosting-Rocker-Nginx-Proxy/blob/main/Docker%20Command%20Line%20Interface.pdf

It shall be noted here you will need to install the Docker Engine on your local machine. You may do this through the instructions on the following webpage: https://docs.docker.com/engine/install/

In order to install this repository from the command line you will need to get the 'git' package on your linux machine.

Any Operating System utilizing 'APT' package manager
> sudo apt-get git

Any Operating System utilizing 'YUM' package manager
> sudo yum install git

Any Operating System utilizing 'DNF' package manager
> sudo dnf install git

Next, utilize the git function on your local machine command line interface to download this repository.
> git clone https://github.com/kandrsn99/Web-Hosting-Rocker-Nginx-Proxy.git

Subsequently, change into the directory containing your downloaded repository. 
> cd 'name of file-path'

Upon entering the directory. The docker compose file should allow you to build the html web-page.
> docker compose build

> docker compose up -d

You may check your application via web hosting service on http://localhost:80/ or the server address on http://address:80/

You may purchase a domain name server (DNS) register to point to your new hosts internet protocol (IP) address. Upon completion of pointing a DNS at the host you may use http://dominame name to send to all your friends and/or customers. The customized domain name may be added if you read about the official NGINX docker image documentation here https://hub.docker.com/_/nginx/ which was modified for this repository.

Do note that you must retrieve an SSL (secure socket layer) certificate to have HTTPs working for your domain name. The NGINX configuration file is meant to be easy to follow and understand. Read it and make sure the certificates are stored in the correct locations with the proper naming schema for NGINX. An easy way to create SSL certificate may be done with openSSL, https://openssl.org/, from the command line or otherwise downloaded from the DNS provider. 

It is highly recommended that you use Cloudflare as they are the leading provider of a register for hosting a DNS. You may review their documentation here https://developers.cloudflare.com/learning-paths/get-started/ at your leisure.
