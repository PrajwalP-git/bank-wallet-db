# Banking / Wallet Management System #

A PostgreSQL-based transactional wallet system implementing ACID-compliant money transfers and database-level integrity enforcement.

# Features #
- UUID-based accounts
- Atomic money transfers using BEGIN / COMMIT
- Row-level locking to prevent double spending
- Immutable transaction ledger
- Negative balance prevention using triggers

# How to Run #
1. Create a PostgreSQL database
2. Run:

psql Banking_manager -f sql/Banking_manager.sql
psql Banking_manager -f sql/transactions(bank_manager).sql
psql Banking_manager -f sql/triggers(banking_manager).sql

# What this db project demonstrates #
This project demonstrates how real financial systems maintain consistency, integrity, and auditability at the database level.
