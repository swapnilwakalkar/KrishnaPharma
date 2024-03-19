public class LwcButtonController {
    public Sample_Request__c comm{get;set;}
    public String currentRecordId {get;set;}
    public LwcButtonController(){
        currentRecordId  = ApexPages.CurrentPage().getparameters().get('Id');
        if(currentRecordId != null && String.isNotBlank(currentRecordId)){
            
            comm = [ SELECT Id, Name, Email__c FROM Sample_Request__c where id=:currentRecordId];
            
        }
    }
    @AuraEnabled
    public static String sendPdf(String recordId) {
        
        PageReference pdf = new pagereference('/apex/SampleRequestPDF?id='+recordId);
        pdf.getParameters().put('id', recordId);
        Blob body;
        try {
            body = pdf.getContent();
        } 
        catch (Exception e) {
            body = Blob.valueOf('data');
        }
        //insert content version
        ContentVersion CV = new ContentVersion();
        String uniqueNumber = 'SAMP-' + Datetime.now().format('yyMMdd') +String.valueOf(System.currentTimeMillis()).substring(5);
        CV.Title = uniqueNumber;
        CV.PathOnClient = 'SampleReq.pdf';
        CV.VersionData = body;
        CV.FirstPublishLocationId = recordId;
        insert CV;
        
        Messaging.EmailFileAttachment attach = new Messaging.EmailFileAttachment();
        attach.setContentType('application/pdf');
        attach.setFileName('Sample Request.pdf');
        attach.Body = body;
        Sample_Request__c cmail = [SELECT Id, Name, Email__c FROM Sample_Request__c WHERE Id = :recordId];
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setToAddresses(new String[] {cmail.Email__c});
        mail.setSubject(' Sri Krishna Pharma Pvt.Ltd.,');
        mail.setHtmlBody('PDF for the Sample Request');
        mail.setFileAttachments(new Messaging.EmailFileAttachment[] {attach});
        
        
        
        // Send the email
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] {mail});
        return 'Email sent Successfully with PDF.';
    }
}