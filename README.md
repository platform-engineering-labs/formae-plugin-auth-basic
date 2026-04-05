# formae-plugin-auth-basic

HTTP Basic Authentication plugin for [formae](https://github.com/platform-engineering-labs/formae).

## Overview

This plugin provides HTTP Basic Authentication for the formae agent API. It runs as an external binary process, communicating with the agent and CLI via `net/rpc` over stdin/stdout. The agent validates incoming requests against a list of authorized users with bcrypt-hashed passwords. The CLI attaches credentials to outgoing requests.

## Installation

```bash
make install
```

This builds the binary and installs it to `~/.pel/formae/plugins/auth-basic/v0.1.0/`.

## Configuration

Authentication is configured separately for the agent and CLI in your `formae.conf.pkl`:

**Agent** (server-side — validates incoming requests):

```pkl
agent {
    auth {
        type = "auth-basic"
        authorizedUsers = new Listing {
            new Mapping {
                ["Username"] = "admin"
                ["Password"] = "<bcrypt hash>"
            }
        }
    }
}
```

**CLI** (client-side — sends credentials with requests):

```pkl
cli {
    auth {
        type = "auth-basic"
        username = "admin"
        password = "your-password"
    }
}
```

Generate a bcrypt hash:

```bash
htpasswd -bnBC 10 "" your-password | tr -d ':\n'
```

## License

FSL-1.1-ALv2 — see [LICENSE](LICENSE) for details.
