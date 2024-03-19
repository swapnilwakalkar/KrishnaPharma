public class MinutesofMeetinghandler {
    @AuraEnabled
    public static id insertpdd(date apexdate,string apexsubject,string apexmeetingnote,string meetingtype,string apexremark,string apexaccount,string apexcontact,string apexopportunity,string apexlead,string apexproject,string apexuser , list<Minutes_of_Metting_Description__c> MinutesofMettings){
        
        Minutes_of_Meeting__c Mom=new Minutes_of_Meeting__c();
        Mom.MOM_Date__c =apexdate;
        Mom.Subject__c = apexsubject;
        Mom.Meeting_Notes__c=String.isBlank(apexmeetingnote) ? null : apexmeetingnote;
        Mom.Meeting_Type__c=String.isBlank(meetingtype) ? null : meetingtype;
        Mom.Remarks__c=String.isBlank(apexremark) ? null : apexremark;
        Mom.Account__c=String.isBlank(apexaccount) ? null : apexaccount;
        Mom.Contact__c=String.isBlank(apexcontact) ? null : apexcontact; 
        Mom.Opportunity__c=String.isBlank(apexopportunity) ? null : apexopportunity;
        Mom.Lead__c=String.isBlank(apexlead) ? null : apexlead;
        Mom.Project__c=String.isBlank(apexproject) ? null : apexproject;
        Mom.User__c=String.isBlank(apexuser) ? null : apexuser;
   
        insert Mom;
        
        system.debug('Minutes of Meeting insert'+Mom);
        
        
        for (Minutes_of_Metting_Description__c momdes : MinutesofMettings) {
            system.debug(MinutesofMettings);
            momdes.Minutes_of_Meeting__c = Mom.id;
        }
        insert MinutesofMettings;
        system.debug(MinutesofMettings);
        return Mom.id;
        
    }
}