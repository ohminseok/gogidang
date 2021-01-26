var s_addr = [];
	var meat =[];   
	
	$('#checkBtn').click(function() {
		s_addr = [];
		meat = [];
		
		if($('input[name=f_Acheck]').is(":checked") == true) {
			$('input[name=f_Acheck]:checked').each(function() {
				s_addr.push($(this).val());
			});
		}
		
		if($('input[name=f_Mcheck]').is(":checked") == true){
			$('input[name=f_Mcheck]:checked').each(function() {
				meat.push($(this).val());
			});
		}
		
		getlist(s_addr, meat);

	})
	
	function getlist(s_addr, meat) {
		var params = {"s_addr" : s_addr, "meat" : meat};
	 	$.ajax({
				//type:'post',
				url:'./storelist_ajax.li',
				contentType : "application/json; charset=utf-8",
				data: JSON.stringify(params),
				type : "POST",
				dataType: 'json',
				
				success : function(data)
				{
					$('#card_row').empty();
					$.each(data, function(index, item){
						console.log(item)
						var output= '';
						if (item.meat == 0){
							meat = '소고기'
						}
						else {
							meat = '돼지고기'
						}
						
						output += '<div class="card_store_box">'+
									'<div class="card_store_addr" >'+
										'<div class="text_left">'+
											'<h5>'+ item.s_addr + '</h5>'+
										'</div>'+
									'</div>';
						output += '<div class="card_store_img" >' + 
									'<div>'+
										'<img src=resources/img/store/'+ item.thumbnail +'>' +
									'</div>' +
								'</div>';
						output += '<div class="card_store_name" >'+
									'<div class="text_right">' +
										'<h5>' +
											'<a href="#">' + item.s_name + '</a>'+
										'</h5>' +
									'</div>' +
								'</div>' ;
						output += '<div class="card_store_tag" >' +
										'<div class="text_right">'+
											meat +
										'</div>' +
									'</div>' +
								'</div>'; //class="card_store_box" 끝
								
						$('#card_row').append(output);
						
					});//each 끝			
				}, //success 끝  
				error : function(Request,Status, error) { 
					alert("오류");
				}//error 끝
			}); //ajax끝
		};//input:checked끝