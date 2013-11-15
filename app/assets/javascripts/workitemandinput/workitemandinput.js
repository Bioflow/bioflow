	var colorOfEndpoint = "#C0C0C0"
	//var colorOfEndpoint = "#E8E8E8"
	//var inputEndPointColor = "#0085B2"
	var inputEndPointColor  = colorOfEndpoint
	var outputEndPointColor = "#C0C0C0"
	var connectorBorderColor = "#5e5e5e"
	var	restoreJobPosX = 0
   	var	restoreJobPosY = 0
var exampleDropOptions = {
			tolerance:'touch',
			hoverClass:'hover'/* ,
			activeClass:'dragActive' */
		};
	
	var connectorPaintStyle = {
			lineWidth:10,
			strokeStyle:"#C0C0C0",//"#002cb2",//"#75ea18",
			joinstyle:"round",
			outlineColor:connectorBorderColor,
			outlineWidth:2
		};
	

var endpoint2 = {
			//isSource:true,
			endpoint: [ "Dot", { radius:10 } ],
	        maxConnections:1,
	        isTarget:true,
	        connectorStyle:connectorPaintStyle,
	        //dropOptions:{ tolerance:"touch",hoverClass:"dropHover" }
	        connector:[ "Flowchart", { stub:40, gap:00 } ],
			connectorStyle:connectorPaintStyle,
			dropOptions : exampleDropOptions,
			 paintStyle : {
		        	fillStyle : "black"
		        	//outlineWidth:10,
		        	//outlineColor:"white"
				
		        },
				//id:"endpoint2"
	    };
	
	
	var endpoint_right = {
			isSource:true,
			endpoint:["Dot", { radius:10 } ],
	        maxConnections:1,
	      //  isTarget:true,
	        anchors : "RightMiddle",
	        dropOptions:{ hoverClass:"hover"},
	        connector:[ "Flowchart", { stub:40, gap:10 } ],
	        connectorStyle:connectorPaintStyle,
	        paintStyle : {
	        	fillStyle : colorOfEndpoint
	        	//outlineWidth:10,
	        	//outlineColor:"white"
			
	        }
	    };
	
	var output_endpoint_1 = {
			isSource:true,
			endpoint:["Dot", { radius:10 } ],
	        maxConnections:1,
	      //  isTarget:true,
	        anchors : "RightMiddle",
	        //dropOptions:{ hoverClass:"hover"},
	        dropOptions : {drop:function(e, ui) { alert('drop!'); }},
	        connector:[ "Flowchart", { stub:40, gap:10 } ],
	        connectorStyle:connectorPaintStyle,
	        paintStyle : {
	        	fillStyle : colorOfEndpoint
	        	//outlineWidth:10,
	        	//outlineColor:"white"
			
	        },
	        parameters : {"input_id": "tobeset_Later"}
	    };
	var output_endpoint_2 = {
			isSource:true,
			endpoint:["Dot", { radius:10 } ],
	        maxConnections:1,
	      //  isTarget:true,
	        anchors : "BottomRight",
	        dropOptions:{ hoverClass:"hover"},
	        connector:[ "Flowchart", { stub:40, gap:10 } ],
	        connectorStyle:connectorPaintStyle,
	        paintStyle : {
	        	fillStyle : colorOfEndpoint
	        	//outlineWidth:10,
	        	//outlineColor:"white"
			
	        },
	        parameters : {"input_id": "tobeset_Later"}
	    };
	var output_endpoint_3 = {
			isSource:true,
			endpoint:["Dot", { radius:10 } ],
	        maxConnections:1,
	      //  isTarget:true,
	        anchors : "TopRight",
	        dropOptions:{ hoverClass:"hover"},
	        connector:[ "Flowchart", { stub:40, gap:10 } ],
	        connectorStyle:connectorPaintStyle,
	        paintStyle : {
	        	fillStyle : colorOfEndpoint
	        	//outlineWidth:10,
	        	//outlineColor:"white"
			
	        },
	        parameters : {"input_id": "tobeset_Later"}
	    };
	
	var output_endpoint_4 = {
			isSource:true,
			endpoint:["Dot", { radius:10 } ],
	        maxConnections:1,
	      //  isTarget:true,
	        anchors : "BottomCenter",
	        dropOptions:{ hoverClass:"hover"},
	        connector:[ "Flowchart", { stub:40, gap:10 } ],
	        connectorStyle:connectorPaintStyle,
	        paintStyle : {
	        	fillStyle : colorOfEndpoint
	        	//outlineWidth:10,
	        	//outlineColor:"white"
			
	        },
	        parameters : {"input_id": "tobeset_Later"}
	    };
		var input_endpoint_1 = {
			
			//isSource:true,
			endpoint:["Dot", { radius:11 /* , cssClass:"transparent_endpoint"  */ } ],
	        maxConnections:1,
	        isTarget:true,
	        anchors : "TopCenter",
	        //dropOptions:{ tolerance:"touch",hoverClass:"dropHover" }
	        connector:[ "Flowchart", { stub:40, gap:10 } ],
	        connectorStyle:connectorPaintStyle,
	       // dropOptions : exampleDropOptions,
	        //dropOptions : {over:function(e, ui) { alert('drop!'); }},
	        paintStyle : {
	        	fillStyle : inputEndPointColor
	        	//outlineWidth:10,
	        	//outlineColor:"white"
			
	        },
			//id:"input_endpoint_1"
	     
	        
	    };

	var input_endpoint_2 = {
			//isSource:true,
			isTarget:true,
			endpoint:["Dot", { radius:10 } ],
	        maxConnections:1,
	        anchors : "LeftMiddle",
	        dropOptions:{ hoverClass:"hover"},
	        connector:[ "Flowchart", { stub:40, gap:10 } ],
	        connectorStyle:connectorPaintStyle,
	        paintStyle : {
	        	fillStyle : inputEndPointColor
	        	//outlineWidth:10,
	        	//outlineColor:"white"
			
	        }
	    };
	
	var input_endpoint_3 = {
			//isSource:true,
			isTarget:true,
			endpoint:["Dot", { radius:10 } ],
	        maxConnections:1,
	        anchor : "TopLeft", //[ 0.03, 0.03, 0, 0 ]
	        dropOptions:{ hoverClass:"hover"},
	        connector:[ "Flowchart", { stub:40, gap:10 } ],
	        connectorStyle:connectorPaintStyle,
	        paintStyle : {
	        	fillStyle : inputEndPointColor
	        	//outlineWidth:10,
	        	//outlineColor:"white"
			
	        }
	    };
	
	var input_endpoint_4 = {
			//isSource:true,
			isTarget:true,
			endpoint:["Dot", { radius:10 } ],
	        maxConnections:1,
	        anchor : "BottomLeft", //[ 0.03, 0.92, 0, 1 ]
	        dropOptions:{ hoverClass:"hover"},
	        connector:[ "Flowchart", { stub:40, gap:10 } ],
	        connectorStyle:connectorPaintStyle,
	        paintStyle : {
	        	fillStyle : inputEndPointColor
	        	//outlineWidth:10,
	        	//outlineColor:"white"
			
	        }
	    };
	
	var inputEndpoints = new Array();
	inputEndpoints[0] =  input_endpoint_1
	inputEndpoints[1] =  input_endpoint_2
	inputEndpoints[2] =  input_endpoint_3
	inputEndpoints[3] =  input_endpoint_4
	var outputEndpoints = new Array()
	outputEndpoints[0] =  output_endpoint_1
	outputEndpoints[1] =  output_endpoint_2
	outputEndpoints[2] =  output_endpoint_3
	outputEndpoints[3] =  output_endpoint_4

	var labelsForEndpoints = [
	            // note the cssClass and id parameters here
	            [ "Label", { cssClass:"overlaylabel", label:"FOO", id:"lbl" , location:[-3,-2]} ],
	        ];
	
	
	
	var myLayout;
	var innetLayout;
	var _listeners;
