Create table users(
	user_id UUID primary key default gen_random_uuid(),
	full_name VARCHAR(100) not null,
	email VARCHAR(150) unique not null,
	created_at timestamp default current_timestamp
);

Create table wallets (
wallet_id UUID primary key default gen_random_uuid(),
user_id UUID not null,
status VARCHAR(20) default 'ACTIVE',
created_at timestamp default current_timestamp,
constraint fk_wallet_user foreign key(user_id) references users(user_id)
);

Create table accounts (
account_id UUID primary key default gen_random_uuid(),
wallet_id UUID not null,
account_type VARCHAR(30) not null,
created_at timestamp default current_timestamp,
constraint fk_account_wallet foreign key(wallet_id) references wallets(wallet_id)
);

create table balances (
account_id UUID primary key,
current_balance numeric(15,2) not null default 0.00,
updated_at timestamp default current_timestamp,

constraint fk_balance_account foreign key(account_id) references accounts(account_id),
constraint chk_balance_non_negative check(current_balance>=0)
);

create type transaction_type as enum (
'CREDIT',
'DEBIT',
'TRANSFER'
);

Create table transactions (
transaction_id UUID primary key default gen_random_uuid(),
from_account UUID,
to_account UUID,
amount numeric(15,2) not null check(amount >0),
txn_type transaction_type not null,
created_at timestamp default current_timestamp,

constraint fk_txn_from foreign key(from_account) references accounts(account_id),
constraint fk_txn_to foreign key(to_account) references accounts(account_id)
);

CREATE INDEX idx_txn_from_account ON transactions(from_account);
CREATE INDEX idx_txn_to_account ON transactions(to_account);
CREATE INDEX idx_txn_created_at ON transactions(created_at);


Create or replace function prevent_transaction_delete()
returns trigger as $$ 
begin  
	raise exception 'Transactions cannot be deleted';
END;
$$ language plpgsql;

create trigger trg_no_delete_transactions
before delete on transactions
for each row
execute function prevent_transaction_delete();

