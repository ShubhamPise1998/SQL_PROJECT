
/* 
1 ==> CREATE AN ER DIAGRAM OR DRAW A SCHEMA FOR GIVEN DATABASE
*/

/*
2 ==>WE WANT TO REWARD THE USER WHO AROUND THE LONGEST , FIND FIVE OLDEST USERS
*/

select * FROM USERS order by created_at  limit 5;
select * from users order by created_at limit 5;

/*
3 ==> to understand where to run the campaign figure out the day of week most user register on 
*/
select dayname(created_at) from users where created_at=(select max(created_at)from users); 

/*
4 ==> to target an inactive users in email ad campaign find the user who never posted a photo 
*/
select * from users;
select * from photos;
select u.id,u.username from users u where u.id not in(select p.user_id from photos p);
select users.id ,users.username from users 
left join photos
on users.id=photos.user_id
where photos.id is null;

/*
5 ==> suppose you are running a context to find out who got most likes on photos.find out who won
 */
 
select username,photos.id,count(*) from photos 
join likes
on likes.photo_id=photos.id
join users 
on photos.user_id=users.id
group by photos.id
order by count(*) desc
limit 1;
 
/*
6 ==>THE INVESTOR WANTS TO KNOW HOW MANY TIMES AVG USER POST 
*/
select (select count(*) from photos)/(select count(*) from users) as 'avg';
/*
7 ==> A BRAND WANTS TO KNOW WHICH HASHTAG TO USE ON POST, FIND TOP 5 MOST USED TAGS
*/

select * from tags;
select * from photo_tags;

select pt.tag_id,count(pt.tag_id),tag_name from photo_tags pt
join tags t
on pt.tag_id=t.id
group by tag_id 
order by count(pt.tag_id) desc 
limit 5;

/*
8 ==> to find out if there are bots,find users who have liked every single photo on site
 */
select username,u.id,count(*) as total_likes from users u inner join likes l
on u.id=l.user_id
group by u.id
having total_likes=(select count(*) from photos);


-- 9 ==> TO KNOW WHO CLELEBRITIES ARE FIND USERS WHO NEVER COMMENTED ON PHOTO

select * from comments;
select * from users;
select username,id as user_id from users where id not in (select user_id from comments);

/*
10 ==>NOW FIND BOTH OF THEM TOGETHER FIND USERS NEVER COMMENTED ON PHOTO AND COMMENTED ON EVERY PHOTO
*/
select * from photos;
select * from comments;
select * from users;

select username,c.user_id  from photos p
join comments c
on p.id = c.photo_id
join users u 
on u.id=c.user_id
group by c.user_id
having count(c.user_id)=(select count(*) from photos)
union
select username,id as user_id from users where id not in (select user_id from comments);