$(document).ready(function() {
	//alert("ready2")
	
	_listeners = function(e) {
		
        e.bind("mouseenter", function(ep) {
        	ep.showOverlay("lbl");	
        	
        });
        e.bind("mouseexit", function(ep) { 
            ep.hideOverlay("lbl");

        });        
    };
	
	var layoutOptions = {
			center__childOptions: {
				inset: {
					top:	20
				,	bottom:	20
				,	left:	20
				,	right:	20
				}
			},
			//initClosed:				true
			east: {
				togglerLength_closed:	21,
				togglerAlign_closed:	"top",
				spacing_closed:			21
				//togglerLength_open:		0
			},
			fxSpeed_close:				1000//,
				
		};
	
	var layoutSettings_Inner = {
			
	}


	//$('body').layout({ applyDefaultStyles: true });
	//$('body').layout({ east__size:"400px"});
	  myLayout = $('body').layout( layoutOptions);
	  innerLayout = $("body > .ui-layout-center").layout();
	innerLayout.sizePane("east", 300)
	innerLayout.sizePane("west", 300)
	//myLayout.sizePane("west", 300);
	//myLayout.sizePane("body > .ui-layout-east", 300);
	myLayout.hide('east')
	clearbuttonclicked()
	
	accordionise();
	
	initialiseTheLeftPanel();
	
	getworkflowitems();
	
	
	startnewjob();
	
	
	
	$("#"+"notificationscontainer").resizable()
	//{
//		handles : {
//			'ne' : #resizable_handle
//		}
	//});
	$("#"+"notificationscontainer").draggable();
	
	$(function() {
	    
	    var $sidebar = $('#leftPanel'), $splitter = $('#splitter');
	    
	    $splitter.toggle(
	        function() { 
	            $sidebar.animate({ width: 'hide' }, 400);
	            $splitter.html('&rsaquo;&rsaquo;');
	        },
	        function() {
	            $sidebar.animate({ width: 'show' }, 400);
	            $splitter.html('&lsaquo;&lsaquo;');
	        }
	    );
	        
	    
	});

	
	
	
	
	
	
	
	
	
	    

	
	
	
	var finalOffset
	var finalxPos
	var finalyPos
	
	
	
	$(".markerForDraggable").draggable({
		appendTo: 'body',
		helper:myHelper,
		cursorAt:{top:20,left:30}
	});
	
	
	function myHelper( event ) {
		
		
		var idd = $(this).attr('id');
		
		var obj = getDraggedObj(idd);
		//The purpose of this obj is to make the 
		//dragged worker look like the worker in the div
		//i.e. customise the numnber of inputs and outputs
		
		
		//add class "temporary" so that I can jquery selector can select it
		console.log("Dragged obj is")
		console.log(obj)
		var x1 = '<div class="dragged_obj temporary" id="1111">'+
				 '<br>' +
				 obj.name +
				 '</div>'
		
		var x =  '<div class="workAndInput_New temporary" id="11111111">' +
					'<div class=workDiv>' +
					'<div class="widget-head" id="head1">' +
					'<h3>Mapping</h3>' +
					'</div>' +
		
					'<div class="widget-content" id="content1"><p><br>FASTQ</br></p></div>' +
	

					'<div class="rect_input_top" id="new1">' +
					'	<div class="circle_ash"> ' +
					'	</div>' +
					'</div>' +
	
	
					'<div class="rect_output_right" id="new1">' +
					'	<div class="circle_output_right"> ' +
					'	</div>' +
					'</div>' +
					'</div>' +
					'</div>';
				
				return x1;
		  
		}
	
	
	
	$( "#rightPanel").droppable({
		
		
		
		
		 drop: function( event, ui ) {
			 
       			var newPosX = ui.offset.left - $(this).offset().left;
       	        var newPosY = ui.offset.top - $(this).offset().top;
       	        
       	        console.log(ui)
       	        
       	        var draggingDiv = $(ui.helper);
       	        
       	        var id = ui.draggable[0].id;
       	        
       	        var obj = getDraggedObj(id);
       	        
       	        //Get the div based on the class "temporary" and then remove that class
       	        //edited to remove the div  -- adding a new div with correct title and name
       	        if(draggingDiv.hasClass("temporary")) {
       	        	
       	        	console.log(obj)
       	        	var widgetId = generateNextId();
       	        	if(obj.category != "User Saved Job") {
       	        		workitemsOnClient[widgetId] = obj;
           	        	workitemsOnClient[widgetId].widgetid = widgetId;
           	        	workitemsOnClient[widgetId].posX = newPosX;
           	        	workitemsOnClient[widgetId].posTop = newPosY;
       	        	} else {
       	        		restoreJobPosX = newPosX
       	        		restoreJobPosY = newPosY
       	        	}
       	        	
       	        	
       	        	var output = new Array();
       	        	
       	        	output = getHTMLForDroppable(widgetId, obj);

       	        	var newWidget = output[0];
       	        	
       	        	//total inputs = -1 indicates that its user saved job
       	        	//change it to use the obj.category test above.
       	        	//create a local variable or something.
       	        	var totalinputs = output[1];
       	        	
       	        	if(totalinputs != -1) {
       	        		$(this).append(newWidget);
           	        	
           	        	addRemoveIcon(widgetId)
           	        	
           	        	$('#'+widgetId).css(
           	        			{
           	        				position:'absolute',
           	        				left:newPosX,
           	        				top:newPosY
           	        			}
           	        	);
           	        	
           	        	addEndpoints(totalinputs, widgetId)
            			
            			
            			//Tell server to send back HTML for the EAST accordion
           	        	newWorkflowItemAdded(obj, widgetId, "no");
            			
            			// Repaint jsPlumb to fix the 1px misalignment
            			//jsPlumb.repaintEverything();
       	        	}
       	        	
       	        }
       	     
       	     
		} 
	/* drop: function(event, ui) {
        $(ui.draggable).appendTo(this).addClass('absolute').css({
            top: ui.offset.top,
            left: ui.offset.left
        });
        //jsPlumb.repaintEverything();
        alert("1");
    } */
	});
           
	

				
      
	
        
	
	
	
	
	
	
	
	
	
	
	
	initializeJsPlumb();

});

