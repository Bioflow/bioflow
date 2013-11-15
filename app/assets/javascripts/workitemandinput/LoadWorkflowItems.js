/***********
' * The global job ID to be used with all requests
 */
var job_id = ""
var outputVisible = false	
var workitemsFromServer = new Array();
/************
 * 
 * workitemsFromServer: Array[6]
	0: Object
	    category: "Discovery"
		created_at: "2012-06-27T19:15:57Z"
		id: 5
		isparent: false
		itemid: "toolz"
		name: "Discover"
		parent: "root"
		summary: "Summary"
		totalinputs: 1
		totaloutputs: 1
		updated_at: "2012-06-27T19:15:57Z"
 * 
 * 
 */


var workitemsOnClient = new Array();
/***
 * 
 * 
 * 
 * 
 * 	workitemsOnClient: Array[0]
	length: 0
	widget3: Object
		category: "Input"
		created_at: "2012-07-03T19:43:20Z"
		id: 6
		isparent: false
		itemid: "input_bamfile"
		name: "BAMFile"
		parent: "root"
		summary: "BAM Input File"
		totalinputs: 1
		totaloutputs: 1
		updated_at: "2012-07-03T19:43:20Z"
 *
 */

/**
 * Saves connections made by jsplumb
 */
var connections = [];



function getworkflowitems() {
	$.ajax({
		beforeSend: function(xhr) {
		    xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'));
		  },
		type : "POST",
		url : "/workflow_item/load?format=json",
		contentType : "application/json; charset=utf-8",
		dataType : "json",
		success : function(result) {
			//console.log("Loaded items from server are")
			//console.log(result)
			workitemsFromServer = result;

		}

	});
}

function getDraggedObj(draggedid ) {
	//console.log("Dragged id is")
	//console.log(draggedid)
	for (i = 0; i < workitemsFromServer.length; i++) {
		//console.log("id from server is "+workitemsFromServer[i].itemid);
				if (workitemsFromServer[i].itemid == draggedid) {
					var oldObject = workitemsFromServer[i]; 
					var newObject = jQuery.extend({}, oldObject);
					return newObject;
				}		
		
		
	}
}



function removeWorkflowItem(widgetid) {
	$.ajax({
		beforeSend: function(xhr) {
		    xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'));
		  },
		type : "POST",
		url : "/workflow_item/removeWorkflowitem?widgetId="+widgetid+"&jobId="+job_id,
		success : function(result) {

				console.log(result);
				
				
		}

	});
}
function newWorkflowItemAdded(workflowitem, widgetId, isrestore) {

	var idOfItem = workflowitem.itemid
	if(idOfItem =="user_saved_job") {
		//need to change this to create new ITEMIDs in the database itself
		
		//console.log(workflowitem.name)
		idOfItem = idOfItem + "_" + workflowitem.name
		
		
	}
	//console.log(idOfItem)
	
	
	$.ajax({
		beforeSend: function(xhr) {
		    xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'));
		  },
		type : "POST",
		url : "/workflow_item/newWorkflowitemAdded?id="+idOfItem+"&widgetId="+widgetId+"&jobId="+job_id+"&isrestore="+isrestore,
		success : function(result) {

				//console.log(result);
				
				updateEastAccordion(result);
		}

	});
}



function updateEastAccordion(htmlForEastAccordion) {
	$("#eastaccordion").append(htmlForEastAccordion).accordion('destroy').accordion({
	    collapsible: true, 
	    autoHeight: false, 
	    animated: 'swing',
	    
	});
//	accordionise();
}


/**
 * Send data to server and try to make sense of the connections array
 */
function runbuttonclicked(server) {
	
	$("#error_notify").html('&nbsp;')
	$("#runbutton").attr("disabled", true);
	$("#saveuicoordinates").attr("disabled", true);
	//setup 1 minute interval polling for job outputs and statuses
	var runurl = "/workflow_item/runTheJobsNow"
		
	if(server != null) {
		runurl +="?server="+server
	}
	
	//console.log("Remember to fix this bug ----- PASS THE JOB ID")
	
	$.ajax({
		beforeSend: function(xhr) {
		    xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'));
		  },
		type : "POST",
		url : runurl,
		dataType : "json",
	
		success : function(result) {
			
			if ( result['status'] == "Success")  {
				setUpPollingTask()

			} else {
				$("#runbutton").attr("disabled", false);
				$("#saveuicoordinates").attr("disabled", true);

				$("#error_notify").text(result['message'])
				return;
			}
				
			var json_string = $.parseJSON( result );

			updateNotifications(null, result);

		}
	});
	
	
	
	
	//Run once.
	//TODO : Remove
	pollingTask();
	
	
}


