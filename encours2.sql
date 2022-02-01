delete FROM company WHERE int_id > 834;
delete FROM addresses WHERE int_id > 1001;
delete FROM line_of_business_company WHERE int_id > 454;
delete FROM contact WHERE int_id > 1152;

SELECT * FROM company WHERE int_id > 834;
SELECT * FROM addresses WHERE int_id > 1001;
SELECT * FROM contact WHERE int_id > 1152;
SELECT * FROM line_of_business_company WHERE int_id > 454;