function initializeJsPlumb() {
jsPlumb.ready(function() {
		

		setJsplumbDefaults();
		
		//makeDraggable();
		
		var common = {
				cssClass:"transparent_endpoint"
			};
		
		jsPlumb.importDefaults({
			// default drag options
			DragOptions : { cursor: 'pointer', zIndex:-2 }
		});
		
		
		var connectionDetached = function(conn) {

			
			console.log("DETACH CONNECTIONS CALLED")
			source_input 				= conn.sourceEndpoint
			
			var from_id 				= conn.sourceId
			var to_id					= conn.targetId
			
			
			var from_item_id 			= workitemsOnClient[from_id].itemid
			var from_item_anchor_type 	= source_input.anchor.type 
			
			
			var to_item_id	 			= workitemsOnClient[to_id].itemid
			var to_item_anchor_type 	= conn.targetEndpoint.anchor.type
			
			console.log("Connection detached event details")
			console.log(from_id)
			console.log(from_item_anchor_type)
			console.log(to_id)
			console.log(to_item_anchor_type  )
			
			var source = conn.sourceId
			var target = conn.targetId
			
			var from_id = conn.sourceId
			var to_id	= conn.targetId
			
			var from_item_id = workitemsOnClient[from_id].itemid
			var to_item_id	 = workitemsOnClient[to_id].itemid
			
			/**
			 * Need to fix this
			 
			if(from_item_id=="user_saved_job") {
				from_item_id=from_item_id + "_" + workitemsOnClient[from_id].name
			}
			if(to_item_id=="user_saved_job") {
				to_item_id=to_item_id + "_" +  workitemsOnClient[to_id].name
			}*/
			
			
			updateConnectionsOnServer(from_item_id+"_"+from_id, to_item_id+"_"+to_id, from_item_anchor_type, to_item_anchor_type, true)
			
		
		}
		
		var updateConnections = function(conn) {
		
			
			var source_input 		= conn.sourceEndpoint
			console.log("sourceinput is ")
			console.log(source_input)
			var source_input_id 	= source_input.getParameter("input_id")
			var target_input_id 	= conn.targetEndpoint.getParameter("input_id")
			
			var xxxx = source_input["params"]
			var yyyy = source_input["parameters"]
			console.log(source_input_id)
			console.log(target_input_id)
			
			var params = conn.connection.getParameters();
			console.log(params.input_id)
			
			
			console.log("UPDATE CONNECTIONS CALLED")
			conn.connection.endpoints[0].setPaintStyle({fillStyle:colorOfEndpoint});
			conn.connection.endpoints[1].setPaintStyle({fillStyle:colorOfEndpoint});
			
			//jsPlumb.repaintEverything();
		
			//WHAT is this?
			if(1) connections.push(conn);
			
			else {
				var idx = -1;
				for (var i = 0; i < connections.length; i++) {
					if (connections[i] == conn) {
						idx = i; break;
					}
				}
				if (idx != -1) connections.splice(idx, 1);
			}
			
			
			if (connections.length > 0) {
//				var s = "<span>current connections</span><br/><br/><table><tr><th>scope</th><th>source</th><th>target</th></tr>";
//				for (var j = 0; j < connections.length; j++) {
//					s = s + "<tr><td>" + connections[j].scope + "</td>" + "<td>" + connections[j].sourceId + "</td><td>" + connections[j].targetId + "</td></tr>";
//			}
//				showConnectionInfo(s);
			} else 
//				hideConnectionInfo();
			
				pulsateDiv(conn.sourceId,conn.targetId);
			
			
			
			
			
				var from_id 				= conn.sourceId
				var to_id					= conn.targetId
				
				
				var from_item_id 			= workitemsOnClient[from_id].itemid
				var from_item_anchor_type 	= source_input.anchor.type 
				
				
				var to_item_id	 			= workitemsOnClient[to_id].itemid
				var to_item_anchor_type 	= conn.targetEndpoint.anchor.type
				
				console.log("Checl fro, here")
				console.log(source_input)
				console.log(to_id)
				console.log(from_item_anchor_type)
				console.log(to_item_anchor_type  )
				
				
				/**
				 * Need to fix this
				 */
				if(from_item_id=="user_saved_job") {
					from_item_id=from_item_id + "_" + workitemsOnClient[from_id].name
				}
				if(to_item_id=="user_saved_job") {
					to_item_id=to_item_id + "_" +  workitemsOnClient[to_id].name
				}
				
				updateConnectionsOnServer(from_item_id+"_"+from_id, to_item_id+"_"+to_id, from_item_anchor_type, to_item_anchor_type, false)
				console.log(from_item_id+"_"+from_id +","+ to_item_id+"_"+to_id)
			
			
			
		};	
		
		
		showConnectionInfo = function(s) {
			$("#connections").html(s);
			$("#connections").fadeIn();
		};
		
		jsPlumb.bind("jsPlumbConnection", function(info, originalEvent) {
			updateConnections(info);
			
		});
		
		jsPlumb.bind("jsPlumbConnectionDetached", function(info, originalEvent) {
			connectionDetached(info);
			
		});
		
			

		
	});
}

