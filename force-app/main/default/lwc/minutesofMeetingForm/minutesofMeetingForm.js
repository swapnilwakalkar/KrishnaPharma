import { LightningElement, track } from 'lwc';
import { NavigationMixin } from "lightning/navigation";
import { ShowToastEvent } from "lightning/platformShowToastEvent";
import callapexclas from '@salesforce/apex/MinutesofMeetinghandler.insertpdd'
export default class MinutesofMeetingForm extends NavigationMixin(LightningElement) {
   
    @track MOM_Date__c = '';
    @track Subject__c = '';
    @track Meeting_Notes__c= '';
    @track Meeting_Type__c='';
    @track Remarks__c='';
    @track Account__c='';
    @track Contact__c='';
    @track Opportunity__c='';
    @track Lead__c='';
    @track Project__c='';
    @track User__c='';
    @track MinutesofMettings;
    @track krush;
    @track keyIndex = 0;
    @track message;
    @track error;
    @track productRecList = [
    {
    Product__c: '',
    Description__c: ''
    }
    ];
    
    productHandler(event) {

    //console.log('Access Key2#: ' + event.target.accessKey);
    //console.log('id#: ' + event.target.id);
    //console.log('value#: ' + event.target.value);
    //console.log('handler# ' + event.target.value);
    if (event.target.name =='Product__c') {
    this.productRecList[event.target.accessKey].Product__c = event.target.value;
    console.log('MomName#: ' + this.productRecList[event.target.accessKey].Product__c);
    }
    /*else if(event.target.name === 'accIndustry'){
    this.productRecList[event.target.accessKey].Industry = event.target.value;
    //console.log('accIndustry#: ' + this.productRecList[event.target.accessKey].Industry);
    }*/
    
    else if (event.target.name =='Description__c') {
    this.productRecList[event.target.accessKey].Description__c = event.target.value;
    console.log('MomName#: ' + this.productRecList[event.target.accessKey].Description__c);
    //console.log(this.productRecList);
    //console.log('accPhone#: ' + this.productRecList[event.target.accessKey].Phone);
    }
    }
    
    addRow() {
    this.keyIndex + 1;
    this.productRecList.push({
    Product__c: '',
    Description__c: ''
    })
    }
    
    removeRow(event) {
    if (this.productRecList.length >= 1) {
    this.productRecList.splice(event.target.accessKey, 1);
    this.keyIndex - 1;
    
    }
    }
    
      momdathandlechange(event) {
      this.MOM_Date__c = event.target.value;
       console.log(this.MOM_Date__c);
       }
    
    subjecthandlechange(event) {
        this.Subject__c = event.target.value;
        console.log(this.Subject__c);
        }

     meetingnoteshandlechange(event) {
        this.Meeting_Notes__c = event.target.value;
        console.log(this.Meeting_Notes__c);
        }
 
     meetingtypehandlechange(event) {
        this.Meeting_Type__c = event.target.value;
        console.log(this.Meeting_Type__c);
        }

       remarkshandlechange(event) {
        this.Remarks__c = event.target.value;
        console.log(this.Remarks__c);
        }
 
       accounthandlechange(event) {
        this.Account__c = event.target.value;
        console.log(this.Account__c);
        }

       contacthandlechange(event) {
        this.Contact__c = event.target.value;
        console.log(this.Contact__c);
        }
 
      opportunityhandlechange(event) {
        this.Opportunity__c = event.target.value;
        console.log(this.Opportunity__c);
        }

      leadhandlechange(event) {
        this.Lead__c = event.target.value;
        console.log(this.Lead__c);
        }

      projecthandlechange(event) {
        this.Project__c = event.target.value;
        console.log(this.Project__c);
        }

      userhandlechange(event) {
        this.User__c = event.target.value;
        console.log(this.User__c);
        }
    
    savebutton() {
       if (this.validateProductList()) {
            // If validation passes, call the Apex method
            this.callApexMethod();
        } else {
            // If validation fails, show an error message
            this.showToast('Error', 'Required filed missing.', 'error');
        }
    }

     validateProductList() {
        // Implement your validation logic here
        // For example, check if required fields are populated, etc.
        for (let product of this.productRecList) {
           if (!product.Product__c || !product.Description__c) {
                return false; // Validation fails
            }
        }
        return true; // Validation passes
    }

     callApexMethod() {
        // Call your Apex method to process the data
    
    console.log("AccountList# " + JSON.stringify(this.productRecList));
    console.log("Inside .then block");
    callapexclas({ apexdate: this.MOM_Date__c, apexsubject: this.Subject__c,apexmeetingnote:this.Meeting_Notes__c,meetingtype:this.Meeting_Type__c,apexremark:this.Remarks__c,apexaccount:this.Account__c,apexcontact:this.Contact__c,apexopportunity:this.Opportunity__c,apexlead:this.Lead__c,apexproject:this.Project__c,apexuser:this.User__c, MinutesofMettings: this.productRecList })
    .then(purId => {
    console.log('Purchase ID:', purId);
    
    if (purId) {
    this.krush = purId; // Assign Account ID to krush variable
    console.log('this.krush', this.krush);
    
    this.error = undefined;
    
    const toastEvent = new ShowToastEvent({
    title: 'Success!',
    message: 'Minutes of Meeting Record Created',
    variant: 'success'
    });
    console.log('Dispatching toast event',this.dispatchEvent(toastEvent));
    this.dispatchEvent(toastEvent);
    this.navigateToViewMomPage();
    
    
    } else {
    this.krush = false;
    // Handle case when accountId is falsy (null, undefined, false)
    } 
    
    })
    .catch(error => {
    console.log("Inside .catch block");
    const errorMessage = error.body.message || 'Required filed missing.';
    console.log(this.errorMessage);
    
    const evt = new ShowToastEvent({
    title: 'Error',
    message: errorMessage,
    variant: 'error',
    mode: 'dismissable'
    });
    this.dispatchEvent(evt);
    
    console.log("Inside .catch block");
    this.error = error;
    console.log(JSON.stringify(this.error));
    
    });
    
    }
    
    canclebutton() {
    this.template.querySelector('form').reset();
    }
    
    // Open Opp Subtab
    navigateToViewMomPage() {
    setTimeout(() => {
    this[NavigationMixin.Navigate]({
    type: 'standard__recordPage',
    attributes: {
    recordId: this.krush, // Use the Account ID from your component's data
    objectApiName: 'Minutes_of_Meeting__c',
    actionName: 'view'
    },
    });
    }, 2000); // Delay of 2000 milliseconds (2 seconds)
    }
    
      showToast(title, message, variant) {
        const event = new ShowToastEvent({
            title: title,
            message: message,
            variant: variant
        });
        this.dispatchEvent(event);
    }
 handleCancel(event){
    var url = window.location.href; 
    window.history.back();
    return false;
}
}