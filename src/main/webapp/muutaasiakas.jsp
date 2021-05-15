<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" type="text/css" href="css/main.css">
<script src="scripts/main.js"></script>
<title>Asiakkaan muutos</title>
</head>
<body onkeydown="tutkiKey(event)">
<form id="tiedot">
	<table>
		<thead>	
			<tr>
				<th colspan="3" id="ilmo"></th>
				<th colspan="5" class="oikealle"><a href="listaaasiakkaat.jsp" id="takaisin">Takaisin listaukseen</a></th>
			</tr>		
			<tr>
				<th>Etunimi</th>
				<th>Sukunimi</th>
				<th>Puhelin</th>
				<th>S�hk�posti</th>
				<th></th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td><input type="text" name="etunimi" id="etunimi"></td>
				<td><input type="text" name="sukunimi" id="sukunimi"></td>
				<td><input type="text" name="puhelin" id="puhelin"></td>
				<td><input type="text" name="sposti" id="sposti"></td> 
				<td><input type="button" id="tallenna" value="Hyv�ksy" onclick="paivitaTiedot()"></td>
			</tr>
		</tbody>
	</table>
	<input type="hidden" name="ID" id="ID">
</form>
<span id="ilmo"></span>
</body>
<script>
function tutkiKey(event){
	if(event.keyCode==13){//Enter
		vieTiedot();
	}		
}
document.getElementById("etunimi").focus();
	//Haetaan muutettavan auton tiedot. Kutsutaan backin GET-metodia ja v�litet��n kutsun mukana muutettavan tiedon id
	//GET /asiakkaat/haeyksi/id
	var ID = requestURLParam("ID"); //Funktio l�ytyy scripts/main.js paitsi t�ss� tapauksessa tuotu suoraan koodiin mukaan
	fetch("asiakkaat/haeyksi/"+ID, {
		method:'GET'
	})
	.then(function (response) {
		return response.json()
	})
	.then( function (responseJson) {
		console.log("id on " + ID);//tarkistetaan tuleeko oikein t�h�n asti
		console.log(responseJson)
	document.getElementById("ID").value = responseJson.ID;	
	document.getElementById("etunimi").value = responseJson.etunimi;		
	document.getElementById("sukunimi").value = responseJson.sukunimi;	
	document.getElementById("puhelin").value = responseJson.puhelin;	
	document.getElementById("sposti").value = responseJson.sposti;	
	
});	

	

//funktio tietojen p�ivitt�mist� varten. Kutsutaan backin PUT-metodia ja v�litet��n kutsun mukana uudet tiedot json-stringin�.
//PUT /asiakkaat/
function paivitaTiedot(){	
	var ilmo="";
	if(document.getElementById("etunimi").value.length<2){
		ilmo="Etunimi on liian lyhyt!";		
	}else if(document.getElementById("sukunimi").value.length<2){
		ilmo="Sukunimi on liian lyhyt!";		
	}else if(document.getElementById("puhelin").value.length<5){
		ilmo="Puhelinnumero on liian lyhyt!";		
	}else if(document.getElementById("sposti").value.lenght<5){
		ilmo="S�hk�posti ei kelpaa!";		
	}
	console.log(ilmo);
	if(ilmo!=""){
		document.getElementById("ilmo").innerHTML=ilmo;
		setTimeout(function(){ document.getElementById("ilmo").innerHTML=""; }, 5000);
		return;
	}
	document.getElementById("etunimi").value=siivoa(document.getElementById("etunimi").value);
	document.getElementById("sukunimi").value=siivoa(document.getElementById("sukunimi").value);
	document.getElementById("puhelin").value=siivoa(document.getElementById("puhelin").value);
	document.getElementById("sposti").value=siivoa(document.getElementById("sposti").value);	
	
	var formJsonStr=formDataToJSON(document.getElementById("tiedot")); 
	console.log(formJsonStr);
	
	fetch("asiakkaat",{
	      method: 'PUT',
	      body:formJsonStr
	    })
	.then( function (response) {
		return response.json();
	})
	.then( function (responseJson) {
		var vastaus = responseJson.response;		
		if(vastaus==0){
			document.getElementById("ilmo").innerHTML= "Asiakkaan tietojen p�ivitys ep�onnistui";
      }else if(vastaus==1){	        	
      	document.getElementById("ilmo").innerHTML= "Asiakkaan tietojen p�ivitys onnistui";			      	
		}	
		setTimeout(function(){ document.getElementById("ilmo").innerHTML=""; }, 5000);
	});	
	document.getElementById("tiedot").reset(); 
}
//main.js:st� pakko siirt�� koodit t�nne, koska se ei jostain syyst� importoi sit� mukaan. Muuten ei koodi toimi.

function requestURLParam(sParam){
    var sPageURL = window.location.search.substring(1);
    var sURLVariables = sPageURL.split("&");
    for (var i = 0; i < sURLVariables.length; i++){
        var sParameterName = sURLVariables[i].split("=");
        if(sParameterName[0] == sParam){
            return sParameterName[1];
        }
    }
}

function formDataToJSON(data){
	var returnStr="{";
	for(var i=0; i<data.length; i++){		
		returnStr+="\"" +data[i].name + "\":\"" + data[i].value + "\",";
	}	
	returnStr = returnStr.substring(0, returnStr.length - 1); //poistetaan viimeinen pilkku
	returnStr+="}";
	return returnStr;
}
function siivoa(teksti){
	teksti=teksti.replace("<","");
	teksti=teksti.replace(";","");
	teksti=teksti.replace("'","''");
	return teksti;
}
</script>
</html>