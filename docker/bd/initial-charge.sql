CREATE TABLE public.tb_account (
	account_number int8 NOT NULL,
	name_holder varchar NOT NULL,
	document_holder varchar NOT NULL,
	balance numeric(18,2) NOT NULL DEFAULT 0,
	CONSTRAINT tb_account_pk_number_account PRIMARY KEY (account_number)
)
WITH (
	OIDS=FALSE
) ;

CREATE TABLE public.tb_movements (
	id serial NOT NULL,
	account_number int8 NOT NULL,
	amount numeric(18,2) NOT NULL DEFAULT 0.0,
	operation_type varchar(2) NOT NULL,
	"date" timestamp NOT NULL DEFAULT now(),
	CONSTRAINT tb_movements_pk PRIMARY KEY (id)
)
WITH (
	OIDS=FALSE
) ;

CREATE TABLE public.tb_transfer (
	id serial NOT NULL,
	debit_number_account int8 NOT NULL,
	debit_amount numeric(18,2) NOT NULL DEFAULT 0.0,
	favored_bank_code varchar(3) NOT NULL,
	favored_account varchar(12) NOT NULL,
	favored_agency varchar(4) NULL,
	favored_name varchar(150) NULL,
	favored_document varchar(14) NULL,
	id_movement int8 NOT NULL,
	CONSTRAINT tb_transfer_pk PRIMARY KEY (id)
)
WITH (
	OIDS=FALSE
) ;

CREATE TABLE public.tb_user (
	username varchar(50) NOT NULL,
	password varchar(8) NOT NULL,
	email varchar(110) NULL,
	date_register timestamp NOT NULL DEFAULT now(),
	CONSTRAINT tb_user_pk PRIMARY KEY (username)
)
WITH (
	OIDS=FALSE
) ;

CREATE OR REPLACE FUNCTION public.perform_credit(account bigint, amount numeric, operation_type character varying)
 RETURNS bigint
 LANGUAGE plpgsql
AS $function$

DECLARE

	result_set bigint;

BEGIN

	update tb_account set balance = balance + $2 where account_number = $1 RETURNING account_number into result_set;

	if result_set = $1 then

		insert into tb_movements(account_number, amount, operation_type) values ($1, $2, $3) RETURNING id into result_set;

	else

		RAISE EXCEPTION 'account not found';

	end if;

	RETURN result_set;

END

$function$;

CREATE OR REPLACE FUNCTION public.perform_debit(account bigint, amount numeric, operation_type character varying)
 RETURNS bigint
 LANGUAGE plpgsql
AS $function$

DECLARE

	result_set bigint;

BEGIN

	update tb_account set balance = balance - $2 where account_number = $1 and balance >= $2 RETURNING account_number into result_set;

	if result_set = $1 then

		insert into tb_movements(account_number, amount, operation_type) values ($1, $2, $3) RETURNING id into result_set;

	else

		RAISE EXCEPTION 'insufficient balance';

	end if;

	RETURN result_set;

END

$function$;

CREATE OR REPLACE FUNCTION public.perform_transfer(account_debit bigint, account_credit bigint, amount numeric)
 RETURNS bigint
 LANGUAGE plpgsql
AS $function$

DECLARE

	result_set bigint;
	code_transaction_debit bigint;
	code_transaction_credit bigint;

BEGIN

	code_transaction_debit = (select * from perform_debit($1, $3, 'TD'));
	code_transaction_credit = (select * from perform_credit($2, $3, 'TC'));
	result_set = code_transaction_debit + code_transaction_credit;

	RETURN result_set;

END

$function$;

CREATE OR REPLACE FUNCTION public.perform_ted(account_debit bigint, amount numeric, favored_bank_code character varying, favored_account character varying, favored_agency character varying, favored_name character varying, favored_document character varying)
 RETURNS bigint
 LANGUAGE plpgsql
AS $function$

DECLARE

	result_set bigint;

BEGIN

	result_set = (select * from perform_debit($1, $2, 'TT'));
	insert into tb_transfer(
							 debit_number_account,
	 						 debit_amount,
	 						 favored_bank_code,
	 						 favored_account,
	 						 favored_agency,
	 						 favored_name,
	 						 favored_document,
	 						 id_movement
						 	) values ($1, $2, $3, $4, $5, $6, $7, result_set);

	RETURN result_set;

END

$function$;

INSERT INTO public.tb_user (username, password, email, date_register) VALUES('admin', 'admin', 'admin@admin.com.br', now());
