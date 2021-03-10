/*=================================================================================
This web service is to create lead records in salesforce
based on information provided by developer in unity form.
Create by: Preetu Vashista 12/3/2013
===================================================================================*/
global class  DMLLeadWebServiceClass{
global DMLLeadWebServiceClass(){}
/*
    global class RequestClass{
        webservice List<LeadInfo> leadsInfo;
    }
     //Class LeadInfo to define web service parameters
     global class LeadInfo{
         webService String lead_First_Name;
         webService String lead_Last_Name;
         webService String status;
         webService String area_Of_Interest;
         webService String business_Type;
         webService Integer lead_Accepted_Id;
         webService String company;
         webService String company_Address_Line1;
         webService String company_Address_Line2;
         webService String company_Address_Line3;
         webService String company_City;
         webService String company_Country;
         webService String company_Fax;
         webService Integer company_Number_Employee;
         webService String company_Phone_Number;
         webService String company_Post_Code;
         webService String company_State;
         webService String company_Website_Address;
         webService String contact_Email;
         webService String contact_Fax_No;
         webService String contact_Job_Title;
         webService String contact_Phone_No;
         webService String platforms;
         webService String legal_Director_Name;
         webService String legal_status;
         webService String secondary_Contact_Email;
         webService String secondary_Contact_FaxNo;
         webService String secondary_Contact_First_Name;
         webService String secondary_Contact_Last_Name;
         webService String Secondary_Contact_Phone_No;
         webService String Secondary_Contact_Job_Title;
         webService String Enquiry_Status;
         webService String Media_Type;         
    }
    global class LeadRecordResponse{ 
         webService Decimal acceptedUniqueId;
         webService ID leadId;
         webService String enquiryStatus;
         webService String errorMsg;
     
     }
   
     //Method to create lead records in salesforce. The method returns lead Id
  
      webService static List<LeadRecordResponse> createLead(RequestClass req){
          List<Lead> leads = new List<Lead>();
          AssignmentRule AR = new AssignmentRule();
          AR = [select id from AssignmentRule where SobjectType = 'lead' and Active = true limit 1];
          Database.DMLOptions dmlOpts = new Database.DMLOptions();
          System.debug('AR value----->' + AR.id);
          dmlOpts.assignmentRuleHeader.assignmentRuleId= AR.id;
          dmlOpts.EmailHeader.triggerUserEmail = true;
 

          Map<String,ID> recordTypeMap = new Map<String,ID>();
          for(RecordType rt: [select Name,Id from RecordType where SobjectType ='Lead']){
          recordTypeMap.put(rt.Name, rt.Id);
          }            
            
        
        
          System.debug('list size is-->' + recordTypeMap);
          if(recordTypeMap.size()>0){
              for(LeadInfo leadInfo : req.leadsInfo){    
                  if(leadInfo.lead_Last_Name != NULL && leadInfo.area_Of_Interest != NULL && leadInfo.status != NULL && leadInfo.company != NULL && leadInfo.lead_Accepted_Id != NULL && leadInfo.business_Type != NULL
                  && !leadInfo.lead_Last_Name.equals('') && !leadInfo.area_Of_Interest.equals('') && 
                  !leadInfo.status.equals('') && !leadInfo.company.equals('') && leadInfo.lead_Accepted_Id != 0 && !leadInfo.business_Type.equals('')){
                  
                  String streetAddress =  leadInfo.company_Address_Line1 + leadInfo.company_Address_Line2 + leadInfo.company_Address_Line3 ;
                                    
                                  
                  Lead lead = new Lead(FirstName = leadInfo.lead_First_Name, LastName = leadInfo.lead_Last_Name,Enquiry_Status__c = leadInfo.Enquiry_Status,Area_Of_Interest__c = leadInfo.area_Of_Interest, Business_Type__c = leadInfo.business_Type,company = leadInfo.company,
                      Secondary_Contact_First_Name__c=leadInfo.secondary_Contact_First_Name,Secondary_Contact_Last_Name__c = leadInfo.secondary_Contact_Last_Name,Secondary_Contact_Phone__c = leadInfo.Secondary_Contact_Phone_No,Secondary_Contact_Email__c=leadInfo.secondary_Contact_Email,
                      Secondary_Contact_Job_Title__c = leadInfo.Secondary_Contact_Job_Title,Proposed_Distribution_Method__c = leadInfo.Media_Type,Email = leadInfo.contact_Email, Fax = leadInfo.contact_Fax_No,Title = leadInfo.contact_Job_Title,Phone = leadInfo.company_Phone_Number,
                      NumberOfEmployees = leadInfo.company_Number_Employee,street = streetAddress,city = leadInfo.company_City,state = leadInfo.company_state,country = leadInfo.company_Country,Postalcode = leadInfo.company_Post_Code
                   );
                   for(String key: recordTypeMap.keySet()){ 
                                     
                       if(leadInfo.area_Of_Interest.equals('GAMES')){
                           System.debug('---id--->' + recordTypeMap.get('Dev Rel'));
                           lead.recordtypeId = recordTypeMap.get('Dev Rel');
                           lead.status = 'New Sign-up'; 
                       }
                      else if((leadInfo.area_Of_Interest.equals('TOOLS')) || (leadInfo.area_Of_Interest.equals('UNIVERSITY'))){
                            System.debug('---id--->' + recordTypeMap.get('Dev Support'));
                            lead.recordtypeId = recordTypeMap.get('Dev Support');
                            lead.status = 'Prospect';
                      }
                      else if((leadInfo.area_Of_Interest.equals('NON GAME'))||(leadInfo.area_Of_Interest.equals('OTHER'))){
                              System.debug('---id--->' + recordTypeMap.get('SBD'));
                              lead.recordtypeId = recordTypeMap.get('SBD');
                              lead.status = 'Prospect';
                  }
                  /*else if((leadInfo.area_Of_Interest.equals('OTHER'))){
                              System.debug('---id--->' + recordTypeMap.get('SBD'));
                              lead.recordtypeId = recordTypeMap.get('SBD');
                              lead.status = 'Prospect';
                  }*/
                /*  }
                  
                  
                  lead.Accepted_Unique_Id__c = leadInfo.lead_Accepted_Id;
                   
                  lead.setOptions(dmlOpts);

                
                  // To get the list of platforms
                  String[] platformNames = leadInfo.platforms.split( ',\\s*' );                        
                  for( String platform : platformNames){                    
                      if(platform.equals('PS4')){
                          lead.PlayStation4__c = true;
                      }
                      else if(platform.equals('PS3')){
                          lead.Playstation3__c = true;
                      }
                      else if(platform.equals('PSVita')){
                          lead.PlayStation_Vita__c = true;
                      }
                   }
                   leads.add(lead);                             
                 }
                                           
          } 
          }
          List<LeadRecordResponse > insertedLeadList = new List<LeadRecordResponse >();
          try{    
              // Add new leads and add to this lead list then insert as follows             
              Database.SaveResult[] srList = Database.insert(leads, false);            
             // Iterate through each returned result
             set<string> insertedLeadIdSet = new set<string>();
             for(Database.SaveResult sr : srList){
                 if (sr.isSuccess()){
                     string IdValue = string.valueOf(sr.getId());
                     insertedLeadIdSet.add(IdValue);
                 }
             }
        
            map<Id,Lead> insertedLeadMap = new map<Id,Lead>([SELECT Id,Accepted_Unique_Id__c,Enquiry_Status__c from Lead where Id IN : insertedLeadIdSet]);
            if(insertedLeadMap.size()>0){
                for(Database.SaveResult sr : srList){
                    if (sr.isSuccess()){
                    string IdValue = string.valueOf(sr.getId());
                    if(insertedLeadMap.containsKey(IdValue)){
                        Lead l = insertedLeadMap.get(IdValue);
                        LeadRecordResponse leadRecordResponse = new LeadRecordResponse();
                        leadRecordResponse.acceptedUniqueId = l.Accepted_Unique_Id__c;
                        leadRecordResponse.leadId = l.Id;
                        leadRecordResponse.enquiryStatus = l.Enquiry_Status__c;
                        // Operation was successful, so get the ID of the record that was processed                                                                        
                        insertedLeadList.add(leadRecordResponse);                 
                     }
                    }
                   else{
                   LeadRecordResponse leadRecordResponse = new LeadRecordResponse();
                   for(Database.Error err : sr.getErrors()) {
                       System.debug('The following error has occurred while inserting lead records:\n' + err.getStatusCode() + ': ' + err.getMessage());                    
                       leadRecordResponse.errorMsg = err.getStatusCode() + ': ' + err.getMessage();
                   }      
                   insertedLeadList.add(leadRecordResponse);
                 
                   }
               } 
            }    
                
            else{
               
               for(LeadInfo leadInfo: req.leadsInfo){
               LeadRecordResponse leadRecordResponse = new LeadRecordResponse();
               leadRecordResponse.acceptedUniqueId = leadInfo.lead_Accepted_Id;
               leadRecordResponse.errorMsg = 'Accepted_unique_id value is not unique OR required field values are missing. ' + 'Last name is: ' + leadInfo.lead_Last_Name + ', ' + 'Area of Interest is: ' + leadInfo.area_Of_Interest + ', ' + 'Status is: ' + leadInfo.Status + ', ' + 'Lead Accepted id is: ' + leadInfo.lead_Accepted_Id + ', ' + 'Company name is: ' + leadInfo.company + ', ' + 'BusinessType is: ' + leadInfo.business_Type ;
               System.debug('------------>' + leadRecordResponse.errorMsg);
               insertedLeadList.add(leadRecordResponse);
               }
               //insertedLeadList.add(leadRecordResponse); 
            }
          }catch(Exception e){
            system.debug('The following exception has occurred while inserting lead records: ' + e.getMessage());
           }       
             
               return insertedLeadList;
        
     }
   
                        
                */
}