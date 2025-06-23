# MRI Radiomics Explorer
## to run
We build specifically on a linux platform since otherwise the particular Shiny package may not be available.
docker build --platform linux/amd64 -t mri-explorer .
* --platform linux/amd64 ensures that the correct version of shiny is available
* -t mri-explorer names the image (t = target)
* . is the current context

docker run --platform linux/amd64 --rm \
  -p 3838:3838 \
  -v "$(pwd)/data/processed":/srv/app/data/processed \
  mri-explorer
* --platform linux/amd64 ensures that the file is running on the same platform as it was built
* --rm will automatically remove the container when it exists
* -p 3838:3838 port binds
* -v for volumes to bind-mount
* mri-explorer is the name of the container to run

open http://localhost:3838 in browser
