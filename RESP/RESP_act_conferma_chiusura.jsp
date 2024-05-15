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

<%@ include file="LAYOUT_TOP.jspf"%>
<%@ include file="LAYOUT_MENU_RESP.jspf"%>

<!-- Se lo studio non e' da rivedere, e' sufficiente modificare lo stato da 'Bozza' ad 'Inviato' -->
<c:if test="${param.rivisto == 0}">
<c:if test="${not empty param.flag_conf_chiusura}">
  <c:set var="conferma" value="20"/>

<sql:update>
UPDATE SSC
SET COD_STATO_STUDIO = ?
WHERE ID_SSC = ?
   <sql:param value="${conferma}"/>
   <sql:param value="${param.id_ssc}"/>
</sql:update>

<c:set var="ok_conf" scope="request">
    <font color="green"> <b>La notifica e' stata inviata correttamente.</b></font>
</c:set>
</c:if>
</c:if>

<!-- Se lo studio e' da rivedere, devo aggiornare anche il campo 'RISPOSTA' e controllare che la textarea non sia vuota -->
<c:if test="${param.rivisto == 1}">
    <c:if test="${empty param.risposta}">
        <c:set var="errrisp" scope="request">ATTENZIONE! Non e' stato compilato il campo di risposta.</c:set>
        <jsp:forward page="RESP_conferma_chiusura.jsp" />
    </c:if>
<c:if test="${not empty param.flag_conf_chiusura}">
  <c:set var="conferma" value="20"/>

<sql:update>
UPDATE SSC
SET COD_STATO_STUDIO = ?, RISPOSTA=?
WHERE ID_SSC = ?
   <sql:param value="${conferma}"/>
   <sql:param value="${param.risposta}"/>
   <sql:param value="${param.id_ssc}"/>
</sql:update>

<c:set var="ok_conf" scope="request">
    <font color="green"> <b>La notifica e' stata inviata correttamente.</b></font>
</c:set>
</c:if>
</c:if>




<jsp:forward page="RESP_studi_pers_DEF.jsp"/>
