function apiCategoryChange(sel){
	$("#functions").find("option").each(function(){
		if($(this).val() != "请选择")
			$(this).remove();
	})
	$("span[name='paramsSpan']").each(function(){
		$(this).remove();
	});
	if($(sel).val() != null && $(sel).val() != "请选择"){
			$.get("/functions.json?id="+$(sel).val(),
				function(data){
					$("#functions").append("<option value='请选择'>请选择</option>");
					for(var i = 0;i<data.length ;i++){
							$("#functions").append("<option value='"+data[i].id+"'>"+data[i].name+"</option>");
					}
				});
	}
}
function apiFunctionChange(sel){
	$("span[name='paramsSpan']").each(function(){
		$(this).remove();
	});
	if($(sel).val() != null && $(sel).val() != "请选择"){
		$.get(
			"/params.json?id="+$("#categories").find("option:selected").val()+"&function_id="+$(sel).val(),
			function(data){
				var tr = "";
				for(var i =0 ;i<data.length;i++){
					tr += "<span name='paramsSpan'>"+data[i].name+":<input type='text' id='"+data[i].name+"' /></span><br/>";
				}
				$("#paramsDiv").html(tr);
			});
	}
}

function toFindJson(){
	var urlParam = "method="+$("#functions").find("option:selected").text()+"&";
	$("span[name='paramsSpan']").each(function(){
			var textName = $(this).eq(0).text().substring(0,$(this).eq(0).text().length-1).replace('.','_');
			urlParam += textName+"="+$("#"+textName).val()+"&";
	});
	urlParam+="id="+$("#categories").val()+"&function_id="+$("#functions").val()
	$.get(
		"/top_api/index?"+urlParam,
		function(data){
			$("#resultDiv").html(data);
	});
}
