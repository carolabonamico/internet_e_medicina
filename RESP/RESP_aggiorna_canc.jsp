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

<sql:update>
  DELETE FROM APPUNTAMENTO
  WHERE ID_APPUNT = ?
  <sql:param value="${param.id_appunt}"/>
</sql:update>

<sql:update>
  DELETE FROM AVERE_APPUNT
  WHERE ID_APPUNT = ?
  AND ID_ISCRIZIONE = ?
  <sql:param value="${param.id_appunt}"/>
  <sql:param value="${param.id_iscriz}"/>
</sql:update>

<c:set var="id_iscriz" scope="request">${param.id_iscriz}</c:set>
<c:set var="id_paz" scope="request">${param.id_paz}</c:set>
<c:set var="totconv" scope="request">${param.totconv}</c:set>
<c:set var="nome_studio" scope="request">${param.nome_studio}</c:set>
<c:set var="data_inizio" scope="request"> ${param.data_inizio}</c:set>
<c:set var="data_fine" scope="request">${param.data_fine}</c:set>
<jsp:forward page="RESP_appunt_paz.jsp"/>
