----------------------------------------
---CREATE TRIGGER WITH EMAIL FUNCTION---
----------------------------------------

USE AdventureWorks2017

SELECT * FROM [Sales].[SpecialOffer]

CREATE TRIGGER MyTriggerWithEmail
ON [Sales].[SpecialOffer]
AFTER INSERT, UPDATE
AS
BEGIN

--BEST WAY, CANNOT CHECK IF THE VALUE IS LARGER< SO CHECK TO SEE IF LARGER VALUE EXISTS WHEN SELECTED AS BELOW--

IF EXISTS(SELECT * FROM [Sales].[SpecialOffer] WHERE [DiscountPct] >= 0.8)
	BEGIN
		PRINT 'You cannot exceed 80% discount!'
		ROLLBACK TRANSACTION
	END
END

--TEST THE TRIGGER--

UPDATE [Sales].[SpecialOffer]
SET [DiscountPct] = 0.9
WHERE [SpecialOfferID] = 1


--================================================================
-- DATABASE MAIL CONFIGURATION
--================================================================
--==========================================================
-- Create a Database Mail account
--==========================================================
EXECUTE msdb.dbo.sysmail_add_account_sp
    @account_name = 'Dean',
    @description = 'Dean Webb Developer',
    @email_address = 'dean@deanwebbdeveloper.com',
    @replyto_address = 'dean@deanwebbdeveloper.com',
    @display_name = '',
    @mailserver_name = '',
	@port = ;

--==========================================================
-- Create a Database Mail Profile
--==========================================================
DECLARE @profile_id INT, @profile_description sysname;
SELECT @profile_id = COALESCE(MAX(profile_id),1) FROM msdb.dbo.sysmail_profile
SELECT @profile_description = 'Database Mail Profile for ' + @@servername 


EXECUTE msdb.dbo.sysmail_add_profile_sp
    @profile_name = 'Dean',
    @description = @profile_description;

-- Add the account to the profile
EXECUTE msdb.dbo.sysmail_add_profileaccount_sp
    @profile_name = 'Dean',
    @account_name = 'Dean',
    @sequence_number = @profile_id;

-- Grant access to the profile to the DBMailUsers role
EXECUTE msdb.dbo.sysmail_add_principalprofile_sp
    @profile_name = 'Dean',
    @principal_id = 0,
    @is_default = 1 ;


--==========================================================
-- Enable Database Mail
--==========================================================
USE master;
GO

sp_CONFIGURE 'show advanced', 1
GO
RECONFIGURE
GO
sp_CONFIGURE 'Database Mail XPs', 1
GO
RECONFIGURE
GO 


--EXEC master.dbo.xp_instance_regwrite N'HKEY_LOCAL_MACHINE', N'SOFTWARE\Microsoft\MSSQLServer\SQLServerAgent', N'DatabaseMailProfile', N'REG_SZ', N''
--EXEC master.dbo.xp_instance_regwrite N'HKEY_LOCAL_MACHINE', N'SOFTWARE\Microsoft\MSSQLServer\SQLServerAgent', N'UseDatabaseMail', N'REG_DWORD', 1
--GO

EXEC msdb.dbo.sp_set_sqlagent_properties @email_save_in_sent_folder = 0
GO


--==========================================================
-- Review Outcomes
--==========================================================
SELECT * FROM msdb.dbo.sysmail_profile;
SELECT * FROM msdb.dbo.sysmail_account;
GO


--==========================================================
-- Test Database Mail
--==========================================================
DECLARE @sub VARCHAR(100)
DECLARE @body_text NVARCHAR(MAX)
SELECT @sub = 'Test from New SQL install on ' + @@servername
SELECT @body_text = N'This is a test of Database Mail.' + CHAR(13) + CHAR(13) + 'SQL Server Version Info: ' + CAST(@@version AS VARCHAR(500))

EXEC msdb.dbo.[sp_send_dbmail] 
    @profile_name = 'Dean'
  , @recipients = 'dean@deanwebbdeveloper.com'
  , @subject = @sub
  , @body = @body_text

--================================================================
-- SQL Agent Properties Configuration
--================================================================
EXEC msdb.dbo.sp_set_sqlagent_properties 
	@databasemail_profile = ''
	, @use_databasemail=1
GO