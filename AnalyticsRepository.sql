# Q1 – How many Artists are registered with me?
SELECT count(ArtistID) FROM fame.ARTIST_T;


# Q2 - Show me details of all Artists
SELECT * FROM fame.ARTIST_T;


# Q3 - Show me First Name, Last Name and Phone Number of all Artists?
SELECT FirstName, LastName, Phone FROM fame.ARTIST_T;

# Q4 - Show me First Name, Last Name and Phone Number of all Artists – sort by LastName
SELECT FirstName, LastName, Phone FROM fame.ARTIST_T
order by LastName;

SELECT FirstName, LastName, Phone FROM fame.ARTIST_T
order by LastName desc;

# Q5 - Show me all Artists from the State of NJ
SELECT * FROM fame.ARTIST_T
where State = 'NJ';


# Q6 - Show me all Artist Agreements, Date and Amounts signed for amounts between 1500 and 2000
SELECT AgreementNbr, AgreementDate, GrossAmount FROM fame.AGREEMENT_T
where GrossAmount between 1500 and 2000;

# Q7 - Show me a list of all customers who have Arts in their name
SELECT * FROM fame.CUSTOMER_T
where CustomerName like '%Arts%';

# Q8 - Show me all female artists in the state of PA and NJ
SELECT * FROM fame.ARTIST_T
where Gender = 'F' and (state = 'PA' or state = 'NJ');

SELECT * FROM fame.ARTIST_T
where Gender = 'F' and state in ('PA', 'NJ');

# Q9 - Show me all ArtistID, Start Date, End Date and Royalty for VALID artist contracts more than 20%  
  #  Order the list by ArtistID
SELECT ArtistID, StartDate, EndDate, RoyaltyPerc FROM fame.CONTRACT_T
where RoyaltyPerc > 20 and current_timestamp() between StartDate and EndDate
order by ArtistID;

  
# Q10 - Show me the sum of all customer Payments made in the months of Feb and March 2015
SELECT sum(amount) FROM fame.CUSTOMERPAYMENT_T
where CPaymentDate between '2015-02-01' and '2015-03-31';

# this was my initial solution
SELECT sum(Amount) FROM fame.CUSTOMERPAYMENT_T
where month(CPaymentDate) in (2,3) and year(CPaymentDate) = 2015;

# Q11 - Show me how many events were held per venue
SELECT VenueID, count(EventID) VenueCount FROM fame.EVENT_T
group by VenueID;

# Q12 - Show me how many events were held per venue where there were at least 2 events
SELECT VenueID, count(EventID) VenueCount FROM fame.EVENT_T
group by VenueID
having VenueCount >=2;

# Q13 - Show me all Expense details for Expense type 'M' and amounts less than 100, or  expense type is A and amount less than 50
SELECT * FROM fame.EXPENSE_T
where ExpenseType = 'M' and Amount < 100
or ExpenseType = 'A' and Amount < 50;


# Advanced SQL:

# Q1: Select all contract details for all artists
SELECT * FROM fame.CONTRACT_T
where ArtistID in (select ArtistID from fame.ARTIST_T);

# Q2: Select all contract details for artists born before 1970
SELECT * FROM fame.CONTRACT_T
where ArtistID in (select ArtistID from fame.ARTIST_T
					where YearOfBirth <= 1970);

# Q3: Select all contract and artist details for all artists
SELECT * 
	FROM fame.ARTIST_T
    inner join fame.CONTRACT_T 
    on fame.ARTIST_T.ArtistID = fame.CONTRACT_T.ArtistID;
    
SELECT * 
	FROM fame.ARTIST_T A
    inner join fame.CONTRACT_T C
    on A.ArtistID = C.ArtistID;
    

# Q4: Display contract details for all artists and the contracts that have/had a contract:
# List: Artist Id, First name, Last name, Year of Birth, Contract ID, Contract Start Date, Contract End
# Date, Royalty percentage for all artists
SELECT  fame.ARTIST_T.ArtistID, fame.ARTIST_T.FirstName, fame.ARTIST_T.LastName, fame.ARTIST_T.YearOfBirth, 
        fame.CONTRACT_T.ContractID, fame.CONTRACT_T.StartDate, fame.CONTRACT_T.EndDate, fame.CONTRACT_T.RoyaltyPerc
	FROM fame.ARTIST_T
    inner join fame.CONTRACT_T 
    on fame.ARTIST_T.ArtistID = fame.CONTRACT_T.ArtistID;
    




# Q5A: Display details for all artists and contracts irrespective of if they have/had a contract:
# List: Artist Id, First name, Last name, Year of Birth, ContractID, Contract Start Date, Contract End
#Date, Royalty percentage for all artists
SELECT  fame.ARTIST_T.ArtistID, fame.ARTIST_T.FirstName, fame.ARTIST_T.LastName, fame.ARTIST_T.YearOfBirth, 
        fame.CONTRACT_T.ContractID, fame.CONTRACT_T.StartDate, fame.CONTRACT_T.EndDate, fame.CONTRACT_T.RoyaltyPerc
	FROM fame.ARTIST_T
	inner join fame.CONTRACT_T 
    on fame.ARTIST_T.ArtistID = fame.CONTRACT_T.ArtistID;

SELECT A.ArtistID, A.FirstName, A.LastName, A.YearOfBirth, 
        C.ContractID, C.StartDate, C.EndDate, C.RoyaltyPerc
	FROM fame.ARTIST_T A
    inner join fame.CONTRACT_T C
    on A.ArtistID = C.ArtistID;

# Q5B: Display details for all contracts and the artists irrespective of if the artists are still with us:
# List: Artist Id, First name, Last name, Year of Birth, ContractID, Contract Start Date, Contract End
# Date, Royalty percentage for all artists
SELECT A.ArtistID, A.FirstName, A.LastName, A.YearOfBirth, 
        C.ContractID, C.StartDate, C.EndDate, C.RoyaltyPerc
	FROM fame.ARTIST_T A
    right outer join fame.CONTRACT_T C
    on A.ArtistID = C.ArtistID;


# Q6 - Display all details of Artists who play the Violin
SELECT A.FirstName, A.LastName, A.Phone,
       I.InstrumentName FROM fame.ARTIST_T A
	inner join fame.ARTISTINSTRUMENT_T AI
		on A.ArtistID = AI.ArtistID
	inner join fame.INSTRUMENT_T I
		on AI.InstrumentID = I.InstrumentID
	where I.InstrumentName = 'Violin';

# Q7 - Display details of the Customer and the Events for Venues in the state of California
SELECT * FROM fame.CUSTOMER_T C
	inner join fame.EVENT_T E
		on C.CustomerID = E.CustomerID
	inner join fame.VENUE_T V
		on E.VenueID = V.VenueID
	where V.State = 'CA';
    
# find the range of the total customer payments received
with paymentsummary as (
select C.CustomerName, P.CustomerID, sum(P.amount) amount, max(amount) - min(amount), max(amount), min(amount)  FROM fame.CUSTOMERPAYMENT_T P
inner join fame.customer_t C 
on C.customerID = P.CustomerID
group by P.CustomerID)
select max(amount) - min(amount), max(amount), min(amount) from paymentsummary
;

