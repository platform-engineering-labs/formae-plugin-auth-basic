# formae-plugin-auth-basic

HTTP Basic Authentication plugin for [formae](https://github.com/platform-engineering-labs/formae).

## Overview

This plugin provides HTTP Basic Authentication for the formae agent API. It runs as an external binary process, communicating with the agent and CLI via `net/rpc` over stdin/stdout. The agent validates incoming requests against a list of authorized users with bcrypt-hashed passwords. The CLI attaches credentials to outgoing requests.

## Configuration

Authentication is configured separately for the agent and CLI in your `formae.conf.pkl`,
using the typed config classes the plugin exposes via `plugins:/AuthBasic.pkl`.

**Agent** (server-side — validates incoming requests against bcrypt-hashed passwords):

```pkl
amends "formae:/Config.pkl"

import "plugins:/AuthBasic.pkl" as AuthBasic

agent {
    auth = new AuthBasic.AgentConfig {
        authorizedUsers {
            new AuthBasic.AuthorizedUser {
                username = "admin"
                password = "<bcrypt hash>"
            }
        }
    }
}
```

**CLI** (client-side — sends credentials with requests):

```pkl
amends "formae:/Config.pkl"

import "plugins:/AuthBasic.pkl" as AuthBasic

cli {
    auth = new AuthBasic.CliConfig {
        username = "admin"
        password = "your-password"
    }
}
```

The agent stores a **bcrypt hash** of the password; the CLI sends the **plaintext**
password. Generate the hash with `htpasswd` (the `$2y$` variant is compatible with the
agent's bcrypt verifier):

```bash
htpasswd -nbBC 10 "" your-password | cut -d: -f2
```

## License

FSL-1.1-ALv2 — see [LICENSE](LICENSE) for details.
