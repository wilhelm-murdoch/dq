# dq

A wrapper around Docker and jq that allows you to filter running Docker containers.

### Why?

Because I'm lazy and I got tired of writing stuff like this every time I wanted to search for specific containers:

```bash
    $ docker inspect $(docker ps -q) | jq -r '.[] | select(.NetworkSettings.Networks.bridge.IPAddress = 127.0.0.1) | .Id'
    2ec5eb5569c3b9ba2def63717c48b0b38936a528f71fab6292b5cdc03166a77c
```

Instead, I can now do the following:

```bash
    $ dq filter '.[].Name[1:]'
    awesome_snyder
    priceless_allen
    nifty_williamson
    condescending_tharp
    romantic_tereshkova
    angry_hellman
    intelligent_sinoussi
    busy_kilby
    clever_almeida
    musing_kepler
    nice_pasteur
```

The `dq common` sub-command contains frequently-used search patterns:

```bash
    $ dq common find-by-ip-address 127.0.0.1 --return-ids-only
    2ec5eb5569c3b9ba2def63717c48b0b38936a528f71fab6292b5cdc03166a77c
```

Same with searching for containers that are older than `x`:

```bash
    $ dq common older-than 7 days --return-ids-only
    2ec5eb5569c3b9ba2def63717c48b0b38936a528f71fab6292b5cdc03166a77c
```

You can explore all commands by viewing the [config file](/src/bashly.yml), or by navigating the built-in documentation with the `dq --help` command. 


## Installation

The command is completely self-contained in a single Bash script. Drop it in your system's `$PATH` and you're good to go. In the following example, we're saving it directly to `/usr/local/bin/dq`:

```bash
    $ curl -s https://raw.githubusercontent.com/wilhelm-murdoch/dq/main/dq > /usr/local/bin/dq
    $ chmod a+x /usr/local/bin/dq 
    $ dq --help
    dq - A wrapper around Docker and jq that allows you to filter running Docker containers.

    Usage:
    dq [command]
    dq [command] --help | -h
    dq --version | -v

    Commands:
    filter   Run a free-form jq filter against your local running Docker containers.
    common   A list of commonly-used and convenient filters.

    Options:
    --help, -h
        Show this help

    --version, -v
        Show version number
```
    
## Building & Contributing

This tool is written in Bash, but built with [Bashly](https://bashly.dannyb.co/). Perform the following steps to begin developing locally:

1. Install Bashly locally with `gem install bashly`.
2. Clone this repository with `git@github.com:wilhelm-murdoch/dq.git`.
3. Modify the tool's command configuration in `src/bashly.yml`.
4. Run `bashly g` from the root of this project to stub out any new commands or update any help documentation.
5. Start coding your new command from the stubbed Bash script in `src/*_command.sh`.
6. Run `bashly g` every time you wish to test your progress as Bashly consolidates all changes to the `dq` script located at the root of this project.

Contributions are always welcome. Just create a PR and remember to be nice.
## Acknowledgements

This stupid little tool couldn't be possible without the following projects:

 - [jq](https://awesomeopensource.com/project/elangosundar/awesome-README-templates)
 - [Docker](https://github.com/matiassingers/awesome-readme)
 - [Bashly](https://bulldogjob.com/news/449-how-to-write-a-good-readme-for-your-github-project)
 - [readme.so](https://readme.so/)

## License

[Unlicense](https://choosealicense.com/licenses/unlicense/)

  