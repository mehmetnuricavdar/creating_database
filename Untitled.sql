use meal_sharing;

-- Meal
-- Get all meals
select*from meal;
-- Add a new meal
INSERT INTO meal values( 1,'Margarita', 'one of the classics','Copenhagen', '2023-04-01 14:10:10', 6, 14.90, '2023-04-01 14:10:10' );
-- Get a meal with any id, fx 1
select * from meal where mealID=1;
-- Update a meal with any id, fx 1. Update any attribute fx the title or multiple attributes
update meal set max_reservations=16 where mealID=1;
-- Delete a meal with any id, fx 1
delete from meal where mealID=1;

-- Reservation
-- Get all reservations
select * from reservation;
-- Add a new reservation
insert into reservation values (2, 4, 1, '2023-04-01 14:10:10', '+45123123123', 'Mehmet', 'mehmet@email.com' );
-- Get a reservation with any id, fx 1
select * from reservation where reservationID=2;
-- Update a reservation with any id, fx 1. Update any attribute fx the title or multiple attributes
update reservation set numberOfGuests=5 where reservationID=2;
-- Delete a reservation with any id, fx 1
delete from reservation where reservationID=2;

-- Review
-- Get all reviews
select *from review;
-- Add a new review
insert into review values (1, 'Fantastic', 'Like my mom cooked', 1, 5, '2023-04-01 14:10:10');
-- Get a review with any id, fx 1
select * from review where reviewID=1;
-- Update a review with any id, fx 1. Update any attribute fx the title or multiple attributes
update review set title='it is fantastic' where reviewID=1;
-- Delete a review with any id, fx 1
delete from review where reviewID=1;

-- Additional queries
-- Now add a couple of different meals, reservations and reviews with different attributes. With those meals create the following queries
INSERT INTO meal values( 2,'Mediterranean', 'sea wiew','Athens', '2023-04-05 14:10:10', 10, 17.90, '2023-04-05 14:10:10' );
insert into review values (2, 'Cool', 'felt the sea', 2, 3, '2023-04-06 14:10:10');



-- Functionality
-- Get meals that has a price smaller than a specific price fx 90
select * from meal where price<20;
-- Get meals that still has available reservations
select m. *from meal m join reservation r  on m.mealID=r.mealID where m.max_reservations-r.numberOfGuests >0;
-- Get meals that partially match a title. Rød grød med will match the meal with the title Rød grød med fløde
select * from meal where title like '%gar%';
-- Get meals that has been created between two dates
select *from meal where created_date between '2023-01-01' and '2023-07-01';
-- Get only specific number of meals fx return only 5 meals
select * from meal limit 3;
-- Get the meals that have good reviews
select * from meal m join review r on m.mealID=r.reviewID where r.stars >4;
-- Get reservations for a specific meal sorted by created_date
select title from meal join reservation r on meal.mealID=r.mealID where title like 'Margarita' order by r.createdDate ;
-- Sort all meals by average number of stars in the reviews
select meal.title, avg(review.stars) from meal left join review on review.mealID=meal.mealID group by meal.mealID order by avg(review.stars);