create user book_ex identified by book_ex;
grant connect, dba to book_ex;
exec dbms_xdb.sethttpport(9090);