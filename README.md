# wkhtmltopdf-service
Yet another web app providing an interface to the awesome wkhtmltopdf binary.

This project is meant for my own projects that rely on `wkhtmltopdf`.  I'm trying
to dockerize my apps, and this will be very handy in doing that!

The hardest part about this is getting the fonts correct.

If you can't use this image directly, hopefully the `Dockerfile` can guide you
most of the way.

| :warning: WARNING          |
|:---------------------------|
| This is **NOT** tested with large HTML input!  The process of running `wkhtmltopdf` is _synchronous_, and the result is passed through `stdout`.  Surely things will go awry if you use this on large amounts of HTML without making modifications to the app |

## Requirements
This project is meant to be ran in a docker container.  However, you can run it locally if you want.
*   You must have `wkhtmltopdf` in your path
*   Your Python environment must have:
    * starlette
    * aiofiles
*   You must have some kind of `awsgi` runner (I'm using `uvicorn`)
*   Copy [src/app.py](app.py) to your environment

Your environment will need to have certain fonts installed if you want a one-to-one conversion of the HTML.  The docker image provided only includes the fonts that I'm using in other projects.  See the `wkhtmltopdf` documentation for font usage.

If you're OK with how the docker image is set up, you can just run the container:

    docker run --rm -p 8080:8080 mtik00/wkhtmltopdf-service:latest

and be done with it.

## Releasing

1. Use `poetry` to bump a version.  For example:  
    ```
    poetry version minor
    ```
2.  Modify `CHANGELOG.md` accordingly
3.  Add the changed files  
    ```
    git add pyproject.toml CHANGELOG.md && \
    git ci -m"bumping version"
    ```
4.  Create the tag  
    ```
    git tag v$(poetry version -s)
    ```
5.  Push the new code/tags:  
    ```
    git push && git push --tags
    ```
6.  Push the new image:  
    ```
    make VERSION=$(poetry version -s) push
    ```
