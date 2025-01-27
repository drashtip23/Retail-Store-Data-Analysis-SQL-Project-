select count(*) from retail_store.Customer;
select count(*) from retail_store.prod_cat_info;
select count(*) from retail_store.Transactions;

select count(Qty) from retail_store.Transactions
where Qty like '-%';

select prod_cat from retail_store.prod_cat_info
where prod_subcat = 'DIY';

select Store_type, count(Store_type) from retail_store.Transactions
group by Store_type;

select Gender, count(Gender) from retail_store.Customer
group by Gender;

select city_code ,count(city_code) from retail_store.Customer
group by city_code
order by city_code desc
limit 1;

select count(prod_subcat) from retail_store.prod_cat_info
where prod_cat = 'Books';

select sum(Qty),cust_id from retail_store.Transactions
group by cust_id;

select sum(total_amt) from retail_store.Transactions as t
join retail_store.prod_cat_info as p
 on t.prod_cat_code = p.prod_cat_code
 and  t.prod_subcat_code = p.prod_sub_cat_code
 where p.prod_cat in ('Electronics' , 'Books') ;

select count(customer_id) as c from retail_store.Customer
where customer_id in (select cust_id from retail_store.Transactions
left join retail_store.Customer on customer_id = cust_id
where total_amt not like '-%'
group by cust_id
having count(transaction_id)>10);

select sum(t.total_amt) as total from retail_store.Transactions as t
inner join retail_store.prod_cat_info as p
 on t.prod_cat_code = p.prod_cat_code
 and  t.prod_subcat_code = p.prod_sub_cat_code
 where prod_cat in ('Electronics','Clothing')
 and Store_type = 'Flagship store';
 
select sum(total_amt) ,prod_subcat from retail_store.Customer as cust
join  retail_store.Transactions as t 
 on cust.customer_Id = t.cust_id
 inner join retail_store.prod_cat_info as p
 on  t.prod_cat_code = p.prod_cat_code
 and  t.prod_subcat_code = p.prod_sub_cat_code
 where cust.Gender = 'M' and  p.prod_cat ='Electronics'
 group by p.prod_subcat;
 
select prod_subcat, (sum(total_amt)/(select sum(total_amt) from retail_store.Transactions))*100 as salespercentage,
(count(case when Qty <0 then Qty else null end)/sum(Qty))*100 as percentage_return
from retail_store.Transactions as t
inner join retail_store.prod_cat_info as p
on  t.prod_cat_code = p.prod_cat_code
and t.prod_subcat_code = p.prod_sub_cat_code
group by prod_subcat
order by sum(total_amt) desc
limit 5;

select sum(total_amt),cust_id from retail_store.Transactions
group by cust_id;

select sum(total_amt),prod_cat from retail_store.Transactions as t
join retail_store.prod_cat_info as p
 on t.prod_cat_code = p.prod_cat_code
 and  t.prod_subcat_code = p.prod_sub_cat_code
 where total_amt <0
 group by p.prod_cat
 order by sum(total_amt) desc;
 
 select Store_type ,sum(total_amt)as Total_sales,sum(Qty) as TotalQuentity 
from  retail_store.Transactions as t
group by Store_type
having sum(total_amt)>= All (select sum(total_amt) from retail_store.Transactions as t group by Store_type)
 and sum(Qty)>= all(select sum(Qty) from retail_store.Transactions as t group by Store_type);

select prod_cat ,AVG(total_amt) as average from retail_store.Transactions as t
inner join retail_store.prod_cat_info as p
 on t.prod_cat_code = p.prod_cat_code 
and p.prod_sub_cat_code = t.prod_subcat_code 
group by prod_cat
having avg(total_amt) > (select avg(total_amt) from retail_store.Transactions as t);

select prod_cat,prod_subcat, avg(total_amt) as AverageRevenue,sum(total_amt)as TotalRevenue from  retail_store.Transactions as t
inner join retail_store.prod_cat_info as p
on p.prod_cat_code =t.prod_cat_code and prod_sub_cat_code =prod_subcat_code
where prod_cat in (select prod_cat from  retail_store.Transactions as t inner join retail_store.prod_cat_info as p on
t.prod_cat_code=p.prod_cat_code and p.prod_sub_cat_code = t.prod_subcat_code
group by prod_cat
order by sum(Qty) desc)
group by p.prod_cat,p.prod_subcat
limit 5;