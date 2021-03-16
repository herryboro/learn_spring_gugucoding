create user book_ex identified by book_ex;
grant connect, dba to book_ex;
exec dbms_xdb.sethttpport(9090);

create sequence seq_board;

create table tbl_board(
    bno number(10,0),
    title varchar2(200) not null,
    content varchar2(2000) not null,
    writer varchar2(50) not null,
    regdate date default sysdate, 
    updatedate date default sysdate
);

alter table tbl_board add constraint pk_board primary key (bno);

insert into tbl_board (bno, title, content, writer) 
values (seq_board.nextval, '테스트 제목','테스트 내용','user00');

commit;

select * from tbl_board order by bno desc;
select /*+ INDEX_DESC (tbl_board pk_board) */ * from tbl_board; 
select /*+ index_asc (tbl_board pk_board) */ * from tbl_board;

/* hint 문법 */
-- select /*+ hint name(param...) */ column name, ... from table name ...

/* full 힌트 */
select /*+ full(tbl_board) */ * from tbl_board order by bno desc;

/* index_asc, index_desc 힌트 */
select /*+ index_asc(tbl_board pk_board) */ * from tbl_board where bno > 0;

/* rownum */
select rownum, bno, title from tbl_board where bno > 0 order by bno;
select /*+ full(tbl_board) */ rownum, bno, title from tbl_board where bno > 0 order by bno;
select /*+ index_asc(tbl_board pk_board) */ rownum, bno, title, content from tbl_board;
select /*+ index_desc(tbl_board pk_board) */ rownum, bno, title, content from tbl_board where bno > 0;

select /*+ index_desc(tbl_board pk_board) */ rownum, bno, title, content 
    from tbl_board where rownum <= 20;

/* 인라인 뷰 */
select bno, title, content, writer, regdate, updatedate
    from(select /*+ index_desc(tbl_board pk_board) */
        rownum rn, bno, title, content, writer, regdate, updatedate from tbl_board where rownum <= 20
    )
    where rn > 0;
    
select * from tbl_board where bno = 39;

update tbl_board
			set title = '테스트 제목',
			content = '테스트 내용',
			writer = 'user00',
			updateDate = sysdate
			where bno = 4;
            
select count(*) from tbl_board where bno > 0;

insert into tbl_board (bno, title, content, writer) 
values (seq_board.nextval, '테스트 제목','테스트 내용','user00');
insert into tbl_board (bno, title, content, writer) 
values (seq_board.nextval, '테스트 제목','테스트 내용','user00');
insert into tbl_board (bno, title, content, writer) 
values (seq_board.nextval, '테스트 제목','테스트 내용','user00');
insert into tbl_board (bno, title, content, writer) 
values (seq_board.nextval, '테스트 제목','테스트 내용','user00');
insert into tbl_board (bno, title, content, writer) 
values (seq_board.nextval, '테스트 제목','테스트 내용','user00');
insert into tbl_board (bno, title, content, writer) 
values (seq_board.nextval, '테스트 제목','테스트 내용','user00');
insert into tbl_board (bno, title, content, writer) 
values (seq_board.nextval, '테스트 제목','테스트 내용','user00');
insert into tbl_board (bno, title, content, writer) 
values (seq_board.nextval, '테스트 제목','테스트 내용','user00');
insert into tbl_board (bno, title, content, writer) 
values (seq_board.nextval, '테스트 제목','테스트 내용','user00');
insert into tbl_board (bno, title, content, writer) 
values (seq_board.nextval, '테스트 제목','테스트 내용','user00');

commit;

select * from (select /*+ index_dese(tbl_board pk_board) */
                   rownum rn, bno, title, content, writer, regdate, updatedate from tbl_board where rownum <= 20)
    where rn > 10;

        
select bno, title, content, writer, regdate, updatedate
    from(select /*+ index_desc(tbl_board pk_board) */ rownum rn, bno, title, content, writer, regdate, updatedate 
            from tbl_board 
            where (title like '%'||'테스트'||'%' or content like '%'||'테스트'||'%' or writer like '%'||'테스트'||'%') 
                and 
                rownum <= 10)
			where rn > 0;
    












