# git-open

Open files in a repository in the browser.

You can specify directories and files, and files with line numbers. A branch
can also be supplied.

## Usage

Open the root of the repository in the browser:
```bash
git open
```

Open a file in the browser:
```bash
git open README.md
```

Open a file with a line number in the browser:
```bash
git open README.md:10
```

## Install git-open

```bash
git clone https://github.com/takac/git-open

cd git-open
# Copy to a place on your $PATH
cp git-open /usr/local/bin
```

