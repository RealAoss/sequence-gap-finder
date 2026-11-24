# Sequence Gap Finder

Identify missing integer ranges between recorded sequence numbers.

## Run

In PowerShell 7+, run `./run.ps1 -InputFile ./example.txt`. Pass `-OutputFile ./result.txt` to save to a new file. Existing output files are protected.

## Example

Integers separated by commas or whitespace. The bundled example output includes:

```text
103–104
```

## Limitations

Input records are read from a UTF-8 text file. Blank lines are skipped.

## Development

See [CONTRIBUTING.md](CONTRIBUTING.md) for checks and [CHANGELOG.md](CHANGELOG.md) for changes.

## License

[MIT License](LICENSE). Copyright (c) 2026 sequence-gap-finder contributors.
