/**
 * 
 */
function search(){
	
	var keyword = $('#keyword').val();
	location.href = 'boardList.jsp?keyword='+keyword;
}
