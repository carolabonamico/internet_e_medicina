<%@ page session="true" 
language="java" 
contentType="text/html; charset=UTF-8" 
import="java.sql.*" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://it.unipv.bmilab.uploadtags"      prefix="upload" %>

<c:set var="ruolo_pagina" value="PAZ"/>
<%@ include file="autorizzazione.jspf" %>

<c:if test="${param.conferma == 'Abbandona'}">
  
  <%--INSERIMENTO NELLA TABELLA DELLE ISCRIZIONI DEL CODICE DI DROPOUT--%>
  <sql:update>
    UPDATE ISCRIZIONE
    SET COD_STATO_PAZ = 40 
    WHERE ID_ISCRIZ = ?
    <sql:param value="${param.id_iscrizione}"/>
  </sql:update>

<c:set var="confabb" scope="request" value="true"/>
<jsp:forward page="PAZ_imieistudi.jsp"/>

</c:if>
<c:if test="${param.conferma == 'Cancella iscrizione'}">

<%--CANCELLAZIONE DELL'ISCRIZIONE--%>
<sql:transaction>
  <sql:update>
    DELETE FROM ISCRIZIONE
    WHERE ID_ISCRIZ = ?
    <sql:param value="${param.id_iscrizione}"/>
  </sql:update>
</sql:transaction>

<c:set var="conf_annull_iscriz" scope="request" value="true"/>

<jsp:forward page="PAZ_imieistudi.jsp">
  <jsp:param name="nome_studio_att2" value="${param.nome_studio_att}"/>
</jsp:forward>

</c:if>