###
# Rocky Linux 9 removes compatibility for OpenSSL 1.0, which GrADS requires.
###
FROM rockylinux:8 AS base

###
# Update and upgrade dependencies.
###
RUN yum -y update && yum -y upgrade
# Install GrADS requirements.
RUN yum -y install compat-openssl10 cairo libpng15 libSM


###
# Install GrADS.
# http://cola.gmu.edu/grads/downloads.php
###
WORKDIR /tmp

# Install GrADS core.
RUN curl 'http://cola.gmu.edu/grads/2.2/grads-2.2.0-bin-rhel6.4-x86_64.tar.gz' > grads.tar.gz
RUN tar xzvf grads.tar.gz
RUN mkdir /usr/local/lib/grads
RUN mv grads-2.2.0/lib/* /usr/local/lib/grads/
RUN mv grads-2.2.0/bin/* /usr/local/bin/

# Install GrADS supplemental.
RUN curl 'http://cola.gmu.edu/grads/data2.tar.gz' > grads-supplemental.tar.gz
RUN tar xzvf grads-supplemental.tar.gz -C /usr/local/lib/grads/

# Install GrADS sample data
RUN curl 'http://cola.gmu.edu/grads/example.tar.gz' > grads-sample.tar.gz
RUN mkdir /usr/src/app
RUN tar xzvf grads-sample.tar.gz -C /usr/src/app/

# Clean up tmp files.
RUN rm -fr grads*

###
# Copy user-defined plugin table config.
###
WORKDIR /usr/local/lib/grads

COPY udpt .

###
# Optionally, run GrADS as part of starting the container (less flexible, since CMD is tied to build).
###
WORKDIR /usr/src/app

# http://cola.gmu.edu/grads/gadoc/start.html
# CMD ["grads", "-bl"]
# CMD ["grads", "-l"]
