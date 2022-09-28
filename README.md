# dq

A wrapper around Docker and `jq` that allows you to filter running Docker containers.

### Why?

Because I'm lazy and I got tired of writing stuff like this every time I wanted to search for specific containers:

```bash
docker inspect $(docker ps -q) | jq -r '
    [
        .[] 
      | select([.Id] | inside([
          "747c2c92855f88a8e9aa9709dcdf3a01f1677e70bf4c0bf0e520eb38ac502876",
          "2cf70261ef62bc36d19aba02f8ef7b8d7aabfcb1e9f4593a919baa17f80aca5b"
        ]))
      | .Config.Env
    ] 
  | flatten 
  | unique 
  | .[]
'
```

Instead, I can now do the following:

```bash
dq filter '.[].Name[1:]'
```

And get a nice list of containers as a result:

```
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
There are several other built-in canned filtering sub-commands that should make life a bit easier:

```bash
dq older-than 4 months --only-return ips --network pebkac
dq newer-than 2 fortnights --only-return ids
dq filter '.[].Name[1:]'
dq find-by-ip-address 172.17.0.2 --only-return names --network foo

```

You can explore all commands by viewing the [config file](/src/bashly.yml), or by navigating the built-in documentation with the `dq --help` command. 

## Requirements

Before you begin using `dq`, you will need the following installed on your machine:

1. [jq](https://stedolan.github.io/jq/)
2. [Docker](https://docker.com)
3. Bash version 4, or higher.
4. If you're on MacOS, you will need to install `coreutils` for `gdate`. You will not be able to use the `dq (older|newer)-than ...` sub-commands otherwise.

## Installation

The command is completely self-contained in a single Bash script. Drop it in your system's `$PATH` and you're good to go. In the following example, we're saving it directly to `/usr/local/bin/dq`:

```bash
curl -s https://raw.githubusercontent.com/wilhelm-murdoch/dq/main/dq > /usr/local/bin/dq
chmod a+x /usr/local/bin/dq 
```

If all went well, running `dq --help` should give you the following output:
```
dq - A wrapper around Docker and jq that allows you to filter running Docker containers.

Usage:
  dq [command]
  dq [command] --help | -h
  dq --version | -v

Commands:
  filter               Run a free-form jq filter against your local running Docker containers.
  older-than           Return a list of containers older than the given relative time. 
  newer-than           Return a list of containers older than the given relative time.
  find-by-ip-address   Return a list of containers assigned the given IP address.
  names-only           Returns a list of names associated with all running containers.
  ip-addresses-only    Returns a list of IP addresses associated with the specified network.
  env                  Returns a block of sourceable environmental variables associated with the specified container.

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

 - [jq](https://stedolan.github.io/jq/)
 - [Docker](https://docker.com)
 - [Bashly](https://bashly.dannyb.co/)
 - [readme.so](https://readme.so/)

## License

[Unlicense](https://choosealicense.com/licenses/unlicense/)

  