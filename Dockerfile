FROM python:3.13-bookworm
RUN pip install --upgrade pip
RUN pip install mdformat mdformat-gfm mdformat-frontmatter mdformat-footnote mdformat-tables
RUN ["bin/sh", "-c", "mkdir -p /src"]
COPY ["src", "/src/"]
ENTRYPOINT ["/src/entrypoint.sh"]
