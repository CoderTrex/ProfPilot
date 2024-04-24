# 총 조회수가 가장 많은 게시판의 이름

select 
	B.bname,
	sum(A.hit)
from article A
join board B on A.bno = B.bno
group by B.bno
order by sum(A.hit) desc
limit 1
