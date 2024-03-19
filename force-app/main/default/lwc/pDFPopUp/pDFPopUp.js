import { LightningElement,api } from 'lwc';
import sendPdf from "@salesforce/apex/LwcButtonController.sendPdf";
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { NavigationMixin } from "lightning/navigation";
export default class PDFPopUp extends  NavigationMixin(LightningElement )
{
    @api recordId;
  
   get iframeSrc() {

        return '/apex/SampleRequestPDF?id=' + this.recordId;

    }
    handleGeneratePDFAndSendEmail() {

     sendPdf({recordId: this.recordId})
     .then(res=>{

     this.ShowToast('Success', res, 'success', 'dismissable');
    }).catch(error=>{

     
      console.error('Error sending email:', error);

     this.ShowToast('Error', 'Error in send email!!', 'error', 'dismissable');})
     }  
      ShowToast(title, message, variant, mode){
       const evt = new ShowToastEvent({

         title:'Success!',
         message:'Email Send Succesfully and Save As PDF',
         variant: 'success',
          mode: mode
        });
        this.navigateToViewStudentPage();
        this.dispatchEvent(evt);
       
    }
 
    navigateToViewStudentPage() {

        setTimeout(() => {
    
        this[NavigationMixin.Navigate]({
        type: 'standard__recordPage',
        attributes: {
        recordId :this.recordId,
        // Use the Student ID from your component's da
        objectApiName: 'Sample_Request__c',
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