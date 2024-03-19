@isTest
public class SampleRequestPDFControllerTest {

    static testMethod String testPdfGeneration() {
        // Create a Sample Request record for testing
        Sample_Request__c sampleRequest = new Sample_Request__c(
        Customer_Request_Date__c = Date.today(),
          Status__c = 'Open',
          Email__c = 'krushna@gmail.com'
           
            // Populate other required fields here
        );
        insert sampleRequest;
        if (sampleRequest == null) {
            return null; // No complaint to generate PDF
        }
        // Create a PageReference for the controller
        PageReference pageRef = Page.SampleRequestPDF;
        pageRef.getParameters().put('id', sampleRequest.Id);

        // Set the current page to the PageReference
        Test.setCurrentPage(pageRef);

        // Instantiate the controller
        ApexPages.StandardController stdController = new ApexPages.StandardController(sampleRequest);
        SampleRequestPDFController controller = new SampleRequestPDFController(stdController);

        // Test the pdf() method
        PageReference pdfPage = controller.pdf();
           return null;
        // Assert that the PageReference is not null (PDF generation was attempted)
       // System.assertNotEquals(null, pdfPage);

       
    }

    // Add more test methods to cover other scenarios as needed
}