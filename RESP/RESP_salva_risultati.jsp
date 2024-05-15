<%@ page session="true"
         language="java"
         contentType="text/html; charset=UTF-8"
         import="java.sql.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://it.unipv.bmilab.uploadtags"      prefix="upload" %>

<!-- ==================================== Tagliola =================================== --> 
<c:set var="ruolo_pagina" value="RESP"/>
<%@ include file="autorizzazione.jspf" %>

<!-- controllo che la textarea sia compilata, altrimento stampo errore -->
<c:if test="${empty param.esito}">
  <c:set var="errmsg" scope="request"> ATTENZIONE! Non hai compilato!</c:set>

  <c:if test="${empty param.esito}">
  	<c:set var="erresito" value="true" scope="request"/>
  </c:if>

  <jsp:forward page="RESP_compila_risultati.jsp"/>
</c:if>


<!-- Aggiorno la tabella SSC inserendo l'esito -->
<sql:update>
UPDATE SSC 
SET ESITO = ?
WHERE ID_SSC = ?
<sql:param value="${param.esito}"/>
<sql:param value="${param.id_ssc}"/>
</sql:update>

<!-- controllo che i dati siano stati inseriti correttamente-->

<sql:query var="rset_inser">
  SELECT ESITO
  FROM SSC
  WHERE ID_SSC=?
  AND ESITO=?
  <sql:param value="${param.id_ssc}"/>
  <sql:param value="${param.esito}"/>
</sql:query>

<c:if test="${not empty rset_inser.rows}">
  <c:set var="msgok" scope="request">
    <font color="green"> <b>I dati sono stati inseriti correttamente nel DB. </b></font>
  </c:set>
    <jsp:forward page="RESP_compila_risultati.jsp"/>
</c:if>





