# Use Ubuntu as the base image
FROM ubuntu:latest


# Install Nginx
RUN apt-get update && apt-get install -y nginx && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Create a directory for the file
WORKDIR /usr/share/nginx/html

# Copy the "helloworld" file into the container
COPY helloworld /usr/share/nginx/html/helloworld

# Expose Nginx default port
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
