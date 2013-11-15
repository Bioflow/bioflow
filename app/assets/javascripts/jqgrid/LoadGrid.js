/**
 * 
 * NEED TO WRITE SCRIPT TO AUTO RESIZE GRID TO WIDTH OF PARENT DIV
 * 
 */


function init() {
	
	myLayout = $('body').layout( {applyDefaultStyles: true});
	myLayout.sizePane("west", "480")
	
	LoadRecipients();
}

function  LoadRecipients() {
	jQuery("#list2").jqGrid({
		width:450,
		height:250,
//		autowidth:true,
	   	url:'get_all_jobs',
		datatype: "json",
	   	colNames:['Job Id','Created At', 'Job Name', 'Status'],
	   	colModel:[
	   		{name:'jobId',index:'jobId', width:250,sortable:false,search:false},
	   		{name:'createdAt',index:'createdAt',width:250, sortable:false,search:false},
	   		{name:'jobname',index:'jobname',width:250, sortable:false,search:false},
	   		{name:'Status',index:'status',width:250, sortable:false,search:false}
	   	],
	   	rowNum:10,
	   	rowList:[10,20,30],
	   	pager: '#pager2',
	   	viewrecords: true,
	    sortorder: "desc",
	    caption:"Job Details",
	    onSelectRow: function(row_id) {
	    	var ret = jQuery("#list2").jqGrid('getRowData',row_id)
	    	var job_id = ret["jobId"]
	    	
	    	getJobDetails(job_id, "detailspanel")
		}
	});

	
	jQuery("#list2").jqGrid('navGrid','#pager2',{edit:false,add:false,del:false,search:false});
	jQuery("#list2").jqGrid('gridResize',{minWidth:350,maxWidth:800,minHeight:80, maxHeight:350});
}


	function getJobDetails(job_id, div_id) {
		
		jQuery.ajax({
			beforeSend: function(xhr) {
			    xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'));
			  },
			type : "GET",
			url : "/listalljobs/loadjobdetails?jobId="+job_id,
			contentType : "application/json; charset=utf-8",
			dataType : "json",
			success : function(result) {
				console.log(result);
				console.log(result)
				workitemsFromServer = result;
				displayOutput(result, div_id);	
				
				
				

			}

		});
	}
	
	function displayOutput(result, div_id) {
		//alert(result);
		jQuery("#"+div_id).empty();
		
		for(i = 0; i < result.length; i++ ) {
			jQuery("#"+div_id).append(result[i]);	//change append() to html()
		}
		
		//var str = '<table style="border:1px solid blue"> <tr> <td> Ashwin</td></tr></table>';
		
		//alert("lol");
	}

/****
 * subGrid : true,
		subGridRowExpanded: function(subgrid_id, row_id) {
			// we pass two parameters
			// subgrid_id is a id of the div tag created whitin a table data
			// the id of this elemenet is a combination of the "sg_" + id of the row
			// the row_id is the id of the row
			// If we wan to pass additinal parameters to the url we can use
			// a method getRowData(row_id) - which returns associative array in type name-value
			// here we can easy construct the flowing
			var subgrid_table_id, pager_id;
			subgrid_table_id = subgrid_id+"_t";
			var ret = jQuery("#list2").jqGrid('getRowData',row_id);
			//pager_id = "p_"+subgrid_table_id;
			jQuery("#"+subgrid_id).css("margin", "10px");
			jQuery("#"+subgrid_id).html("<table style='margin-top:5px;margin-bottom:5px' id='"+subgrid_table_id+"' class='scroll' ></table>");
			//<div id='"+pager_id+"' class='scroll' style='padding:10px'></div>"
			jQuery("#"+subgrid_table_id).jqGrid({
				url:'loadjobdetails?id=3',
				datatype: "json",
				colNames: ['No','Item'],
				colModel: [
					{name:"num",index:"num",width:200,key:true},
					{name:"item",index:"item",width:200},
					
				],
			   	rowNum:20,
			   	height: '100%'
			});
			jQuery("#"+subgrid_table_id).jqGrid('navGrid',"#"+pager_id,{edit:false,add:false,del:false})
		},
		subGridRowColapsed: function(subgrid_id, row_id) {
			// this function is called before removing the data
			//var subgrid_table_id;
			//subgrid_table_id = subgrid_id+"_t";
			//jQuery("#"+subgrid_table_id).remove();
		},

		caption: "Subgrid with JSON Data"
 */

