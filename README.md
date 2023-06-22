<!-- BEGIN_ACTION_DOC -->
# R Image Creator

### Description
Creates R images on demand, given a base R image, a set of system dependencies, an renv lock file or even a set of R packages along with repositories that can be used for installing dependencies.
This action will publish packages exclusively to ghcr.io (Github Container Registry). DockerHub is not supported at the moment.

### Action Type
Composite

### Author
Roche/Genentech - Insights Engineering

### Inputs
* `image-name`:

  _Description_: name of the image that will be stored into ghcr (Note that image full name will be built from the action inputs: `ghcr/repository-owner/image-name:tag`)

  _Required_: `false`

  _Default_: `rocker/rstudio:4.3.0`

* `repository-owner`:

  _Description_: Repository owner. Github variable `${{ github.repository_owner }}` can be used. (This variable is used to build the full name of the image that will be stored in ghcr)

  _Required_: `true`

* `repo-user`:

  _Description_: User name to access project container registry. Github variable `${{ github.actor }}` can be used.

  _Required_: `true`

* `repo-token`:

  _Description_: Token to access project container registry. Github variable `${{ secrets.GITHUB_TOKEN }}` can be used.

  _Required_: `true`

* `tag`:

  _Description_: Custom Image Tag/Version. Defaults to current date in the `YYYY.MM.DD` format if unspecified.


  _Required_: `false`

  _Default_: `""`

* `tag-latest`:

  _Description_: Tag image as `latest`

  _Required_: `false`

  _Default_: `False`

* `base-image`:

  _Description_: Base image

  _Required_: `false`

  _Default_: `rocker/rstudio:4.3.0`

* `sysdeps`:

  _Description_: A list of system dependencies to install on the image.
This should be a comma-separated list of sysdeps.
Eg: 'libxml2,adoptopenjdk-8,tcltk'
Note that the sysdeps name should be OS-specific.
Right now, only Debian OSes (installable via apt) are supported.


  _Required_: `false`

  _Default_: `""`

* `renv-lock-file`:

  _Description_: A location of an renv.lock file that should be restored on the image.
This can also be a remote location (i.e. a GitHub raw URL etc).


  _Required_: `false`

  _Default_: `""`

* `packages`:

  _Description_: A comma-separated list of R packages that should be installed on the image. Dependencies will be fetched from the 'repos' option specified below.
Eg: 'pharmaverse/admiral,pharmaverse/admiralonco,dplyr'


  _Required_: `false`

  _Default_: `""`

* `repos`:

  _Description_: A comma-separated set of R package repository URLs that can be used for getting dependencies for the 'packages' installed.
Eg: 'https://cloud.r-project.org,https://cran.r-project.org'


  _Required_: `false`

  _Default_: `https://cloud.r-project.org`

### Outputs
None
<!-- END_ACTION_DOC -->