/**
 * Clear the session - delete stale objects left over from a session
 * before page refresh
 */
function clearbuttonclicked() {
	
	$.ajax({
		beforeSend: function(xhr) {
		    xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'));
		  },
		type : "POST",
		url : "/workflow_item/clearSession",
//			contentType : "application/json; charset=utf-8",
		dataType : "json",
		
		success : function(result) {
			
			//console.log("session cleared")

		}
	});
	
	
	
	
	
}


/**
 * 
 * Submit the form in EAST
 */
function submitForm(form_id) {
		//console.log("formid="+form_id)
	
		var values = $("#"+form_id).serialize();
		//console.log(values);
	
		$.ajax({
				beforeSend: function(xhr) {
				    xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'));
				  },
				type : "POST",
				url : "/workflow_item/formsubmit?"+"formId="+form_id+"&"+values,
	//			contentType : "application/json; charset=utf-8",
				dataType : "json",
				data:$('#'+form_id).serialize(),
				success : function(result) {
					
					var status  = result['status']
					if(status == "Success") {
						updateNotifications(null, result['message'])
					} else {
						$("#error_notify").text(result['message'])
					}
					
					//console.log("status="+status)
					//console.log("form submitted")
					//console.log(result)	
				}
			});
		
	
	
} 


function updateConnectionsOnServer( from_Id,  to_Id, fromAnchorType, toAnchorType, isDetached) {
	
	//console.log("from-"+from_Id)
	//console.log("to-"+to_Id)
	
	$.ajax({
		beforeSend: function(xhr) {
		    xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'));
		  },
		type : "POST",
		url : "/workflow_item/newConnectionAdded?from="+from_Id+"&to="+to_Id+"&fromAnchor="+fromAnchorType+"&toAnchor="+toAnchorType+"&isDetached="+isDetached,
//			contentType : "application/json; charset=utf-8",
		dataType : "json",
		
		success : function(result) {
			
			//alert("New connection added")
			//alert(result)

		}
	});

	
}



var myTimer;
var fakeCount = 0;
function setUpPollingTask() {
	myTimer = setInterval(pollingTask, 20000)
}

var keepPolling = true

function pollingTask() {
	//console.log("polling with job_id ="+job_id)
	$.ajax({
		beforeSend: function(xhr) {
		    xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'));
		  },
		type : "POST",
		//url : "/workflow_item/getJobStatuses",
		url: "/workflow_item/retrieve_notifications?jobId="+job_id,
		dataType : "json",		
		success : function(result) {
			
			//console.log("output from polling task "+result)
			
			updateNotifications(result['notifications'],null)
			
			var status = result['status']
			
			console.log("STATUS IS"+status)
			
			
			if(status=="COMPLETE") {
				
				$("#mainjobstatus").text("Complete")
				//console.log("JOB_COMPELTE")
				//console.log("Clearing interval")
				clearInterval(myTimer)
			} else if(status == "RUNNING") {
				$("#mainjobstatus").text("Running")
			}
		}
	});

}




function viewOutput(widget_id_local) {
	//console.log("#"+widget_id_local + "_theOutputDiv")
	$("#"+widget_id_local + "_theOutputDiv").animate({width:'toggle'},1);
	if (!e) var e = window.event;
    e.cancelBubble = true;
    if (e.stopPropagation) e.stopPropagation();
    
    
    
    
    $.ajax({
		beforeSend: function(xhr) {
		    xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'));
		  },
		type : "POST",
		url : "/workflow_item/getJobOutput?widget_id="+widget_id_local+"&jobId="+job_id,
		success : function(result) {
			
			console.log("output from getJobOutput "+result)
			$("#"+widget_id_local + "_theOutputDiv").html(result)
			$("#"+widget_id_local + "_theOutputDiv").css("position","relative")
			$("#"+widget_id_local + "_theOutputDiv").css("top","30px")
			
		}
	});
    
    
} 



function startnewjob() {
	
	console.log("Starting new job...")
	
	$.ajax({
		beforeSend: function(xhr) {
		    xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'));
		  },
		type : "POST",
		url : "/workflow_item/startnewjob",
		success : function(result) {
			
			job_id = result['job_id']
			notification = result['notification']
			updateNotifications(null, notification)
			console.log("Started new  job   --" +job_id)
			console.log("Notification       --" +notification)
			
			create_form_for_job(job_id)
			
		}
	});
	
	
}