function hideConnectionInfo() {
	
	
	$("#currentconnections").remove();
}


function widgetClicked(widget){
	
	if (widget == null) {
		return;
	}
	var obj = workitemsOnClient[widget.id]
	
	if(obj == null) {
	
		return;
	}
	//if u click twice, the header closes. thats ok for now.
	$("#"+obj.itemid + "__" + widget.id + "__header").click()
 	
	}

function accordionise() {
	console.log("accordionised");
	
	$(".accordion").accordion({
	    collapsible: true, 
	    autoHeight: false, 
	    animated: 'swing',
	    changestart: function(event, ui) {
	        child.accordion("activate", false); 
	    }
	});

	var child = $(".child-accordion").accordion({
	    active:false,
	    collapsible: true, 
	    autoHeight: false, 
	    animated: 'swing'
	});	
}



function initialiseTheLeftPanel() {
	
		$(".togglepanel").hide();
		$(".toggletrigger").click(function(){
			//$(".toggletrigger").children().slideToggle("slow");
			//$(".togglepanel").slideToggle("slow");
			var xx = $(this)
			var someVar = $(this).parent();
			
			var str = $(this).children().children("#plussign").text()
			if(String(str).indexOf("+") != -1) {
				$(this).children().children("#plussign").text("-").css("margin-right","5px")
			} else {
				$(this).children().children("#plussign").text("+").css("margin-right","1px")
			}
			
			$(this).parent().children(".togglepanel").slideToggle("slow");
			
		});
	
}

