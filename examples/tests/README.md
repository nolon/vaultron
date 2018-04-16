# TESTS

NOTE: These are **NOT** code quality unit tests for Vaultron itself; they're just shell scripts for assisting in the automated testing of certain conditions in Vault.

Here's what they are and what they do:

- `$ ./app_rulez N`
  - This will build an entire AppRole auth method mount and role, then issue N number of tokens against the role.
