var id_widget = 2;
var widget_id = "widget"+id_widget;


function generateNextId() {
	id_widget = new Date().getTime();
	//id_widget = id_widget + 1;
	return "widget"+id_widget;
}


function setJsplumbDefaults() {
	
	jsPlumb.importDefaults({
	    // default drag options
	    DragOptions : { cursor: 'pointer', zIndex:2000 },
	    ConnectionOverlays : [ 
	            [ "Arrow", { location:0.5 , foldback:0.7, width:25, length:35 , 
	            	paintStyle : { 
	            					lineWidth : 8, 
            						strokeStyle : "#5e5e5e",//"#0B6121", 
            						fillStyle : "#C0C0C0",//"#31B404",
            						outlineColor:"white",
            						outlineWidth:50
            	}} ]	              
	    ]   
	});    

}

