import { LightningElement, track } from 'lwc';
import { NavigationMixin } from "lightning/navigation";
import { ShowToastEvent } from "lightning/platformShowToastEvent";
import callapexclas from '@salesforce/apex/PurchaseHandler.insertacc'
export default class purchaseForm extends NavigationMixin(LightningElement) {

    @track Supplier__c = '';
    @track Materials__c = '';
    @track products;
    @track krush;
    @track contactlist;
    @track keyIndex = 0;
    @track message;
    @track error;
    @track productRecList = [
    {
    Product__c: '',
    Price__c: '',
    Purchase_Date__c:''
    }
    ];
    
    
    changeHandler(event) {
    //alert(event.target.id.split('-'));
    //console.log('Access Key2#: ' + event.target.accessKey);
    //console.log('id#: ' + event.target.id);
    //console.log('value#: ' + event.target.value);
    //console.log('handler# ' + event.target.value);
    if (event.target.name =='Product__c') {
    this.productRecList[event.target.accessKey].Product__c = event.target.value;
    console.log('accName#: ' + this.productRecList[event.target.accessKey].Product__c);
    }
    /*else if(event.target.name === 'accIndustry'){
    this.productRecList[event.target.accessKey].Industry = event.target.value;
    //console.log('accIndustry#: ' + this.productRecList[event.target.accessKey].Industry);
    }*/
    
    else if (event.target.name =='Price__c'){
    this.productRecList[event.target.accessKey].Price__c = event.target.value;
    console.log(this.productRecList);
    //console.log('accPhone#: ' + this.productRecList[event.target.accessKey].Phone);
    }
    else if (event.target.name =='Purchase_Date__c'){
    this.productRecList[event.target.accessKey].Purchase_Date__c = event.target.value;
    console.log(this.productRecList);
    //console.log('accPhone#: ' + this.productRecList[event.target.accessKey].Phone);
    }
    
    }
    
    
    
    
    addRow() {
    this.keyIndex + 1;
    this.productRecList.push({
    Product__c: '',
    Price__c: '',
    Purchase_Date__c: ''
    })
    }
    
    removeRow(event) {
    if (this.productRecList.length >= 1) {
    this.productRecList.splice(event.target.accessKey, 1);
    this.keyIndex - 1;
    }
    }
    
    
    
    
    namehandlechange(event) {
    this.Supplier__c = event.target.value;
    console.log(this.Supplier__c);
    }
    
    materialhandlechange(event) {
        this.Materials__c = event.target.value;
        console.log(this.Materials__c);
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
         const supplierValue = this.Supplier__c
        if(!supplierValue){
           return false;  
        }
        for (let product of this.productRecList) {
           if (!product.Product__c || !product.Price__c) {
                return false; // Validation fails
            }
        }
        return true; // Validation passes
    }
    callApexMethod() {
    console.log("AccountList# " + JSON.stringify(this.productRecList));
    console.log("Inside .then block");
    callapexclas({ apexname: this.Supplier__c, apexmaterial: this.Materials__c, products: this.productRecList })
    .then(purId => {
    console.log('Purchase ID:', purId);
    
    if (purId) {
    this.krush = purId; // Assign Account ID to krush variable
    console.log('this.krush', this.krush);
    
    this.error = undefined;
    
    const toastEvent = new ShowToastEvent({
    title: 'Success!',
    message: 'Purchase and Purchase Products created',
    variant: 'success'
    });
    console.log('Dispatching toast event',this.dispatchEvent(toastEvent));
    this.dispatchEvent(toastEvent);
    this.navigateToViewAccountPage();
    
    
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
  showToast(title, message, variant) {
        const event = new ShowToastEvent({
            title: title,
            message: message,
            variant: variant
        });
        this.dispatchEvent(event);
    }
    canclebutton() {
    this.template.querySelector('form').reset();
    }
    
    // Open Opp Subtab
    navigateToViewAccountPage() {
    setTimeout(() => {
    this[NavigationMixin.Navigate]({
    type: 'standard__recordPage',
    attributes: {
    recordId: this.krush, // Use the Account ID from your component's data
    objectApiName: 'Purchase__c',
    actionName: 'view'
    },
    });
    }, 2000); // Delay of 2000 milliseconds (2 seconds)
    }
    
    
 handleCancel(event){
    var url = window.location.href; 
    window.history.back();
    return false;
}

}