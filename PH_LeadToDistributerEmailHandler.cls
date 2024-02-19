/*
Author: Kinen Cardoza (kcardoza@a5corp.com)
Test class : PH_LeadToDistributerEmailHandlerTest
Created Date: 2/9/2024

Purpose: 
This apex class is used in conjuction with the PH_Lead_Send_Email_to_Distributor flow. 
It takes inputs from the flow such as the lead ID, distributer email and template ID and uses them as parameters in the SingleEmailMessage method.

*/

public class PH_LeadToDistributerEmailHandler{
       
    @Invocablemethod (label='Sends email to the distributer account related to a lead')
    public static void sendEmailToDistributer(List<flowInputs> leadEmailParameters){

// takes the 3 Lists (FlowInputs) passed from the flow and assigns to local variables.        
        List<String> distributerEmail=new List<String>();
        distributerEmail.add(leadEmailParameters[0].distributerEmail);
        
        
        Id emailTemplateID= leadEmailParameters[0].emailTemplateID;
        Id leadID= leadEmailParameters[0].leadID;

// creates an instance of the Messaging.SingleEmailMessage object  
        Messaging.SingleEmailMessage email_instance= new Messaging.SingleEmailMessage();
// creates an (List) instance of the Messaging.SingleEmailMessage object
        List<Messaging.SingleEmailMessage> email_instance_list= new List<Messaging.SingleEmailMessage>();

// assigns values to parameters in email_instance
        email_instance.setTemplateId(emailTemplateID);
        email_instance.setToAddresses(distributerEmail);
// takes the lead Id as Recipient Id. This is required when using an email template. Access to merge fields in the template are possible with this. 
        email_instance.setTargetObjectId(leadID);
// the setTreatTargetObjectAsRecipient() is set to false. When false the email won't be sent to the lead. Default value is true. 
        email_instance.setTreatTargetObjectAsRecipient(false);
// queries through the OrgWideEmailAddress and gets the Id for the 'noreply@support.parker.com'.          
        ID noReplyAddressId = [SELECT Id FROM OrgWideEmailAddress where Address = 'noreply@support.parker.com' LIMIT 1].Id;
        email_instance.setOrgWideEmailAddressId(noReplyAddressId);
        
        email_instance_list.add(email_instance);
        
        /*
        System.debug('emailtemplateid:'+ emailTemplateID);
        System.debug('leadid:'+ leadID);
        System.debug('noReplyAddressId:'+ noReplyAddressId);
        System.debug('distributerEmail:'+ distributerEmail);
        */
        
//The sendEmail() method here takes input as a list.   
        Messaging.sendEmail(email_instance_list);
     
    }
    
// inner class for passing variables from the flow to apex code   
    public class flowInputs{
        @Invocablevariable
        public String distributerEmail;
        
        @Invocablevariable
        public Id emailTemplateID; 

        @Invocablevariable
        public Id leadID; 
    }
}