function saveThisjob() {
	
	$.ajax({
		beforeSend: function(xhr) {
		    xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'));
		  },
		type : "POST",
		url : "/workflow_item/savethejob?jobId="+job_id,
		success : function(result) {
			
			
			console.log(result)
			
		}
	});
	
	
}


var htmlFromServer = "";

function getHtmlFromServer(widgetId, object ) {
	$.ajax({
		beforeSend: function(xhr) {
		    xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'));
		  },
		type : "POST",
		url : "/workflow_item/gethtmlforwidget?jobId="+job_id+"&widgetid="+widgetId+"&objectname="+object.name,
		async: false,
		success : function(result) {
			htmlFromServer = result
			console.log(result)
		}
	});
}



function createCommandline() {
	
	$( "#dialog" ).remove();
	$.ajax({
		beforeSend: function(xhr) {
		    xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'));
		  },
		type : "POST",
		url : "/workflow_item/createShellCommands?jobId="+job_id,
		async: false,
		success : function(result) {
			var dialogg = '<div id="dialog" title="Basic dialog" style="border:1px solid red;width:100%;position:absolute;bottom:0">';
			
			for(var i =0; i < result.length ; i++) {
				dialogg+= '<br>' + result[i];
			}
			dialogg+= '</div>';
				
			$( "#content-inner" ).append(dialogg);
			console.log(dialogg);
		}
	});
	
}

function showFormForJobParams() {
	
	$("#dialog-widget").remove();
	
	var html_string  =  '<div id="dialog-widget" title="Job Details" style="padding:20px;">' 
		html_string  +=  '<form style="width:300px" id="job_from">' 
		html_string  += 'Job Details<br>' 
		html_string  += '<label style="width:80px;display:inline-block;" >Job Name </label> : ' 
		html_string  +=						 		'<input type="text" name="widget_name" id="widget_name" ><br>'
		html_string  += '<label style="width:80px;display:inline-block;">Job Summary  </label> : ' 
		html_string  += '<input type="text" name="widget_summary" id="widget_summary" placeholder="<summary>"  ><br>'  
					    
		//html_string  +=	'<button type="button" name="submit" id="job_button"    onClick="saveUiCoordinates()"> Save'
		
		html_string  += '</button>'
		//html_string  +='<br>'
		//html_string  +='</form>' 
				   
		html_string  += '</div>'
	
		var rightPanelBody =$( "#rightPanel");
       	var yyyy =$('center-panel');
       	
       	rightPanelBody.append(html_string);
       	console.log(html_string)
       	//	alert(html_string)
       	//	$(this).append(html_string)
       	$("#dialog-widget").dialog({
       		buttons: {
                "Save": function() {
                	var widget_name = $("#widget_name").val()
                	//alert(widget_name)
                	var widget_summary = $("#widget_summary").val()
                	//alert(widget_summary)
                	error = false
                	if (widget_name == null || widget_name.length == 0) {
                    	$("#widget_name").css("border", "1px solid red");
                    	error = true
                    } else {
                    	$("#widget_name").css("border", "none");
                    }
                	
                	if (widget_summary == null || widget_summary.length == 0) {
                    	$("#widget_summary").css("border", "1px solid red");
                    	error = true
                    } else {
                    	$("#widget_summary").css("border", "none");
                    }
                	
                	if (!error) {
                		saveUiCoordinates(widget_name, widget_summary)
                		rightPanelBody.remove(html_string);
                	}
                		
                		
                }
                
       		}
       	});
	
	
}


