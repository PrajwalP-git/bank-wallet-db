Select * from users;

select 
	u.full_name,
	a.account_id,
	b.current_balance
From users u
join wallets w on u.user_id = w.user_id
join accounts a on w.wallet_id = a.wallet_id
join balances b on a.account_id = b.account_id;

select 
	u.full_name,
	a.account_id:: text as account_id,
	b.current_balance
From users u
join wallets w on u.user_id = w.user_id
join accounts a on w.wallet_id = a.wallet_id
join balances b on a.account_id = b.account_id;


begin;

select * from balances
where account_id IN ('018f7d74-7c5f-421d-8df0-9823a88becf3',
					'66831401-bbc0-4582-9d1c-61910b9d7728')
for update;

update balances
set current_balance = current_balance - 200
where account_id = '018f7d74-7c5f-421d-8df0-9823a88becf3';

update balances
set current_balance = current_balance + 200
where account_id = '66831401-bbc0-4582-9d1c-61910b9d7728';


select * from accounts;
select * from transactions;
select * from balances;

select column_name, data_type
from information_schema.columns
where table_name = 'transactions';

alter table transactions
add column from_account_id UUID,
add column to_account_id UUID;

alter table transactions
add constraint fk_from_account
foreign key(from_account_id) references accounts(account_id);

alter table transactions
add constraint fk_to_account
foreign key(to_account_id) references accounts(account_id);

Insert into transactions(from_account_id, to_account_id, amount, txn_type) values
('66831401-bbc0-4582-9d1c-61910b9d7728', 
'3dd55d16-878d-411e-a22b-7fd7f6643c26', 200,
'TRANSFER');

select * from transactions;

update balances
set current_balance = current_balance + 200
where account_id = '018f7d74-7c5f-421d-8df0-9823a88becf3';
update balances
set current_balance = current_balance - 200
where account_id = '66831401-bbc0-4582-9d1c-61910b9d7728';

select * from balances;

Begin;

update balances
set current_balance = current_balance - 200
where account_id = '66831401-bbc0-4582-9d1c-61910b9d7728';

update balances
set current_balance = current_balance + 200
where account_id = '018f7d74-7c5f-421d-8df0-9823a88becf3';

Insert into transactions (from_account_id, to_account_id, amount, txn_type)
values
('66831401-bbc0-4582-9d1c-61910b9d7728',
'018f7d74-7c5f-421d-8df0-9823a88becf3',200, 'TRANSFER');

COMMIT;
select * from transactions;

select account_id, current_balance from balances;

rollback;