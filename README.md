# DXR Cyber weekly forecast (password-gated)

The published `index.html` is an AES-256-GCM password gate. The page inside it is built from
live Salesforce data, so the readable source (`src/`) and data (`data/`) are never committed.

To refresh and publish: `./publish.sh` (asks for the password, pulls fresh numbers read-only,
rebuilds, encrypts, commits and pushes).