function saveUiCoordinates(widget_name_new, widget_summary_new) {
	var w = workitemsOnClient;
	var xx = JSON.stringify(workitemsOnClient);
	
	somearray = new Array();
	somearray[0] = "one";
	somearray[1] = "two";
	var ttt = JSON.stringify(somearray);
	
	
	myWidgetsData = new Array();
	
	
	for(var prop in workitemsOnClient) {
		
		console.log(prop);
		console.log(workitemsOnClient[prop]);
		myWidgetsData.push(workitemsOnClient[prop]);
	}
	
	
	$.ajax({
		beforeSend: function(xhr) {
		    xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'));
		  },
		type : "POST",
		data: "widget="+JSON.stringify(myWidgetsData),
		dataType : "json",
		url : "/workflow_item/saveUiCoordinates?jobId="+job_id+"&widgetname="+widget_name_new+"&widgetsummary="+widget_summary_new,
		async: false,
		success : function(result) {
			/*for(var prop in workitemsOnClient) {
				
				var pos = $("#"+prop).position()
				console.log("pos=")
				console.log(pos.left+" "+pos.top)
				
				 $("#"+prop).css({
				        position: "absolute",
				        top: pos.top +100 + "px",
				        left: (pos.left + 100) + "px"
				    }).show();
				//jsPlumb.repaintEverything();
				
			}*/
			console.log(result);
			alert("Workflow has been saved");
			location.reload();
		}
	});
	
	
	
	
}
function restorejob() {
	//First get the list of jobs to show
	
	
	$.ajax({
		beforeSend: function(xhr) {
		    xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'));
		  },
		type : "POST",
		url : "/workflow_item/getJobsToRestore?jobId="+1711,
		async: false,
		success : function(result) {
			console.log(result);
			
			var html_div = '<div id="dialog-message" title="Select Job to Restore  ">'
				html_div += '<select name="job_id" class="combo_style" onchange="restorejob1261(this.value)" >'
				for(var  i=0;i  < result.length; i++) {
					html_div += '<option>'+result[i].job_id+'</option>'
				}
			html_div += '</select></div>'
			
			
			var rightPanelBody =$( "#rightPanel");
	       	var yyyy =$('center-panel');
	       	
	       	rightPanelBody.append(html_div);
			//$(this).append(html_div);
			$("#dialog-message").dialog();
			
			
		}
	});
	
	
	
}

function restorejob1261(selected_job) {
	
	$("#dialog-message").remove();
	
	$.ajax({
		beforeSend: function(xhr) {
		    xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'));
		  },
		type : "POST",
		url : "/workflow_item/restorejob?jobId="+selected_job,
		async: false,
		success : function(result) {
			console.log(result);
			//startnewjob();
			
			restore_job(result);
		}
	});
	
	
}


function restore_job(jobData) {
	console.log("the jobdata recieved from server is -- start")
	console.log(jobData)
	console.log("the jobdata recieved from server is -- end")
	
	
	var jobContents  = jobData.jobContents
	var workflowObjs = jobContents.workflowObjects
	var connections  = jobContents.connections
	
	for(var prop in workflowObjs) {
		console.log("inside for loop")
		console.log(prop);
		var str = prop.split("_")
		var widgetId = str[str.length - 1]
		var item_id = ""
		for(var i =0; i < str.length - 1; i++) {
			if (item_id != "") {
				item_id += "_"
			}
			item_id += str[i];
		}
		
		var posX    		= workflowObjs[prop].posX
		var posTop  		= workflowObjs[prop].posTop
		var currentItem    	= workflowObjs[prop]
		
		//var discard_widgetId = generateNextId();
		
		var obj ;
		for(var i =0; i < workitemsFromServer.length; i++) {
			if(workitemsFromServer[i].itemid == item_id) {
				obj = workitemsFromServer[i];
			}
		}
		
		output = getHTMLForDroppable(widgetId, obj);

		var newWidget = output[0];
       	var totalinputs = output[1];
       	
       	var rightPanelBody =$( "#rightPanel");
       	var yyyy =$('center-panel');
       	
       	rightPanelBody.append(newWidget);
       	
       	$('#'+widgetId).css({/*border:'1px solid red',*/position:'absolute',left:posX,top:posTop});
       	
		
       	
       	/*if(totalinputs == 0) {
       		var e3 = jsPlumb.addEndpoint(widgetId, endpoint_right);
       		makeDraggable(".inputItem_file");
       	} else {
       		var i = 0 ;
       		while(totalinputs >= 0) {
       			totalinputs--
       			jsPlumb.addEndpoint(widgetId, inputEndpoints[i]);
       			i++
       		}
       		
       		makeDraggable(".workAndInput_New");
       	}*/
		
		//Tell server to send back HTML for the EAST accordion
       	console.log("OBJECT beign added to workitemsonclient is")
       	console.log(obj)
       	workitemsOnClient[widgetId] = obj;
       	workitemsOnClient[widgetId].widgetid = widgetId;
       	workitemsOnClient[widgetId].posX = posX;
       	workitemsOnClient[widgetId].posTop = posTop;
       	
       	addRemoveIcon(widgetId)
       	
       	//Add the jsPlumb endpoints
       	addEndpoints(totalinputs, widgetId)
       	
       	newWorkflowItemAdded(obj, widgetId, "yes");
		
		// Repaint jsPlumb to fix the 1px misalignment
		//jsPlumb.repaintEverything();
		
		
		
		//NOW MAKE THE CONNECTIONS
		
		
		
		
		
		
	}
	console.log("CONNECTIONS ARE")
	console.log(connections)
	
	
	
	
	for(var i =0; i < connections.length; i++) {
		var prop = connections[i]
		console.log(prop)		
		
		console.log("individual stuff")
		console.log(prop[0])
		console.log(prop[1])
		var from_id 	= prop[0].id
		console.log(from_id)
		
		var from_anchor = prop[0].anchor
		console.log(from_anchor)
		
		var to_id	 	= prop[1].id
		console.log(to_id)
		
		var to_anchor	= prop[1].anchor
		console.log(to_anchor)
		
		
		
		if(from_id != null && to_id != null ) {
			var fromDiv = from_id.split("_")[1]
			var toDiv 	= to_id.split("_")[1]
			//var from_id = str[str.length - 1]
			
			
			var ep_from
			var ep_to
			var sourceEnds = jsPlumb.getEndpoints(fromDiv)
			var targetEnds = jsPlumb.getEndpoints(toDiv)
			
			console.log(sourceEnds)
			console.log(targetEnds)
			
			console.log("Anchors?")
			
			for(var p=0; p < sourceEnds.length; p++ ) {
				if(sourceEnds[p].anchor.type == from_anchor) {
					ep_from = sourceEnds[p];
					break;
				}
			}
			
			
			
			for(var p=0; p < targetEnds.length; p++ ) {
				if(targetEnds[p].anchor.type == to_anchor) {
					ep_to = targetEnds[p];
					break;
				}
			}
				
				
				
				jsPlumb.connect({
					source: ep_from,
					target: ep_to,
					
				});
		}
			
			
			
			
			
	
		}
		
				
	}







