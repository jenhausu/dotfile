---
name: lokalise-create-keys
description: Create Lokalise iOS translation keys (strings) by calling scripts/lokalise_create_keys.sh
argument-hint: "[key_name] [lang_iso=text ...] [--tag tag ...]"
disable-model-invocation: true
allowed-tools: Bash
---

Create Lokalise translation keys for this repository by calling `scripts/lokalise_create_keys.sh`.

This skill has side effects (it creates keys in Lokalise), so it is **manual-only** (`disable-model-invocation: true`). Invoke it explicitly as `/lokalise-create-keys ...`.

## Repo defaults

The script `scripts/lokalise_create_keys.sh` enforces:

- branch: `master`
- platform: `ios`
- filename mapping: `UIMessage.strings`

It reads `Project ID` and `API Token` from:
`Packages/CHFDomain/Sources/CHFAutoUpdateLocalizationManager/Resources/iCHEF-LocalizationManager.plist`

Never print or paste the API token.

## Inputs

Required:

- key name
- ONE translation pair only (single source language): `language_iso=text`

Optional:

- tags (repeatable)
- description

## How to run

If arguments are provided, interpret them like this:

- First token: key name
- Remaining tokens containing `=`: translations (`language_iso=text`)
- Remaining tokens prefixed with `tag:`: tags

If the user wants batch creation, ask them to provide JSON and use `--stdin`.

After the key is created successfully, ask the user whether to update the project code to use the new key.

- Offer: replace the literal UI text with `localizeUI("<key_name>")`.
- Do not modify code unless the user confirms.

### Example (single key)

```bash
scripts/lokalise_create_keys.sh \
  --key-name "$0" \
  --translation "zh_TW=..." \
  --tag onboarding
```

### Example (batch)

```bash
cat <<'JSON' | scripts/lokalise_create_keys.sh --stdin
{
  "keys": [
    {
      "key_name": "example_key",
      "platforms": ["ios"],
      "filenames": {"ios": "UIMessage.strings"},
      "tags": ["example"],
      "translations": [
        {"language_iso": "zh_TW", "translation": "..."}
      ]
    }
  ]
}
JSON
```
