You will need to have Docker Desktop installed and running in order to launch the app.

- [Download Docker Desktop](https://www.docker.com/products/docker-desktop/)

### 1. Working with an existing Docker image

You can pull an existing Docker imaging from Docker Hub Container Image Library using the `docker pull` command:

```
docker pull kai2019/shinyapp_labarchives
```

After pulling the image, you can use `docker run` command to launch the app. Use the `-p 4000:6307` argument:

```
docker run -p 4000:6307 kai2019/shinyapp_labarchives
```

Visit https://localhost:4000 in a web browser to start using the app. To stop the container, hit Ctrl+C.

### 2. Building a new Docker image locally

To build the app locally, first, clone this github repo:

```
git clone https://github.com/sotnir/shinyApp_LabArchives.git
```

Go to the directory, and build the image from the `Dockerfile` by running:

```
cd shinyApp_LabArchives/
docker build -t shinyapp_labarchives .
```

**Note:** Don't forget the `.` at the end which refers to the current directory where the `Dockerfile` resides.

After the image is built, run this command:

```
docker run -p 4000:6307 kai2019/shinyapp_labarchives
```

and visit https://localhost:4000 to start using the app.
