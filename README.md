# formae-plugin-auth-basic

HTTP Basic Authentication plugin for [Formae](https://github.com/platform-engineering-labs/formae).

## Overview

This plugin provides HTTP Basic Authentication for the Formae agent API. It validates incoming requests against a list of authorized users with bcrypt-hashed passwords and provides auth headers for CLI-to-agent communication.

## Installation

```bash
make install
```

## Configuration

Add to your `formae.conf.pkl`:

```pkl
plugins {
    authentication {
        type = "basic"
        username = "admin"
        password = "your-password"
        authorizedUsers {
            new { username = "admin"; password = "<bcrypt hash>" }
        }
    }
}
```

Generate a bcrypt hash:

```bash
htpasswd -bnBC 10 "" your-password | tr -d ':\n'
```

## License

FSL-1.1-ALv2 — see [LICENSE](LICENSE) for details.
