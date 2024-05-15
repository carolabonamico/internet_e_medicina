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

<%--controllo: se tutti i campi sono vuoti passo errore --%>
<c:choose>
<c:when test="${empty param.data_new  &&
                empty param.luogo_new &&
                empty param.dettagli_new}">

    <c:set var="errmsg" scope="request"> Almeno un campo deve essere stato modificato</c:set>
    <c:set var="data_old" scope="request" value="${param.data_old}"/>
    <c:set var="luogo_old" scope="request" value="${param.luogo_old}"/>
    <c:set var="dettagli_old" scope="request" value="${param.dettagli_old}"/>

    <jsp:forward page="RESP_modifca_appunt.jsp"/>
</c:when>
<c:otherwise>
<!-- parsing della data-->
<c:if test="${not empty param.data_new}">
  <fmt:parseDate  value="${param.data_new}"
                  var="data_ora"
                  pattern="yyyy-MM-dd'T'HH:mm"/>
  <sql:update>
    UPDATE APPUNTAMENTO
    SET DATA_ORA = ?
    WHERE ID_APPUNT = ?
    <sql:dateParam value="${data_ora}" type="timestamp"/>
    <sql:param value="${param.id_appunt_mod}"/>
  </sql:update>
</c:if>

<c:if test="${not empty param.luogo_new}">
  <sql:update>
    UPDATE APPUNTAMENTO
    SET LUOGO = ?
    WHERE ID_APPUNT = ?
    <sql:param value="${param.luogo_new}"/>
    <sql:param value="${param.id_appunt_mod}"/>
  </sql:update>
</c:if>

<c:if test="${not empty param.dettagli_new}">
  <sql:update>
    UPDATE APPUNTAMENTO
    SET DETTAGLI_LUOGO = ?
    WHERE ID_APPUNT = ?
    <sql:param value="${param.dettagli_new}"/>
    <sql:param value="${param.id_appunt_mod}"/>
  </sql:update>
</c:if>


<c:set var="id_iscriz" scope="request">${param.id_iscriz}</c:set>
<c:set var="id_paz" scope="request">${param.id_paz}</c:set>
<c:set var="totconv" scope="request">${param.totconv}</c:set>
<c:set var="nome_studio" scope="request">${param.nome_studio}</c:set>
<c:set var="data_inizio" scope="request">${param.data_inizio}</c:set>
<c:set var="data_fine" scope="request">${param.data_fine}</c:set>
<jsp:forward page="RESP_appunt_paz.jsp"/>

</c:otherwise>
</c:choose>
