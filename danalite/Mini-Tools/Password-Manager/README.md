### Generate a new GPG key
- `pass`: https://www.passwordstore.org/

- Install `pass` and initialize it with `pass init <gpg-id>`. You can find your `gpg-id` with `gpg --list-keys`.

- Add a new GPG key to your keyring with `gpg --import <key-file>`. You can find your key-file in your password manager.

```bash
# Generate a new GPG key
gpg --full-generate-key

# List all GPG keys in the system
gpg --list-keys

# Use the GPG-ID you created in the first step
pass init <gpg-id>
```
```