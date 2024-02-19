/*
Author: Kinen Cardoza
Main class: PH_LeadToDistributerEmailHandler
Created Date: 2/9/2024


Purpose:
The PH_LeadToDistributerEmailHandler class is procedural and straightforward where its only purpose is to send an email. 
It does not contain any variation branches that lead to different outcomes.

*/


@isTest
public class PH_LeadToDistributerEmailHandlerTest {
    @isTest
    public static void PH_LeadToDistributerEmailHandlerTest_1() {
        
        List<PH_LeadToDistributerEmailHandler.flowInputs> classParameter = new List<PH_LeadToDistributerEmailHandler.flowInputs>();

        PH_LeadToDistributerEmailHandler.flowInputs input = new PH_LeadToDistributerEmailHandler.flowInputs();
        input.distributerEmail = 'test@gmail.com'; 
        //input.emailTemplateID = '00XD5000000PSdxMAG'; 
        //input.leadID = '00QD500000AD6k6MAD'; 
        
        Lead l = new Lead(FirstName='Test',LastName='lead', Company='abc');
        insert l;
        
        Id leadRecordId = l.Id;
        input.leadID =leadRecordId;
        input.emailTemplateID =[SELECT Id FROM EmailTemplate WHERE DeveloperName  = 'PH_default_English_email_for_distributers' LIMIT 1].Id;

        

        
        classParameter.add(input);
        Test.startTest();
        PH_LeadToDistributerEmailHandler.sendEmailToDistributer(classParameter);
        Test.stopTest();
    }
}
