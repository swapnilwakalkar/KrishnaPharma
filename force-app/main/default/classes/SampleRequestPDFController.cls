public class SampleRequestPDFController {
    public Id recordId {get; set;}
    public List<Sample_Request__c> sam { get; set; }
    
  
    public SampleRequestPDFController(ApexPages.StandardController controller) {
        
        recordId = ApexPages.currentPage().getParameters().get('id');
        system.debug('id=='+recordId);
        
        sam = [SELECT Id,Sample_Sr_No__c,Batch_No__c,CreatedDate,Owner.Name,Customer_Agent_Request_Letter_Enclosed__c,Name,Dispatch_Date__c, Account_Name__r.Name,Opportunity__r.Name,Project__r.Name,Product_Name__r.Name,Samples__c,Quantity__c,Customer_Specifications_Enclosed__c,Packaging_Requirement__c,Supporting_Documents_Required__c,Customer_Request_Date__c,Status__c, Email__c FROM Sample_Request__c where id=:recordId];
        
        
    }
    public PageReference pdf() {
        if (sam.isEmpty()) {
             // return null;No complaint to generate PDF
        }
        Sample_Request__c SA = sam[0];
        
        PageReference pdfPage = Page.SampleRequestPDF;
        pdfPage.getParameters().put('id', SA.Id);
        blob pdfBlob;
                   
            if(Test.isRunningTest())
            {
            pdfBlob = blob.valueOf('Unit.Test'); }
            else
            {
            pdfBlob = pdfPage.getContentAsPDF();
            }
       return null;
    }
    
}