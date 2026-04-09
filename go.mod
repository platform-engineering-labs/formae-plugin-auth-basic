module github.com/platform-engineering-labs/formae-plugin-auth-basic

go 1.25

toolchain go1.25.1

require (
	github.com/platform-engineering-labs/formae/pkg/auth v0.1.0
	golang.org/x/crypto v0.47.0
)

replace github.com/platform-engineering-labs/formae/pkg/auth => /home/jeroen/dev/pel/formae/.worktrees/extensions/pkg/auth
