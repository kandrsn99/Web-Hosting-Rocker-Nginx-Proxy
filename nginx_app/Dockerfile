# Pull latest image of NGINX
FROM nginx:latest
# Copy NGINX configuration
COPY ./configuration/nginx/nginx.conf /etc/nginx/nginx.conf
# Copy SSL configuration
COPY ./configuration/certification /etc/nginx/ssl
# Expose the proper ports
EXPOSE 80
EXPOSE 443
