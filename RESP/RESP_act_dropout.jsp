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

<!-- Aggiorno lo stato del paziente da 'Arruolato' a 'Dropout' -->

<c:if test="${not empty param.flag_drop}">
  <c:set var="drop" value="40"/>

<sql:update>
UPDATE ISCRIZIONE
SET COD_STATO_PAZ = ?
WHERE ID_SSC = ?
   <sql:param value="${drop}"/>
   <sql:param value="${param.id_ssc}"/>
</sql:update>

<c:set var="ok_drop" scope="request">
    <font color="green"> <b>Il paziente e' stato dichiarato drop-out. </b></font>
</c:set>

</c:if>

<jsp:forward page="RESP_elenco_PAZ_DEF.jsp"/>
