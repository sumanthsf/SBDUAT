({
	scriptsLoaded : function(component, event, helper) {
        helper.getResponse(component);
    },
    scriptsLoaded1 : function(component, event, helper) {
		console.log('javaScript files loaded successful'); 
	},
    
    handleClick : function(component, event, helper) {
        var buttonstate = component.get("v.buttonstate");
        component.set("v.buttonstate",!buttonstate);
        if(!buttonstate){
            $("#listcalendar").show();
            $("#calendar").hide();
			$("#prev-year").hide();
            $("#next-year").hide();
            $("#months-tab").hide();
            $("#listcalendar").fullCalendar({
                defaultView: "listWeek",
                listDayFormat : false,
                weekNumberCalculation: 'ISO',
                events : component.get("v.Objectgrid"),
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
            });
            
        }else{
            $("#calendar").show();
            $("#listcalendar").hide();
          	$("#prev-year").show();
            $("#next-year").show();
            $("#months-tab").show();
          
        }
    },
    
   
    
    
})