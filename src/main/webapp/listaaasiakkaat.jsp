<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<link rel="stylesheet" type="text/css" href="css/main.css">
<title>AsiakasOhjelma</title>

</head>
<body>
<table id="listaus" >
	<thead>	
		<tr>
			<th colspan="4" class="oikealle"><span id="uusiAsiakas">Lisää uusi asiakas</span></th>
		</tr>
		<tr>
			<th class="oikealle">Hakusana:</th>
			<th colspan="4"><input type="text" id="hakusana"></th>
			<th><input type="button" value="hae" id="hakunappi"></th>
		</tr>				
		<tr>
			<th>ID</th>
			<th>Etunimi</th>
			<th>Sukunimi</th>
			<th>Puhelin</th>
			<th>Sposti</th>	
			<th></th>						
		</tr>
	</thead>
	<tbody>
	</tbody>
</table>
<script>
$(document).ready(function(){	
	
	$("#uusiAsiakas").click(function(){
		document.location="lisaaasiakas.jsp";
	});
	
	$("#hakunappi").click(function(){
		haeAsiakkaat();
	});
	
	$(document.body).on("keydown", function(event){
		if(event.which==13){
			haeAsiakkaat();
		}
	});
	$("#hakusana").focus();
});	

function haeAsiakkaat(){
	$("#listaus tbody").empty();
	$.ajax({url:"asiakkaat/" +$("#hakusana").val(), type:"GET", dataType:"json", success:function(result){//Funktio palauttaa tiedot json-objektina		
		$.each(result.asiakkaat, function(i, field){  
        	var htmlStr;
        	htmlStr+="<tr>";
        	htmlStr+="<td>"+field.ID+"</td>";
        	htmlStr+="<td>"+field.etunimi+"</td>";
        	htmlStr+="<td>"+field.sukunimi+"</td>";
        	htmlStr+="<td>"+field.puhelin+"</td>";
        	htmlStr+="<td>"+field.sposti+"</td>"; 
        	htmlStr+="<td><a href='muutaasiakas.jsp?ID="+field.ID+"'>Muuta</a>&nbsp;"; 
        	htmlStr+="<td><span class='poista' onclick=poista('"+field.ID+"')>Poista</span></td>";
        	htmlStr+="</tr>";
        	$("#listaus tbody").append(htmlStr);
        });	
    }});
}
function poista(ID, etunimi, sukunimi){
	if(confirm("Poista asiakas " + ID + etunimi + sukunimi +"?")){
		$.ajax({url:"asiakkaat/"+ID, type:"DELETE", dataType:"json", success:function(result) { //result on joko {"response:1"} tai {"response:0"}
	        if(result.response==0){
	        	$("#ilmo").html("Asiakkaan poisto epäonnistui.");
	        }else if(result.response==1){
	        	$("#rivi_"+ID).css("background-color", "red"); //Värjätään poistetun asiakkaan rivi
	        	alert("Asiakkaan " + ID +" poisto onnistui.");
				haeAsiakkaat();        	
			}
	    }});
	}
}
</script>
</body>
</html>