function getHTMLForDroppable(widget_Id, object ) {
	   
	   var inputCount = object.totalinputs;
	   var outputCount = object.totaloutputs;
	   console.log("job under consideration is ")
	   console.log(object)
	   
	   if(object.category == "User Saved Job") {
		    restorejob1261(object.name)
		   
		   	var output = new Array();
			output[0] = widgetHTML;
			output[1] = -1;
			
			return output;
	   }
	   
	   var html_bottom = "";
	   //Temporarily removed the VIEW OUTPUT button due to real estate issues.
	   var html_bottom =   '<div style="width:90%; height:20px;">' 
	   					 + 		'<button name="Output" class="widget_button" onclick=viewOutput("'
		 				 +	object.itemid+"_"+widget_Id
		 				 + '")>View Output</button>'
	   					 + '</div>'
	   					 + '<div style="display: none;width:500px;height:200px;position: absolute;z-index: 2"' 
	   					 +       'id="'+object.itemid+"_"+widget_Id+'_theOutputDiv">'
	   					 + '</div>' 
      
	   var widgetHTML = "";
	  
	   
	   if (object.category == "Input") {
		 widgetHTML = '<div class="widget-content inputItem_file" id='
					+ 	widget_Id
					+   ' onclick= widgetClicked('
					+   widget_Id
					+  ')'
					+ 	' >'
					+	'<p><br>'
					+	 object.name
					+ 	'</br></p>'
					+   '</div>'
					
					;

			var output = new Array();
			
			output[0] = widgetHTML;
			output[1] = object.totalinputs;
			
			
			
			return output;

	   } else {
		widgetHTML	= '<div class="workAndInput_New " id='
					+ widget_Id
					+ " onclick= widgetClicked("
					+ widget_Id
					+ ")"
					+ '>'
					+ '<div class=workDiv>'
					+ '<div class="widget-head" id="head1">'
					+ '<center>'
					+ '<h3 style="display:inline-block">'
					+ object.category
					+ '</h3>'
					+ '</center>'
					+ '</div>'
					+

					'<div class="widget-content" id="content1"><p><br>'
					+ object.name
					+ '</br></p></div>'
					
					
		if(inputCount > 0) {
						widgetHTML +=	'<div class="rect_input_top" id="new1">'
						//	+ '	<div class="circle_ash"> '
						//	+ '	</div>'
							+ '</div>';
						inputCount--;
					}
					
					
		if(inputCount > 0) {
			widgetHTML +=	'<div class="rect_input_left" id="input_left">'
							+'</div>';
			inputCount--;
		}
		
		if(inputCount > 0) {
			widgetHTML 	+=	'<div class="rect_input_topleft_1 " id="input_topleft">'
						+ 	'</div>' 
						+	'<div class="rect_input_topleft_2 " id="input_topleft">'
						+	'</div>';
			
			inputCount--;
		}
		
		if(inputCount > 0) {
			widgetHTML 	+=	'<div class="rect_input_bottomleft_1 " id="input_topleft">'
						+ 	'</div>' 
						+	'<div class="rect_input_bottomleft_2 " id="input_topleft">'
						+	'</div>';
			inputCount--;
		}
					
					
		if(outputCount > 0) {
			widgetHTML+= '<div class="rect_output_right" id="new1">'
				//		+ '	<div class="circle_output_right"> '
					//	+ '	</div>'
						+ '</div>'
						
						
						
						
			outputCount--;
		}
		if(outputCount > 0) {
			widgetHTML+= '<div class="rect_output_bottomright_1" id="bottomright_1">'
						+ '</div>'
						+ '<div class="rect_output_bottomright_2" id="bottomright_2">'
						+ '</div>'
						
						
						
						
			outputCount--;
		}
		
		if(outputCount > 0) {
			widgetHTML+= '<div class="rect_output_topright_1" id="top_right_1">'
						+ '</div>'
						+ '<div class="rect_output_topright_2" id="top_right_2">'
						+ '</div>'
						
						
						
						
			outputCount--;
		}
		
		if(outputCount > 0) {
			widgetHTML+= '<div class="rect_output_bottomcenter" id="new1">'
				//		+ '	<div class="circle_output_right"> '
					//	+ '	</div>'
						+ '</div>'
						
						
						
						
			outputCount--;
		}
		widgetHTML += '</div>'
				   + html_bottom
		           + '</div>';
		
		
		
		var output = new Array();
		output[0] = widgetHTML;
		output[1] = object.totalinputs;
		
		
		
		
		return output;
	}
					
					

}

