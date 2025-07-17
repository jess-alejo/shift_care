# Client Directory CLI

**ShiftCare Technical Challenge**: A command-line Ruby application to search through a list of clients loaded from a file. It supports:

- Searching clients by name
- Finding duplicate emails
- Pluggable support for JSON, CSV and XML data sources

## Setup Instructions

1. **Install Ruby**:
   Ensure Ruby (version 3.0 or higher) is installed:

   ```bash
   ruby -v
   ```

2. **Clone the Repository**:

   ```bash
    git clone https://github.com/jess-alejo/shift_care.git
    cd shift_care
   ```

3. **Add you client data**: Put your data file (e.g., `clients.json`) inside the `data/` directory. A sample JSON is provided.

4. **Run the application**:
   ```bash
   ruby main.rb search <query>
   ruby main.rb duplicates
   ```

## Usage Examples

Search for a name (case-insensitive):

```bash
ruby main.rb search jane
```

Find duplicate email entries:

```bash
ruby main.rb duplicates
```

## Project Structure

```
shift_care/
├── data/
│  └── clients.json # Sample dataset
├── lib/
│  ├── builders/
│  │  ├── json_builder.rb
│  │  ├── csv_builder.rb
│  │  └── xml_builder.rb
│  ├── client.rb
│  ├── data_loader.rb
│  ├── client_search.rb
│  ├── duplicate_checker.rb
│  └── display.rb
├── spec/
│  ├── builders/
│  │  └── json_builder_spec.rb
│  └── spec_helper.rb
├── .rspec
├── Gemfile
├── Gemfile.lock
├── main.rb # Main entry point
└── README.md
```

## Assumptions and Decision Made

- The dataset is small enough to be loaded entirely in memory.
- Email is treated as a unique identifier when checking for duplicates.
- Builder classes follow a common `#build` interface for extensibility.
- JSON is the default supported format; others are pluggable.
- Output formatting is handled by a separate display class (`Display`) for maintainability.
- Default screen width is 60 characters. It can be overridden using `--screen-width=[WIDTH]` flag.
  ```bash
  ruby main.rb search jane --screen-width=80
  ```

## Known Limitations

- No support for nested or deeply structured data in JSON
- No input validation for malformed files or fields.
- All operations are linear and in-memory; not suitable for huge datasets.
- Currently no filtering on fields other than `full_name`.

## Areas for Future Enhancements

- Add interactive mode (menu-style)
- Support search by other fields (e.g., email, ID).
- Support XML and CSV data types.
- Enable passing a custom data file path via CLI flag. (e.g., `--filter=data/clients.csv`)
- Export results to file (e.g., CSV or JSON)
