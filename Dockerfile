FROM modulator:latest

MAINTAINER Fenglin Chen <f73chen@uwaterloo.ca>

# packages should already be set up in modulator:latest
USER root

# move in the yaml to build modulefiles from
COPY rsem_recipe.yaml /modulator/code/gsi/recipe.yaml

# build the modules and set folder & file permissions
RUN ./build-local-code /modulator/code/gsi/recipe.yaml --initsh /usr/share/modules/init/sh --output /modules && \
	find /modules -type d -exec chmod 777 {} \; && \
	find /modules -type f -exec chmod 777 {} \;

# add the user
RUN groupadd -r -g 1000 ubuntu && useradd -r -g ubuntu -u 1000 ubuntu
USER ubuntu

# copy the setup file to load the modules at startup
COPY .bashrc /home/ubuntu/.bashrc

# set environment paths for modules
#ENV RSEM_ROOT="/modules/gsi/modulator/sw/Ubuntu18.04/rsem-1.3.3"
#ENV BOWTIE_ROOT="/modules/gsi/modulator/sw/Ubuntu18.04/bowtie-1.2.2"
#ENV PYTHON_ROOT="/modules/gsi/modulator/sw/Ubuntu18.04/python-3.6"
#ENV RSTATS_CAIRO_ROOT="/modules/gsi/modulator/sw/Ubuntu18.04/rstats-cairo-3.6"
#ENV JAVA_ROOT="/modules/gsi/modulator/sw/Ubuntu18.04/java-8"
#ENV BIOCONDUCTOR_ROOT="/modules/gsi/modulator/sw/Ubuntu18.04/bioconductor-3.8-rstats3.6"
#ENV RSTATS_ROOT="/modules/gsi/modulator/sw/Ubuntu18.04/rstats-3.6"
#ENV PERL_ROOT="/modules/gsi/modulator/sw/Ubuntu18.04/perl-5.30"

#ENV PATH="/modules/gsi/modulator/sw/Ubuntu18.04/rsem-1.3.3/bin:/modules/gsi/modulator/sw/Ubuntu18.04/bowtie-1.2.2/bin:/modules/gsi/modulator/sw/Ubuntu18.04/python-3.6/bin:/modules/gsi/modulator/sw/Ubuntu18.04/rstats-cairo-3.6/bin:/modules/gsi/modulator/sw/Ubuntu18.04/java-8/bin:/modules/gsi/modulator/sw/Ubuntu18.04/rstats-3.6/bin:/modules/gsi/modulator/sw/Ubuntu18.04/perl-5.30/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
#ENV MANPATH="/modules/gsi/modulator/sw/Ubuntu18.04/python-3.6/share/man:/modules/gsi/modulator/sw/Ubuntu18.04/rstats-cairo-3.6/share/man:/modules/gsi/modulator/sw/Ubuntu18.04/java-8/man:/modules/gsi/modulator/sw/Ubuntu18.04/rstats-3.6/share/man:/modules/gsi/modulator/sw/Ubuntu18.04/perl-5.30/share/man"
#ENV LD_LIBRARY_PATH="/modules/gsi/modulator/sw/Ubuntu18.04/python-3.6/lib:/modules/gsi/modulator/sw/Ubuntu18.04/rstats-cairo-3.6/lib:/modules/gsi/modulator/sw/Ubuntu18.04/java-8/lib:/modules/gsi/modulator/sw/Ubuntu18.04/bioconductor-3.8-rstats3.6/lib:/modules/gsi/modulator/sw/Ubuntu18.04/rstats-3.6/lib:/modules/gsi/modulator/sw/Ubuntu18.04/perl-5.30/lib"
#ENV R_LIBS_SITE="/modules/gsi/modulator/sw/Ubuntu18.04/rstats-cairo-3.6/lib/R/library:/modules/gsi/modulator/sw/Ubuntu18.04/bioconductor-3.8-rstats3.6/lib/R/library:/modules/gsi/modulator/sw/Ubuntu18.04/rstats-3.6/lib/R/library"
#ENV PKG_CONFIG_PATH="/modules/gsi/modulator/sw/Ubuntu18.04/python-3.6/lib/pkgconfig"
#ENV PYTHONPATH="/modules/gsi/modulator/sw/Ubuntu18.04/python-3.6/lib/python3.6/site-packages"
#ENV PERL5LIB="/modules/gsi/modulator/sw/Ubuntu18.04/perl-5.30/lib/site_perl"

CMD /bin/bash
