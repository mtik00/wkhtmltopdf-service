# wkhtmltopdf-service
Yet another web app providing an interface to the awesome wkhtmltopdf binary.

This project is meant for my own projects that rely on `wkhtmltopdf`.  I'm trying
to dockerize my apps, and this will be very handy in doing that!

The hardest part about this is getting the fonts correct.

If you can't use this image directly, hopefully the `Dockerfile` can guide you
most of the way.

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
