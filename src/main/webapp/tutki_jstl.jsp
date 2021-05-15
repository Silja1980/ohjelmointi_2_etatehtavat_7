<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Asiakas ohjelma</title>
</head>
<body>

JavaServer Pages Standard Tag Library (JSTL)

<br>

<c:set var="name" value="<hr>"/>  
${name} <!-- arvon tulostaminen sellaisenaan, eli tulostaa nyt poikkiviivan  -->
<c:out value='${name}'/>  <!-- arvon tulostaminen html-siivottuna  -->
<!-- ,eli on turvallisempaa aina tulostaa arvot c:out tagin kautta -->
<!-- c: viittaa sanaa core, eli jstl core tags -->
<!-- fn: viittaa sanaa funktio, eli jstl function tags -->
<!-- fmt: viittaa sanaa format, eli jstl formatting tags -->

<br><br>

<a target="_blank" href="https://www.javatpoint.com/jstl-core-tags">JSTL Core Tags</a>

<br><br>

<c:import var="data" url="lisaaasiakas.jsp"/>  
<c:out value="${data}"/>

<br><br>

<c:set var="income" value="${1000*4}"/>  
<c:if test="${income > 3000}">  
   <p>My income is: <c:out value="${income}"/><p>  
</c:if> 
<!-- if..else..end if pitää käyttää c:choose..c:when..c:when..c:otherwise../c:choose -->
<!-- tai erillisiä c:if -lausekkeita (ei else vaihtoehtoa) -->
<!-- tai kolmiosaista if-lausetta {ehto ? totta : ei totta} -->
<br>
<c:set value="36" var="num"/>
<c:out value="Numero ${num} on parillinen: ${num % 2 == 0 ? 'totta': 'ei totta'}"/>
<br>
<c:out value="${income >= 5000 ? 'palkka on vähintään 5000' : 'palkka on alle 5000'}"/>

<br><br>
<%
	ArrayList<String> list = new ArrayList<String>();
	list.add("A");
	list.add("B");
	list.add("C");
	request.setAttribute("a_list", list);
%>
<c:forEach items="${a_list}" var="listItem">
	<c:out value="${listItem}"/> <br />
</c:forEach>

</body>
</html>