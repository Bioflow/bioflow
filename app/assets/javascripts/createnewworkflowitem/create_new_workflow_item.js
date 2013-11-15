$(document).ready(function() {
	tooltipIt("#addworkflowitem :input", false)
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
	//innerLayout.sizePane("east", 300)
	innerLayout.sizePane("west", 300)
	//myLayout.sizePane("west", 300);
	//myLayout.sizePane("body > .ui-layout-east", 300);
	///myLayout.hide('east')
	
	accordionise()
	
	initialiseTheLeftPanel()
	
	
	$(".markerForDraggable").draggable({
		appendTo: 'body',
		helper:'clone',
		cursorAt:{top:20,left:30}
	});
	
	$("#tooldeletor").droppable({
		drop: function( event, ui ) {
			
			deleteToolOnServer(event, ui);
		}
	});
	
});

function deleteToolOnServer(e , u) {
	var idd = $(this).attr('id');
	
	var toolId = u.draggable[0].id
	console.log(toolId)
	
	$.ajax({
		beforeSend: function(xhr) {
		    xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'));
		  },
		type : "POST",
		url : "/add_workflowitem/delete?id="+toolId,
		contentType : "application/json; charset=utf-8",
		dataType : "json",
		success : function(result) {
			console.log(result)
			alert(result)
			location.reload();
			
		}

	});

}

function tooltipIt(identifier, startswith) {
	console.log("TOOLTIPPED")
	var id = ""
	if(startswith == true) {
		id ="[id^="+identifier+"]" 
	} else {
		id = identifier
	}
	$(id).tooltip({
		// place tooltip on the right edge
	      position: "center right",
	 
	      // a little tweaking of the position
	      offset: [-2, 50],
	 
	      // use the built-in fadeIn/fadeOut effect
	      effect: "fade",
	 
	      // custom opacity setting
	      opacity: 0.7
	 	
	});
	
	
}
function inputCountSelected(sel) {
	
	$("#input_fieldset").css("padding-bottom","10px")
	
	var value = sel.options[sel.selectedIndex].value;
	var html_str = "";
	for (var i=0 ; i < value; i++) {
		//alert("1")
		html_str += '<div id="createInputDetails_"'+i+' style="border:1px solid #9d9d9d;padding:5px;margin-bottom:10px;background:#C2C2C2">'+
						'<br>' +
						'<div id = "inputs'+i+'" >'+
							'<label class="field">Input Type</label>' + 
							'<select title="Selecting input type will enable validating connections. For filetypes, a list of files will be automatically available" name="input_type_'+i+'" id = "input_type_'+i+'" >'+
								'<option value="bamfile">Bam File</option>'+
								'<option value="samfile">Sam File</option>'+
								'<option value="fastafile">Fasta File</option>'+
								'<option value="fastqfile">Fastq File</option>'+
								'<option value="gzippedfile">Gzipped File</option>'+
								'<option value="ndxfile">NDX</option>'+
								'<option value="otherfile">Other File Type</option>'+
								'<option value="other">String</option>'+
								'</select>'+
						'</div>'+

					'<label class="field" >Parameter</label>'+
					'<input title="This parameter will be passed in the command line along with the input selected" onchange="showExampleCommand()" type="text" name="param_input_'+i+'" id="param_input_'+i+'" class="formInputstyle_2"> '+
					'<label class="field" >Label</label>'+
					'<input title="Short description to identify the parameter" type="text" name="label_input_'+i+'" id="label_input_'+i+'" class="formInputstyle_2"> '+
					'</div>';
		
	}
	$("#inputs_div").html(html_str)
	console.log(html_str)
	tooltipIt("param_input_", true)
	tooltipIt("input_type_", true)
	tooltipIt("label_input_", true)
}

