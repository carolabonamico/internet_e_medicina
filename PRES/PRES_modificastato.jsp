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
 
<c:set var="ruolo_pagina" value="PRES"/>
<%@ include file="autorizzazione.jspf" %>

<c:if test="${empty param.motivazione}">
<c:set var="errore" value="ATTENZIONE! L'area di testo deve essere compilata con i motivi della propria scelta!" scope="request"/>
<jsp:forward page="PRES_ssc.jsp">
<jsp:param name="form_idssc" value="${idstudio}"/>
</jsp:forward>
</c:if>

<c:if test="${not empty param.visita}">
<sql:update>
UPDATE SSC set VIS_MED=1
where ID_SSC=?
<sql:param value="${idstudio}"/>
</sql:update>
</c:if>

<c:if test="${empty param.visita}">
<sql:update>
UPDATE SSC set VIS_MED=0
where ID_SSC=?
<sql:param value="${idstudio}"/>
</sql:update>
</c:if>

<c:if test="${not empty param.approva}">
<sql:update>
UPDATE SSC set COD_STATO_STUDIO=40,
ID_PRES=?
<sql:param value="${id_user}"/>
where ID_SSC=?
<sql:param value="${idstudio}"/>
</sql:update>


<sql:update>
UPDATE SSC set RIVISTO=0,
ID_PRES=?
<sql:param value="${id_user}"/>
where ID_SSC=?
<sql:param value="${idstudio}"/>
</sql:update>

<sql:update>
UPDATE SSC set MOTIVAZIONE=?
<sql:param value="${param.motivazione}"/>
where ID_SSC=?
<sql:param value="${idstudio}"/>
</sql:update>
<c:set var="messaggio" value="Lo studio ${nomestudio} e' stato approvato correttamente" scope="request"/>
<jsp:forward page="PRES_imieistudi.jsp"/>
</c:if>


<c:if test="${not empty param.rivisto}">
<sql:update>
UPDATE SSC set COD_STATO_STUDIO=10,ID_PRES=?
<sql:param value="${id_user}"/>
where ID_SSC=?
<sql:param value="${idstudio}"/>
</sql:update>

<sql:update>
UPDATE SSC set RIVISTO=1,ID_PRES=?
<sql:param value="${id_user}"/>
where ID_SSC=?
<sql:param value="${idstudio}"/>
</sql:update>

<sql:update>
UPDATE SSC set MOTIVAZIONE=?
<sql:param value="${param.motivazione}"/>
where ID_SSC=?
<sql:param value="${idstudio}"/>
</sql:update>
<c:set var="messaggio" value="Lo studio ${nomestudio} e' stato rivisto correttamente" scope="request"/>
<jsp:forward page="PRES_studiclinici.jsp"/>
</c:if>




<c:if test="${not empty param.non_approvare}">

<sql:update>
UPDATE SSC set COD_STATO_STUDIO=30,ID_PRES=?
<sql:param value="${id_user}"/>
where ID_SSC=?
<sql:param value="${idstudio}"/>
</sql:update>

<sql:update>
UPDATE SSC set RIVISTO=0,
ID_PRES=?
<sql:param value="${id_user}"/>
where ID_SSC=?
<sql:param value="${idstudio}"/>
</sql:update>

<sql:update>
UPDATE SSC set MOTIVAZIONE=?
<sql:param value="${param.motivazione}"/>
where ID_SSC=?
<sql:param value="${idstudio}"/>
</sql:update>
<c:set var="messaggio" value="Lo studio ${nomestudio} non e' stato approvato " scope="request"/>
<jsp:forward page="PRES_imieistudi.jsp"/>
</c:if>

