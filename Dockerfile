FROM python:3.10-bullseye
RUN apt-get update
RUN apt-get upgrade -y
RUN pip install --upgrade pip
RUN pip install mdformat mdformat-gfm mdformat-frontmatter mdformat-footnote
RUN ["bin/sh", "-c", "mkdir -p /src"]
COPY ["src", "/src/"]
ENTRYPOINT ["/src/entrypoint.sh"]
