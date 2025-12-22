# Getting Started

## Welcome to Galactic Spacefarer Adventure.

To see the magic, simply run `cds watch` in the terminal.

For test authentication, mocked users are defined in the `package.json`. mockadmin has priviliges for all CRUD operations, other mocked users can only `READ` & `UPDATE` (with some restrictions, as per client requested). Now the SQLite data is stored in memory. When in PROD, **NEVER** store any sensitive data (like credentials) in `package.json` (or any other, non-git-ignored file). Use Vault/`.env` instead!

Whenever a new Spacefarer is created, an e-mail is being sent to him/her.
**Please note**, that the transport host is ethereal, the e-mail will **NOT** be actually sent to the addressee. For PROD, an actual user/pw is needed to be requested with a valid API key.

User profile (username/pw):

1. ADMIN (authorized to all CRUD operations): *mockadmin* / *p0*
2. Planet-X user: *mock2* / *p2*
3. Planet-Y user: *mock1* / *p1*
4. Planet-Z user: *mock3* / *p3*