function updateNotifications(resultArray, resultString) {
	
	if(resultArray != null) {
		var s = "<table  cellpadding=10 class='notifications_table'>"
		for (var j = 0; j < resultArray.length; j++) {
			s = s + "<tr style='border-bottom: 2px solid #474747'><td style='border:1px solid;margin:2px;'>" + resultArray[j] + "</td>" + "</tr>";
		}
		s += "</table>"
		$("#notifications").html(s);	
	} else {
		var s = "<table  cellpadding=10 class='notifications_table'>"
		s = s + "<tr style='border-bottom: 2px solid #474747'><td>" + resultString + "</td> </tr>";
		
		$("#notifications").append(s);
	}
	
	
	var height = $('#notifications')[0].scrollHeight;
	$('#notifications').scrollTop(height);
	
}

function create_form_for_job(restore_job_id) {
	
	if(restore_job_id == null)
	{
		jobid = job_id
	} else {
		jobid = restore_job_id
	}
		 
	
	$.ajax({
		beforeSend: function(xhr) {
		    xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'));
		  },
		type : "POST",
		url : "/workflow_item/create_form_for_job_name?job_id="+jobid,
		contentType : "application/json; charset=utf-8",
		dataType : "json",
		success : function(result) {
			console.log("Created form for job name and stuff")
			console.log(result)
			
			$("#job_nameAndSummary").append(result)
			
		}

	});
}

function showOrHideOutput() {
	if(outputVisible) {
		outputVisible = false
		innerLayout.show('west')
		innerLayout.show('east')
		myLayout.hide('east')
		myLayout.sizePane('east', 600)
		clearInterval(myResultsTimer)
	} else {
		outputVisible = true
		innerLayout.hide('west')
		innerLayout.hide('east')
		myLayout.show('east')
		myLayout.sizePane('east', 600)
		setUpPollingTaskForJobResults()
		getJobDetails(job_id , "outputdiv")
	}
}


function viewCurrentJobOutput() {
	
	getJobDetails(job_id , "outputdiv")
	
	
}

var myResultsTimer

function setUpPollingTaskForJobResults() {
	myResultsTimer = setInterval(pollingTaskForJobResults, 20000)
}

function pollingTaskForJobResults() {
		getJobDetails(job_id , "outputdiv")


}



function viewCurrentJobOutput_2086() {
	
	if(outputVisible) {
		outputVisible = false
		innerLayout.show('west')
		innerLayout.show('east')
		myLayout.hide('east')
		myLayout.sizePane('east', 600)
	} else {
		outputVisible = true
		innerLayout.hide('west')
		innerLayout.hide('east')
		myLayout.show('east')
		myLayout.sizePane('east', 600)
	}
	
	getJobDetails('job_id_2086' , "outputdiv")
}

