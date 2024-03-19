@isTest
private class MinutesofMeetinghandlerTest {

    @isTest
    static void testInsertpdd() {
        // Test data
        Date apexdate = Date.today();
        String apexsubject = 'Test Subject';
        String apexmeetingnote = 'Test Meeting Note';
        String meetingtype = 'Call';
        String apexremark = 'Test Remark';
        
        // Create test records for lookup fields
        Account testAccount = new Account(Name = 'Test Account');
        insert testAccount;
        
        Contact testContact = new Contact(FirstName = 'Test', LastName = 'Contact');
        insert testContact;
        
        Opportunity testOpportunity = new Opportunity(Name = 'Test Opportunity', StageName = 'Prospecting', CloseDate = Date.today());
        insert testOpportunity;
        
        Lead testLead = new Lead(FirstName = 'Test', LastName = 'Lead', Company = 'Test Company');
        insert testLead;
        
        Project__c testProject = new Project__c(Name = 'Test Project');
        insert testProject;
        
        User testUser = [SELECT Id FROM User WHERE IsActive = true LIMIT 1];
        
        // Create a Minutes_of_Meeting_Description__c record
        Minutes_of_Metting_Description__c momDescription = new Minutes_of_Metting_Description__c();
        momDescription.Description__c = 'Test Description';
        
        
        // Create a list to hold the Minutes_of_Metting_Description__c record
        List<Minutes_of_Metting_Description__c> minutesList = new List<Minutes_of_Metting_Description__c>();
        minutesList.add(momDescription);

        // Call the insertpdd method
        Test.startTest();
        String momId = MinutesofMeetinghandler.insertpdd(
            apexdate, apexsubject, apexmeetingnote, meetingtype, apexremark,
            testAccount.Id, testContact.Id, testOpportunity.Id, testLead.Id, testProject.Id, testUser.Id, minutesList
        );
        Test.stopTest();

        // Retrieve the inserted Minutes_of_Meeting__c record
        Minutes_of_Meeting__c insertedMom = [SELECT Id FROM Minutes_of_Meeting__c WHERE Id = :momId LIMIT 1];

        // Verify that the Minutes_of_Meeting__c record was inserted
        System.assertNotEquals(null, insertedMom);

        // Verify that the related Minutes_of_Metting_Description__c records were inserted
        List<Minutes_of_Metting_Description__c> insertedMomDescriptions = [
            SELECT Id FROM Minutes_of_Metting_Description__c WHERE Minutes_of_Meeting__c = :momId
        ];
        System.assertEquals(1, insertedMomDescriptions.size());

        // Add additional assertions as needed for your use case
    }
}