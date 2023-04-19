# r-image-creator
Github Action to create R-based Docker images


# action inputs description 

- image-name: Name of the docker image that will be deployed by this action. required
- tag: Docker image tag (the deployed image will be then image-name:tag) - by default the tag will be the current date (format YYYY.MM.DD)
- tag-latest: boolean (default false) (if set to True, the deployed image will be tagged as latest)
- base-image: Base image to use to build the docker image
- sysdeps: comma separated list of debian sys dependencies to install 
- renv-lock-file: path to renv.lock file, or url of renv.lock file to download
- packages: comma separated list of R packages to install (source repositories can be specified with the input "repos" specified bellow)
- repos: source repositories for R dependencies
    
# possible improvments 

- deal with distribs other than debian
- push to other CR than github container registry 
