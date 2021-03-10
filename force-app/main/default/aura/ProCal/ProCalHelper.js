({getResponse: function(component) {
   var label=$A.get("$Label.c.OrgLink");
        var action = component.get("c.getTasks");
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var result = response.getReturnValue();
                console.log("Data: \n" + result);
                var eventArr = [];
                var eventArr1 = [];
                var eventArr2 = [];
                var eventArr3 = [];
                var eventArr4 = [];
                var eventArr5 = [];
                var eventArr6 = [];
                var eventArr7 = [];
                var myDateOnly = [];
                var strDate = [];
                result.forEach(function(key) {
                    if(key.AdSales_CF_End_Date__c != undefined && key.AdSales_CF_Start_Date__c != undefined && key.CreatedDate != undefined){
                        //strDate = key.AdSales_CF_End_Date__c.split('-');
                        //var myIntDate = Number(strDate[2]);
                        //var myIntMonth = Number(strDate[1]);
                        //var myIntYear = Number(strDate[0]);
                        //var dd = new Date(myIntYear,myIntMonth - 1,myIntDate);
                        //dd.setDate(dd.getDate() + 1);
                        //key.AdSales_CF_End_Date__c = dd;
                        
                         var toEnddate=new Date(key.AdSales_CF_End_Date__c).getDate();
                       
    					 var toEndmonth=new Date(key.AdSales_CF_End_Date__c).getMonth()+1;
    					 
                         var toEndyear=new Date(key.AdSales_CF_End_Date__c).getFullYear();
                         if((toEnddate.toString()).length === 1){
                                toEnddate = '0'+toEnddate;
                            }
                         if((toEndmonth.toString()).length === 1){
                                toEndmonth = '0'+toEndmonth;
                            }
   						 var endDate=toEndyear+'-'+toEndmonth+'-'+toEnddate;

                        
                         var toStartdate=new Date(key.AdSales_CF_Start_Date__c).getDate();
    					
                         var toStartmonth=new Date(key.AdSales_CF_Start_Date__c).getMonth()+1;
    					
                         var toStartyear=new Date(key.AdSales_CF_Start_Date__c).getFullYear();
   						 
                         if((toStartdate.toString()).length === 1){
                                toStartdate = '0'+toStartdate;
                            }
                         if((toStartmonth.toString()).length === 1){
                                toStartmonth = '0'+toStartmonth;
                            }
                         var startDate=toStartyear+'-'+toStartmonth+'-'+toStartdate;
                         
                        //2019-02-27T15:54:04.000Z
                        var createDate = key.CreatedDate.substring(0,10);
                                                
                        if(key.Opportunity.StageName == 'Opportunity Created'){
                            eventArr1.push({
                                'id':key.Id,
                                'start':key.AdSales_CF_Start_Date__c,
                                'title':key.Product2.Name,
                                'OppName':key.Opportunity.Name,
                                'end':key.AdSales_CF_End_Date__c,
                                'OppOwner':key.Opportunity.Owner.Name,
                                'Stage':key.Opportunity.StageName,
                                'color'  : '#fff2cc',
                                'URL':label+key.OpportunityId ,
                                'startDate':startDate,
                                'endDate':endDate,
                                'AccName':key.AdSales_FF_Account_Name__c,
                                'OppProName' :key.Product2.Name,
                                'CSMName' :key.AdSales_FF_CSM_Name__c,
                                'CreateDate' :createDate
                            });
                        }else if(key.Opportunity.StageName == 'In Negotiation'){
                           eventArr2.push({
                                'id':key.Id,
                                'start':key.AdSales_CF_Start_Date__c,
                                'title':key.Product2.Name,
                                'OppName':key.Opportunity.Name,
                                'end':key.AdSales_CF_End_Date__c,
                                'OppOwner':key.Opportunity.Owner.Name,
                                'Stage':key.Opportunity.StageName,
                                'color': '#ffd966',
                                'URL':label+key.OpportunityId ,
                                'startDate':startDate,
                                'endDate':endDate,
                                'AccName':key.AdSales_FF_Account_Name__c,
                                'OppProName' :key.Product2.Name,
                                'CSMName' :key.AdSales_FF_CSM_Name__c,
                                'CreateDate' :createDate
    
                            });
                        }else if(key.Opportunity.StageName == 'Inventory Reserved'){
                            eventArr3.push({
                                'id':key.Id,
                                'start':key.AdSales_CF_Start_Date__c,
                                'title':key.Product2.Name,
                                'OppName':key.Opportunity.Name,                            
                                'end':key.AdSales_CF_End_Date__c,
                                'OppOwner':key.Opportunity.Owner.Name,
                                'Stage':key.Opportunity.StageName,
                                'color': '#f8cbad',
                                 'URL':label+key.OpportunityId ,
                                'startDate':startDate,
                                'endDate':endDate,
                                'AccName':key.AdSales_FF_Account_Name__c,
                                'OppProName' :key.Product2.Name,
                                'CSMName' :key.AdSales_FF_CSM_Name__c,
                                'CreateDate' :createDate
    
                            });
                        }else if(key.Opportunity.StageName == 'In Contract'){
                            eventArr4.push({
                                'id':key.Id,
                                'start':key.AdSales_CF_Start_Date__c,
                                'title':key.Product2.Name,
                                'OppName':key.Opportunity.Name,                            
                                'end':key.AdSales_CF_End_Date__c,
                                'OppOwner':key.Opportunity.Owner.Name,
                                'Stage':key.Opportunity.StageName,
                                'color': '#f4b084',
                                 'URL':label+key.OpportunityId ,
                                'startDate':startDate,
                                'endDate':endDate,
                                'AccName':key.AdSales_FF_Account_Name__c,
                                'OppProName' :key.Product2.Name,
                                'CSMName' :key.AdSales_FF_CSM_Name__c,
                                'CreateDate' :createDate
    
                            });
                        }else if(key.Opportunity.StageName == 'Closed Won'){
                            eventArr5.push({
                                'id':key.Id,
                                'start':key.AdSales_CF_Start_Date__c,
                                'title':key.Product2.Name,
                                'OppName':key.Opportunity.Name,                            
                                'end':key.AdSales_CF_End_Date__c,
                                'OppOwner':key.Opportunity.Owner.Name,
                                'Stage':key.Opportunity.StageName,
                                'color': '#92d050',
                                 'URL':label+key.OpportunityId ,
                                'startDate':startDate,
                                'endDate':endDate,
                                'AccName':key.AdSales_FF_Account_Name__c,
                                'OppProName' :key.Product2.Name,
                                'CSMName' :key.AdSales_FF_CSM_Name__c,
                                'CreateDate' :createDate
    
                            });
                        }else if(key.Opportunity.StageName == 'Closed Lost'){
                            eventArr6.push({
                               'id':key.Id,
                                'start':key.AdSales_CF_Start_Date__c,
                                'title':key.Product2.Name,
                                'OppName':key.Opportunity.Name,                            
                                'end':key.AdSales_CF_End_Date__c,
                                'OppOwner':key.Opportunity.Owner.Name,
                                'Stage':key.Opportunity.StageName,
                                'color': '#999900',
                                 'URL':label+key.OpportunityId ,
                                'startDate':startDate,
                                'endDate':endDate,
                                'AccName':key.AdSales_FF_Account_Name__c,
                                'OppProName' :key.Product2.Name,
                                'CSMName' :key.AdSales_FF_CSM_Name__c,
                                'CreateDate' :createDate
    
                            });
                        }else if(key.Opportunity.StageName == 'Proposal Sent to Account'){
                            eventArr7.push({
                                'id':key.Id,
                                'start':key.AdSales_CF_Start_Date__c,
                                'title':key.Product2.Name,
                                'OppName':key.Opportunity.Name,                            
                                'end':key.AdSales_CF_End_Date__c,
                                'OppOwner':key.Opportunity.Owner.Name,
                                'Stage':key.Opportunity.StageName,
                                'color': '#ffe699',
                                 'URL':label+key.OpportunityId ,
								'startDate':startDate,
                                'endDate':endDate,
                                'AccName':key.AdSales_FF_Account_Name__c,
                                'OppProName' :key.Product2.Name,
                                'CSMName' :key.AdSales_FF_CSM_Name__c,
                                'CreateDate' :createDate
    
                            });
                        }
                }
                        
                });
                eventArr= eventArr1.concat(eventArr2);
                eventArr= eventArr3.concat(eventArr);
                eventArr= eventArr4.concat(eventArr);
                eventArr= eventArr5.concat(eventArr);
                eventArr= eventArr6.concat(eventArr);
                eventArr= eventArr7.concat(eventArr);
                console.log(eventArr);
                this.loadCalendar(eventArr, component);
                
            } else if (state === "INCOMPLETE") {
            } else if (state === "ERROR") {
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        console.log("Error message: " + errors[0].message);
                    }
                } else {
                    console.log("Unknown error");
                }
            }
        });
        $A.enqueueAction(action);
    },
    
    loadCalendar :function(data, component){   
        var m = moment();
        
      
            $('#calendar').fullCalendar({
            header: {
                left: 'prev,next,today',
                center: 'title',
                right: 'month,agendaWeek,agendaDay'
            },
                
            events:data,
               /* customButtons: {
                    myCustomButton: {
                        text: 'Jump to date',
                        click: function() {
                            $("#calendar").fullCalendar('gotoDate', moment());
                            
                        }
                    }
                }, */   
            
                eventClick:  function(event, jsEvent, view) {
                    var table = "<table>";
                    var body = table + '<tr><td><b>Product Name </b>: '+event.title+'</td><td><b>Opportunity Name </b>: '+event.OppName+'</td></tr><tr><td><b>Opportunity Owner </b>: '+event.OppOwner+'</td><td><b>Opportunity Stage </b>: '+event.Stage+'</td></tr><tr><td><b>Account Name </b>: '+event.AccName+'</td><td><b>Client Solution Manager </b>: '+event.CSMName+'</td></tr><tr><td><b>Opportunity Product Start Date </b>: '+event.startDate+'</td><td><b>Opportunity Product End Date </b>: '+event.endDate+'</td></tr><td><b>Opportunity Product Created Date </b>: '+event.CreateDate+'</td></tr>';
                    var body = body + "</table>";
                    $('#modalTitle').html("Opportunity Product");
                    $('#modalBody').html(event.title);
                    $('#modalBody').html(body);
                    $('#eventUrl').attr('href',event.URL);
                    $('#fullCalModal').modal();
                },
                
                                
        	
            defaultDate: m.format(),
            editable: true,
            navLinks: true, // can click day/week names to navigate views
            weekNumbers: true,
            weekNumbersWithinDays: true,
            weekNumberCalculation: 'ISO',
            editable: true,
            eventLimit: true,
          // displayEventTime : false,
            
            
        });
        component.set("v.isOpen", true);
        component.set("v.Objectgrid", data);
       
        $('#months-tab').on('change', function() {
            var month = $(this).find(":selected").attr('data-month'),
            year = $("#calendar").fullCalendar('getDate').format('YYYY');
            var m = moment([year, month, 1]).format('YYYY-MM-DD');
            $('#calendar').fullCalendar('gotoDate', m );
        });
        $("#prev-year").on('click', function() {
            $('#calendar').fullCalendar( 'prevYear' );
        });
        $("#next-year").on('click', function() {
            $('#calendar').fullCalendar( 'nextYear' );
        });
        var month = $("#calendar").fullCalendar('getDate').format('MM') -1 ;
        // set the correct month selected
        $("#months-tab").find('option[data-month=' + month + ']').prop('selected', true);

       
    },


})