// </script>
/*
function LoadRecipients()
{
  var $j = jQuery.noConflict();
      $j("#group_tbl").jqGrid({
     url:'get_contacts_json',
  datatype: "json",
  height: 250,
     colNames:['Group Name','Members'],
     colModel:[
         {name:'groupName',index:'groupName', width:150,sortable:false},
         {name:'groupSize',index:'groupSize',sortable:false},
     ],
     rowNum:-1,
      multiselect: true,
      loadonce: true,
  subGrid: true,
  caption: "Recipients",
      loadError : function(xhr,st,err) {
        alert('An error occured while loading recipients, Please refresh and try again later.');
      },

  // define the icons in subgrid
      subGridOptions: {
      "plusicon"  : "ui-icon-triangle-1-e",
      "minusicon" : "ui-icon-triangle-1-s",
      "openicon"  : "ui-icon-arrowreturn-1-e",
      // load the subgrid data only once
      // and the just show/hide
      "reloadOnExpand" : false,
      // select the row when the expand column is clicked
      "selectOnExpand" : false
  },

      subGridBeforeExpand:function(subgrid_id, row_id) {
        var selectedGroups = $j("#group_tbl").jqGrid('getGridParam','selarrrow');
        if (selectedGroups.toString() != "")
           {
             var grpTokens = selectedGroups.toString().split(",");
            for(i=0;i<selectedGroups.length;i++)
               {
                 if (grpTokens[i] == row_id)
                   {
                     $j("#group_tbl").jqGrid ('collapseSubGridRow', row_id);
                     return false;
                   }
                }
           }
           else
             return true;
      },

  subGridRowExpanded: function(subgrid_id, row_id) {            
              var valName = $j('#group_tbl').jqGrid('getCell',row_id,2);
              var valMember = $j('#group_tbl').jqGrid('getCell',row_id,3);
              var subgrid_table_id, pager_id;
      subgrid_table_id = subgrid_id+"_t";
      pager_id = "p_"+subgrid_table_id;
      $j("#"+subgrid_id).html("<table id='"+subgrid_table_id+"' class='scroll'></table><div id='"+pager_id+"' class='scroll'></div>");
      $j("#"+subgrid_table_id).jqGrid({
          url:"get_group_contacts_json?name="+  encodeURIComponent(valName) + "&members=" + valMember,
          datatype: "json",
          colNames:['User Id','Name'],
                      colModel:[
                              {name:'ltdUserId',index:'ltdUserId', width:75,sortable:false},
                              {name:'name',index:'name',sortable:false},
                      ],
             rowNum:-1,
             multiselect: true,
             loadError : function(xhr,st,err) {
                    alert('An error occured while loading recipients, Please refresh and try again.');
                    //
                 },
                 beforeSelectRow: function (rowid, e) {
               
                    var selectable = $j("#"+subgrid_table_id).jqGrid ('getGridParam', 'multiselect');

                    if (selectable)
                       return true;
                    else
                      return false;
                },
                  onSelectRow: function(id, status){                                       

                    var dataFromCellByColumnIndex = $j("#"+subgrid_table_id).jqGrid ('getCell', id, 0);

                    var attrs = dataFromCellByColumnIndex.match(/(id)=[""']?((?:.(?![""']?\s+(?:\S+)=|[>""']))+.)[""']?"/);
                    var idValue = attrs[2];
                    var checkbox = document.getElementById(idValue);
                    checkbox.checked = status;
                  },
                  onSelectAll: function(rowIds, status){
                     var rowIdsArray = rowIds.toString().split(",");
                     for (i=0;i<rowIdsArray.length;i++)
                       {
                         var dataFromCellByColumnIndex = $j("#"+subgrid_table_id).jqGrid ('getCell', rowIdsArray[i], 0);

                         var attrs = dataFromCellByColumnIndex.match(/(id)=[""']?((?:.(?![""']?\s+(?:\S+)=|[>""']))+.)[""']?"/);
                         var idValue = attrs[2];
                         var checkbox = document.getElementById(idValue);
                         checkbox.checked = status;
                       }
                  }
      });
      $j("#"+subgrid_table_id).jqGrid('navGrid',"#"+pager_id,{edit:false,add:false,del:false})
              $j('.ui-jqgrid-bdiv').css({height: 'auto', 'max-height': 200});
              $j("#my_btn").click( function() {
                var selectedContacts = $j("#"+subgrid_table_id).jqGrid('getGridParam','selarrrow');
                if (selectedContacts.toString() != "")
                  {
                    if ($j("#contacts_string").val() != '')
                      {
                        //alert("putting comma in contacts");
                        $j("#contacts_string").val($j("#contacts_string").val() + ",");
                      }
                    if ($j("#contacts_list").val() != '')
                      $j("#contacts_list").val($j("#contacts_list").val() + ",");
                    var contactTokens = selectedContacts.toString().split(",");
                    var dpString = '';
                    var cntctParamString = '';
                    for (j=0;j<contactTokens.length;j++)
                      {
                        var cntTkn = contactTokens[j].split(";");
                        var cntct_ltdId = cntTkn.first();
                        var cntct_name = cntTkn[1];
                        dpString = dpString + cntct_name + ",";
                        cntctParamString = cntctParamString + cntct_ltdId + ",";
                      }
                      dpString = dpString.slice(0, -1);
                      cntctParamString = cntctParamString.slice(0, -1);
                      $j("#contacts_string").val($j("#contacts_string").val() + dpString);
                      $j("#contacts_list").val($j("#contacts_list").val() + cntctParamString);
                        if ($j("#group_list").val() == "")
                          {
                             $j("#recipients_string").val($j("#contacts_string").val());
                             RecordChange();
                          }
                        
                        else
                          {
                            //alert("putting comma in recipients");
                             $j("#recipients_string").val($j("#group_list").val() + "," + $j("#contacts_string").val());
                             RecordChange();
                          }
                    
                  }

                  else
                    {
                         if ($j("#group_list").val() == "" && $j("#contacts_list").val() == "")
                         {
                            $j("#recipients_string").val("");
                         }
                    }
              });

            //IF CONDITION TILL HERE !!!

          },

          onSelectRow: function (rowId, status) {
             $j("#group_tbl").jqGrid ('collapseSubGridRow', rowId);
             var subgrid_table_id = "group_tbl_"+rowId+"_t";
             try
             {
               $j("#"+subgrid_table_id).jqGrid('resetSelection');
               var dataIds = $j("#"+subgrid_table_id).jqGrid('getDataIDs');
               for (i=0;i<dataIds.length;i++)
                         {
                           var dataFromCellByColumnIndex = $j("#"+subgrid_table_id).jqGrid ('getCell', dataIds[i], 0);

                           var attrs = dataFromCellByColumnIndex.match(/(id)=[""']?((?:.(?![""']?\s+(?:\S+)=|[>""']))+.)[""']?"/);

                           var idValue = attrs[2];
                           var checkbox = document.getElementById(idValue);
                           checkbox.checked = false
                         }
               if (status)
                 {                 
$j("#"+subgrid_table_id).setGridParam({multiselect:false}).hideCol($j("#"+subgrid_table_id).getGridParam("colModel")[0].name);
                 }
               else
                 {
                    $j("#"+subgrid_table_id).setGridParam({multiselect:true}).showCol($j("#"+subgrid_table_id).getGridParam("colModel")[0].name);
                 }
             }
             catch(ex){}               
          },

          onSelectAll: function(rowIds, status){
              var rowIdArray = rowIds.toString().split(',');
              for(i=0;i<rowIdArray.length;i++)
                {
                   $j("#group_tbl").jqGrid ('collapseSubGridRow', rowIdArray[i]);
                   var subgrid_table_id = "group_tbl_"+rowIdArray[i]+"_t";
                   try{
                      $j("#"+subgrid_table_id).jqGrid('resetSelection');
                   var dataIds = $j("#"+subgrid_table_id).jqGrid('getDataIDs');
                   if (dataIds != null || dataIds != undefined)
                     {
                       for (j=0;j<dataIds.length;j++)
                             {
                               var dataFromCellByColumnIndex = $j("#"+subgrid_table_id).jqGrid ('getCell', dataIds[j], 0);

                               var attrs = dataFromCellByColumnIndex.match(/(id)=[""']?((?:.(?![""']?\s+(?:\S+)=|[>""']))+.)[""']?"/);

                               var idValue = attrs[2];
                               var checkbox = document.getElementById(idValue);
                               checkbox.checked = false;
                             }
                       if (status)
                         {
                            $j("#"+subgrid_table_id).setGridParam({multiselect:false}).hideCol($j("#"+subgrid_table_id).getGridParam("colModel")[0].name);                        
                         }
                       else
                         {
                            $j("#"+subgrid_table_id).setGridParam({multiselect:true}).showCol($j("#"+subgrid_table_id).getGridParam("colModel")[0].name);
                         }
                     }
                   }
                  catch (ex)
                  {
                    continue;
                  }
                }
          }
      });

      $j("#group_tbl").jqGrid('navGrid','#pager_div',{add:false,edit:false,del:false});

      $j("#my_btn").click( function() {         

          var selectedGroups = $j("#group_tbl").jqGrid('getGridParam','selarrrow');  

          if (selectedGroups.toString() != "")
            {
                var grpTokens = selectedGroups.toString().split(",");           
              var grpParamString = '';
              for (i=0;i<grpTokens.length;i++)
                {
                  if (grpTokens[i] == "")
                    continue;
                  var grp_name = $j('#group_tbl').jqGrid('getCell',grpTokens[i],2);
                  grpParamString = grpParamString + grp_name + ",";
                }               
                grpParamString = grpParamString.slice(0, -1);              

                $j("#group_list").val(grpParamString);
              
                if ($j("#contacts_string").val() == "")
                  {
                     $j("#recipients_string").val($j("#group_list").val());
                    RecordChange();
                  }                  
                else
                  {
                     $j("#recipients_string").val($j("#group_list").val() + "," + $j("#contacts_string").val());
                     RecordChange();
                  }                  
            }
            else
               {
                     $j("#group_list").val("");
                     if ($j("#contacts_string").val() == "")
                     {
                        $j("#recipients_string").val("");
                     }
                }
               
        });
}

*/