function removewidget(event, widgetid) {
	
	//alert("removewidget "+widgetid.id)
	var thisevent = event
//	thisevent.stopPropogation()
	thisevent.preventDefault();
	
	
	jsPlumb.removeAllEndpoints(widgetid.id)
	
	$("#"+ workitemsOnClient[widgetid.id].itemid +"__"+ widgetid.id + "__header").fadeOut('slow',function(){$(this).remove();});
	$("#"+ workitemsOnClient[widgetid.id].itemid +"__"+ widgetid.id + "__div").fadeOut('slow', function() {$(this).remove();})
	delete workitemsOnClient[widgetid.id];
	//Remove widget from center
	$("#"+widgetid.id+"_icon").remove();
	//alert("#"+ (widgetid.id))
	$("#"+ (widgetid.id)).unbind();
	$("#"+ (widgetid.id)).off();
	
	
	$("#"+ (widgetid.id)).remove();
	
	
	jsPlumb.unmakeSource(widgetid.id)
	jsPlumb.unmakeTarget(widgetid.id)
	
	//jsPlumb.repaintEverything();
	
	
	
	removeWorkflowItem(widgetid.id)
	
	event.stopPropagation();
	
	return false;
	
}


function addRemoveIcon(widget_id) {
	
	var remove_icon = "<img src='/images/close_button.png' id="+widget_id+"_icon"  +"  onclick='removewidget(event, "+widget_id+")' style='z-index:2;position:absolute; top:-40px;right:-20px;'/>";
	
	$("#"+widget_id).append(remove_icon)
	
	$("#"+widget_id+"_icon").css({display:"none"});
	
	$("#"+widget_id).hover( 
			function(){
					var iconn = $("#"+widget_id+"_icon")
					$("#"+widget_id+"_icon").css({display:"inline"});
				  },
			function(){
					  $("#"+widget_id+"_icon").css({display:"none"});
				  }
	);
}

