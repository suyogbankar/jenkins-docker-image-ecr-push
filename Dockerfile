FROM nginx:latest

#Remove the default site config if you want to fully replace it
RUN rm/etc/nginx/conf.d/default/default.conf

#Copy website content
COPY content/ /user/share/nginx/html/

#Copy custome nginx configuration file
COPY conf/ /etc/nginx/