function addFormParam(formparams) {
	
	var value = formparams.options[formparams.selectedIndex].value;
	
	$("#parameters").css("padding-bottom","10px")
	
	var html_str = ""
		for (var i=0 ; i < value; i++) {
			//alert("1")
			html_str += '<div id="createFormParams_"'+i+' style="border:1px solid #9d9d9d;padding:5px;margin-bottom:10px;background:#C2C2C2">'+
			
							'<div id = "formParams_'+i+'   " ">'+
								'<label class="field">Type</label>' +
								'<select title="This value will be displayed to provide suitable input types" name="formparam_type_'+i+'" id = "formparam_type_'+i+'">'+
									'<option value="bamfile">Bam File</option>'+
									'<option value="samfile">Sam File</option>'+
									'<option value="fastafile">Fasta File</option>'+
									'<option value="fastqfile">Fastq File</option>'+
									'<option value="gzippedfile">Gzipped File</option>'+
									'<option value="ndxfile">NDX</option>'+
									'<option value="otherfile">Other File Type</option>'+
									'<option value="other">String</option>'+
									'</select>'+
							'</div>'+

							'<label class="field" >Parameter</label>'+
							'<input title="This will be passed to the command line as well as displayed in the right panel" onchange="showExampleCommand()" type="text" name="formparam_'+i+'"  id="formparam_'+i+'"  class="formInputstyle_2">' +
							'<label class="field" >Label</label>'+
							'<input title="Short description to identify the parameter" type="text" name="formlabel_'+i+'" id="formlabel_'+i+'" class="formInputstyle_2"> '+
							'</div>';
		}
	
	
	
	
		
	$("#asdf_parameters_div").html(html_str)
	tooltipIt("formparam_", true)
	tooltipIt("formparam_type_", true)
}
function outputCountSelected(sel) {
	$("#output_fieldset").css("padding-bottom","10px")
	
	var value = sel.options[sel.selectedIndex].value;
	var html_str = "";
	for (var i=0 ; i < value; i++) {
		//alert("1")
		html_str += '<div id="createOutputDetails_"'+i+' style="border:1px solid #9d9d9d;padding:5px;margin-bottom:10px;background:#C2C2C2">'+
		
						'<div id = "outputs'+i+'   " ">'+
							'<label class="field">Output</label>' +
							'<select title="Selecting output type will enable validating connections. For filetypes, a list of files will be automatically available" name="output_type_'+i+'" id = "output_type_'+i+'">'+
								'<option value="bamfile">Bam File</option>'+
								'<option value="samfile">Sam File</option>'+
								'<option value="fastafile">Fasta File</option>'+
								'<option value="fastqfile">Fastq File</option>'+
								'<option value="gzippedfile">Gzipped File</option>'+
								'<option value="ndxfile">NDX</option>'+
								'<option value="otherfile">Other File Type</option>'+
								'<option value="other">String</option>'+
								'</select>'+
						'</div>'+

						'<label class="field" >Parameter</label>'+
						'<input title="This parameter will be passed in the command line along with the output selected" onchange="showExampleCommand()" type="text" name="param_output_'+i+'"  id="param_output_'+i+'"  class="formInputstyle_2">' +		
						'<label class="field" >Label</label>'+
						'<input title="Short description to identify the parameter" type="text" name="label_output_'+i+'" id="label_output_'+i+'" class="formInputstyle_2"> '+
						'</div>';
	}
	
	$("#outputs_div").html(html_str)
	tooltipIt("param_output_", true)
	tooltipIt("output_type_", true)
	
}

function submitTheDocument() {
	
	var form_id = "addworkflowitem"
	
	var values = $("#"+form_id).serialize();
	console.log(values)
	$.ajax({
			beforeSend: function(xhr) {
			    xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'));
			    console.log("before send")
			  },
			type : "POST",
			url : "/add_workflowitem/create_new_workflowitem_formsubmit?"+"formId="+form_id+"&"+values,
//			contentType : "application/json; charset=utf-8",
			dataType : "json",
			data:$('#'+form_id).serialize(),
			success : function(result) {
				
				console.log("Success")
				alert(result)
				location.reload();
					
			}
		});
	


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




function populateTextFiled(sel) {
	var value = sel.options[sel.selectedIndex].value;
	$("#addcategory").val(value);
	
}

function createNewTool() {
	$("#createnewtooldiv").show();
	$("#deletetooldiv").hide();
	
}

function deleteTool() {
	$("#createnewtooldiv").hide();
	$("#deletetooldiv").show();
}



function showExampleCommand() {
	var generatedCommand = ""
	var seperator =" "

	var sep = $("#paramsformat").val();
	if(sep == "commandformat_2") {
		seperator = "="
	}
	var executable =	$("#executable").val();
	generatedCommand += executable + " "
	var noOfInputs = $("#noofinputs").val()
		
		
	for (var i =0; i < noOfInputs; i++) {
		var input_param_name = $("#param_input_"+i).val()
		var input_item       = "input_"+i
		generatedCommand += input_param_name + seperator + input_item + " "
	}
	
	var noOfOutputs =  $("#noofoutputs").val()
		
		
		for (var i =0; i < noOfInputs; i++) {
			var output_param_name =$("#param_output_"+i).val()
			var output_item       = "output_"+i
			generatedCommand += output_param_name + seperator + output_item + " "
		}
	var noOfFormParams = $("#noOfFormparams").val()
		
		for (var i =0; i < noOfFormParams; i++) {
			var form_param_name = $("#formparam_"+i).val()
			var form_item       = "formparam_"+i
			generatedCommand += form_param_name + seperator + form_item + " "
		}
	$("#sample").text(generatedCommand)
}