# Jupyter Notebook/Lab jkernel Docker-Image

Originally forked from **martinsaurer/jlang:jkernel** then rewritten such that the Dockerfile has all the components necessary to run in binder

Then forked from **joebo/jkernel-docker**

The change here is that the package manager addons are placed into the J runtime

This introduced some minor problems. The initial launch hangs but creates the correct image. subsequent launches use the cached
image and brings up the Binder environment with a JKernel available to use. 

The package manager addition adds everything including JQt I will investigate how to do a more Jupyter specific installation of 
addons in the future

[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/tmcguirefl/jkernel-docker.git/HEAD)
