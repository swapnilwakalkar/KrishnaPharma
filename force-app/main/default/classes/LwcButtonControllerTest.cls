@isTest
public class LwcButtonControllerTest {

    // Test method to cover the constructor of LwcButtonController
    @isTest
    static void testConstructor() {
        // Create a Sample_Request__c record
        Sample_Request__c comm = new Sample_Request__c( Email__c = 'test@example.com');
        insert comm;

        // Create a PageReference and set the 'Id' parameter
        PageReference pageRef = Page.SampleRequestPDF; // Replace with your actual VF page name
        Test.setCurrentPageReference(pageRef);
        pageRef.getParameters().put('Id', comm.Id);

        // Instantiate the controller
        LwcButtonController controller = new LwcButtonController();

        // Verify that the 'comm' property is not null
        System.assertNotEquals(null, controller.comm);
    }

    // Test method to cover the sendPdf method
    @isTest
    static void testSendPdf() {
        // Create a Sample_Request__c record
        Sample_Request__c comm = new Sample_Request__c(Email__c = 'test@example.com');
        insert comm;

        // Call the sendPdf method
        Test.startTest();
        String result = LwcButtonController.sendPdf(comm.Id);
        Test.stopTest();

        // Assert that the result is as expected
        System.assertEquals('Email sent Successfully with PDF.', result);

        // You can add additional assertions if needed
    }
}