/**
 * 
 * DID NOT LOOK SO GOOD...
 * SO REMOVED IT FOR NOW...
 * CAN BE IMPLEMENTED IF REQUIRED
 * @param i
 * @param obj
 * @returns {Function}
 */
function getFunction(i, obj) {
	return function(e,ui) {
			var j = i
			var xx = obj
			console.log(xx)
			console.log(j)
			
			var label = xx.inputs[j].input_parameter_label
			var name  = xx.inputs[j].input_parameter_name
	
			var posX = e.pageX
			var posY = e.pageY
			console.log(posX)
			posX = posX - 300 
			console.log(posX)
			posY = posY - 100
	
			//300 is from size of west
			var id = new Date().getTime();
			var html = '<div id = '+id+' style="border:1px solid red;position:absolute; left:'+posX+'px;top:'+posY+'px;">' +
			'<label>' + label+ ' '+ name+' </label>'
			var html = "<div style='margin-top:20px;background:#bdbdbd;border:2px solid;padding:3px;'> filetype: " +this_obj.outputs[0].output_type +"<br> label : "+this_obj.outputs[0].output_parameter_label + "</div>"
			$( "#content-inner" ).append(html)
			$("#"+id).delay(1000).fadeOut('slow')
			
			
			
		};

}

function addEndpoints(totalinputs, widgetId) {
	//Add the jsPlumb endpoints
   	if(totalinputs == 0) {
   		
   		var this_obj = workitemsOnClient[widgetId]
   		
   		//var overlay = getOverlay(this_obj.outputs[0].output_type)
   		//var overlay = getOverlay("<div> filetype: " +this_obj.outputs[0].output_type +"<br> label : "+this_obj.outputs[0].output_parameter_label + "</div>")
   		var overlay = getOverlay("<div style='margin-top:20px;background:#bdbdbd;border:2px solid;padding:3px;'> filetype: " +this_obj.outputs[0].output_type +"<br> label : "+this_obj.outputs[0].output_parameter_label + "</div>")
   		
   		
   		
//   		var lbls = [
//   		            ["Label", 
//   		             	{
//   		            		label:"ASHWIN",
//   		            		cssClass:"epOverlay"
//   		             	}
//   		            ]
//   		            ];
   		
   		var e3 = jsPlumb.addEndpoint(widgetId, endpoint_right, {overlays:overlay});
   		
   		_listeners(e3)
   		
   		var outputs = this_obj.outputs
   		
   		for( var i =0; i < outputs.length; i++) {
        		if( outputs[i].output_parameter_name == "" || outputs[i].output_parameter_name == "undefined")
   			{
   				e3.output_id = "none"
   			} else {
   				e3.output_id =	outputs[i].output_parameter_name
   			}
   		}
			
			
   		makeDraggable(".inputItem_file");
   	} else {
   		var i = 0 ;
   		
   		var this_obj = workitemsOnClient[widgetId]
   		console.log("THIS OBJ IS")
   		console.log(this_obj)
   		var inputs 	 = this_obj.inputs
   		var outputs  = this_obj.outputs
   		
   		for( var i = 0; i < inputs.length; i++) {
   			
   			var newEndpoint = jQuery.extend({}, inputEndpoints[i]);
   			
   			//newEndpoint.dropOptions = {over:getFunction(i, this_obj)}; 
   			   			
   			var overlay = getOverlay("<div style='margin-top:20px;background:#bdbdbd;border:2px solid;padding:3px;'> filetype: " +this_obj.inputs[i].input_type +"<br> label : "+this_obj.inputs[i].input_parameter_label + "</div>")
   			
   			var e = jsPlumb.addEndpoint(widgetId, newEndpoint, {overlays:overlay});
   			
   			_listeners(e)
   			
   			if( inputs[i].input_parameter_name == "" || inputs[i].input_parameter_name == "undefined")
   			{
   				e.input_id = "none"
   			} else {
   				e.input_id =	inputs[i].input_parameter_name
   			}
   			 
   			
   		}
   		
   		
   		
			for( var i =0; i < outputs.length; i++) {
       			console.log("Adding output endpoint"+i)
       			var newEndpoint = jQuery.extend({}, outputEndpoints[i]);
       			
       			//var overlay = getOverlay(this_obj.outputs[i].output_type)
       			var overlay = getOverlay("<div style='margin-top:20px;background:#bdbdbd;border:2px solid;padding:3px;'> filetype: " +this_obj.outputs[i].output_type +"<br> label : "+this_obj.outputs[i].output_parameter_label + "</div>")
       			var e  =jsPlumb.addEndpoint(widgetId, newEndpoint, {overlays:overlay});
       			
       			_listeners(e)

       			if( outputs[i].output_parameter_name == "" || outputs[i].output_parameter_name == "undefined")
       			{
       				e.output_id = "none"
       			} else {
       				e.output_id =	outputs[i].output_parameter_name
   			}
   			
   		}
   		
   		
   		
//   		while(totalinputs >= 0) {
//   			totalinputs--
//   			jsPlumb.addEndpoint(widgetId, inputEndpoints[i]);
//   			i++
//   		}
   	
   		makeDraggable(".workAndInput_New");
   		
   		
		
   	}
}		

