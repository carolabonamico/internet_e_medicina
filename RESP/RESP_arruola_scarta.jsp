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

<c:if test="${not empty param.flag_arruola}">
  <c:set var="arr" value="20"/>

<sql:update>
UPDATE ISCRIZIONE
SET COD_STATO_PAZ = ?
WHERE ID_SSC = ?
AND ID_PAZ = ?
   <sql:param value="${arr}"/>
   <sql:param value="${param.id_ssc}"/>
   <sql:param value="${param.id_paz}"/>
</sql:update>

<c:set var="ok_arr" scope="request">
    <font color="green"> <b>Il paziente e' stato arruolato per lo studio. </b></font>
</c:set>

</c:if>

<c:if test="${not empty param.flag_scarta}">
  <c:set var="scr" value="30"/>

<sql:update>
UPDATE ISCRIZIONE
SET COD_STATO_PAZ = ?
WHERE ID_SSC = ?
AND ID_PAZ = ?
   <sql:param value="${scr}"/>
   <sql:param value="${param.id_ssc}"/>
   <sql:param value="${param.id_paz}"/>
</sql:update>

<c:set var="ok_scr" scope="request">
    <font color="green"> <b>Il paziente e' stato scartato dallo studio. </b></font>
</c:set>

</c:if>

<jsp:forward page="RESP_elenco_PAZ_DEF.jsp"/>
