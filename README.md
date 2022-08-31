# mdformat-action

[Custom action](https://docs.github.com/en//actions/creating-actions/about-custom-actions) for linting markdown files using [mdformat](https://github.com/executablebooks/mdformat).

## Usage

Add the following workflow file to run the action:

```yaml
# .github/workflows/mdformat.yml
name: Mdformat Action
on:
  - pull_request
jobs:
  mdformat:
    name: Mdformat Action
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Mdformat Action
        uses: ydah/mdformat-action@main
        with:
          number: true
        env:
          GITHUB_ACCESS_TOKEN: ${{ secrets.GITHUB_TOKEN }}
```

## Inputs

### `file_or_dir`

- File or Directory to do mdformat on.
- default: `.`
- optional

### `number`

- Apply consecutive numbering to ordered lists.
- default: `false`
- optional

### `wrap`

- Paragraph word wrap mode.
  - keep
  - no
  - INTEGER
- default: `keep`
- optional

### `end_of_line`

- Output file line ending mode.
  - lf
  - crlf
  - keep
- default: `lf`
- optional
