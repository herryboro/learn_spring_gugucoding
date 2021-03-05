create user book_ex identified by book_ex;
grant connect, dba to book_ex;
exec dbms_xdb.sethttpport(9090);

create sequence seq_board;
?
create table tbl_board(
    bno number(10,0),
    title varchar2(200) not null,
    content varchar2(2000) not null,
    writer varchar2(50) not null,
    regdate date default sysdate, 
    updatedate date default sysdate
);
