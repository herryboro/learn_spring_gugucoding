create user book_ex identified by book_ex;
grant connect, dba to book_ex;
exec dbms_xdb.sethttpport(9090);



create table tbl_board(
    bno number(10,0),
    title varchar2(200) not null,
    content varchar2(2000) not null,
    writer varchar2(50) not null,
    regdate date default sysdate, 
    updatedate date default sysdate
);

create table tbl_reply(
    rno number(10, 0),
    bno number(10, 0) not null,
    reply varchar2(1000) not null,
    replyer varchar2(50) not null,
    replyDate date default sysdate,
    updateDate date default sysdate
); 

create table tbl_sample1(col1 varchar2(500));
create table tbl_sample2(col2 varchar2(50));

-- sqeuence
create sequence seq_board;
create sequence seq_reply;

-- alter
alter table tbl_board add constraint pk_board primary key (bno);
alter table tbl_reply add constraint pk_reply primary key(rno);
alter table tbl_reply add constraint fk_reply_board foreign key(bno) references tbl_board(bno);
alter table tbl_board add(replycnt number default 0);

-- update
update tbl_board set replycnt = (select count(rno) from tbl_reply where tbl_reply.bno = tbl_board.bno);

select count(rno) from tbl_reply where tbl_reply.bno = tbl_board.bno;
-- cteate index
create index idx_reply on tbl_reply(bno desc, rno asc);

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

select bno, title, content, writer, regdate, updatedate, replycnt
    from(select /*+ index_desc(tbl_board pk_board) */ rownum rn, bno, title, content, writer, regdate, updatedate, replycnt 
            from tbl_board where 
			rownum <= 10)
    where rn > 0;
    
select * from tbl_board;

select bno, title, content, writer, regdate, updatedate, replycnt 
    from(select /*+ index_desc(tbl_board pk_board) */ rownum rn, bno, title, content, writer, regdate, updatedate, replycnt
            from tbl_board 
            where (title like '%'||'테스트'||'%') and
            rownum <= 10)
    where rn > 0;

		

    












