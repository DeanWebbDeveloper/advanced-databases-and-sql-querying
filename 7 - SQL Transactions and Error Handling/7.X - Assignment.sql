-------------------------------------
------DISTRIBUTED TRANSACTIONS-------
-------------------------------------

--Distributed transactions work in the same way as any other transactions, except for can exist across multiple different servers.
--The transactions across multiple servers are tied together. They must all succeed in order for the transaction to be completed.

--Started with BEGIN DISTRIBUTED TRANSACTION, and follows same as any other trnasaction.
--Distributed transactiosn are used to ensure multiple servers are kept in sync.


-------------------------------------
-----IMPLICIT AND EXPLICIT MODES-----
-------------------------------------

--Explicit transactions are when we call the transaction explicitly each tim.
--So an explicit transaction we start each with BEGIN TRANSACTION

--Implicit transactions is where all the statements after a commit are treated as transactions.
--They don't have to have the BEGIN, and create a continuous chain of tranasactions
--You only have to COMMIT or ROLLBACK a TRANSACTION

--SET IMPLICIT_TRANSACTIONS ON


-------------------------------------
--------------AUTOCOMMIT-------------
-------------------------------------

--Autocommit does exactly what it says, auto commits. It it the default setting for SQL Server, and have been using it without even knowing.
--It is sort of the opposite of IMPLICIT TRANSACTIONS, where you have to commit everything, this commits it on its own.

--Due to the fact that it always commits, you cannot ROLLBACK transactions


-------------------------------------
--------------DEADLOCK-------------
-------------------------------------

--Say Query A is waiting for Query B to happen, but Query B is waiting for Query A to happen. Both will be infinitely waiting for the other.
--Due to this infinite loop, nothing will happen. This is a DEADLOCK.

--SQL Server routinely checks for deadlocks, and in the case one occurs, one process is killed to allow the other to continue.
--The killed process is known as the DEADLOCK VICTIM.

--DEADLOCK GRAPHS are used to represent the deadlock and how it is formed. It cannot be made using the SQL Server Profiler.
--Saves as XML file.
--Shows the resources, processes, effectively what is occurring to produce the deadlock.
--Deadlock victim is the crossed out process