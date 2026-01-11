CREATE OR REPLACE FUNCTION prevent_negative_balance()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.current_balance < 0 THEN
        RAISE EXCEPTION 'Insufficient funds. Balance cannot be negative.';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE trigger trg_prevent_negative_balance
before update on balances
for each row
execute FUNCTION prevent_negative_balance();

Create or REPLACE FUNCTION prevent_transaction_delete()
RETURNS TRIGGER AS $$
BEGIN
	RAISE EXCEPTION 'Transactions cannot be deleted.';
END;
$$ LANGUAGE plpgsql;

Create trigger trg_no_delete_transactions
before delete on transactions
for each row
execute FUNCTION prevent_transaction_delete();

alter table transactions
add constraint chk_valid_amount CHECK (amount > 0);

alter table transactions
add constraint  chk_accounts_different
CHECK (from_account_id <> to_account_id);

update balances
set current_balance = -100
where account_id = '3dd55d16-878d-411e-a22b-7fd7f6643c26';

delete from transactions;

select * from accounts;