function getOverlay(obj_type) {
	
	
	var newLabel 	= jQuery.extend(true, [], labelsForEndpoints);
	newLabel[0][1].label  = obj_type
	if(obj_type== null) {
		newLabel[0][1]= "NULL"
	} else if(obj_type=="samfile") {
		newLabel[0][1].label="Sam file"
	}else if(obj_type=="bamfile") {
		newLabel[0][1].label="Bam file"
	} else if(obj_type=="fastafile") {
		newLabel[0][1].label="Fasta file"
	} else if(obj_type=="fastqfile") {
		newLabel[0][1].label="Fastq file"
	} else {
		console.log(obj_type)
	}
	
	newLabel[0][1].label  = obj_type
	return newLabel
}

function makeDraggable(divclass) {
	jsPlumb.draggable($(divclass) , {
		stop: handleDragStop
	});
	function handleDragStop( event, ui ) {
		
		console.log("Drag stop called")
		
		//jsPlumb.repaintEverything();
		
		var testelement = event.srcElement;
		
		var id = this.id
		var xx = "#" + id;
		var widgetContent = $("#" + id);
		

									

		var obj = workitemsOnClient[id];
		
		
		obj.posX = ui.position.left
		obj.posTop = ui.position.top
		
  	    
		}
};

function pulsateDiv(div1, div2) {
	var xx = $("#"+div1);
	
	$("#"+div1).effect("pulsate", { times:1 }, 200);
	$("#"+div2).effect("pulsate", { times:1 }, 200);
} 

function distributed_run(server) {
	runbuttonclicked(server)
	
}
