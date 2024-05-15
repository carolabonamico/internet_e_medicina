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

<%-- dato che il bottone di chiusura si ha gia'ÃÂ  quando il numero appunt e' corretto
inserisco il valore che permette ai paz di visualizzarlo --%>

<sql:query var="id_appun">
  SELECT A.ID_APPUNT
  FROM APPUNTAMENTO A, ISCRIZIONE I, AVERE_APPUNT V
  WHERE A.ID_APPUNT=V.ID_APPUNT AND V.ID_ISCRIZIONE=I.ID_ISCRIZ
  AND I.ID_ISCRIZ=?
  AND I.ID_PAZ=?
  <sql:param value="${param.id_iscriz}"/>
  <sql:param value="${param.id_paz}"/>
</sql:query>

<c:forEach items="${id_appun.rows}" var="n_app">
  <sql:update>
    UPDATE APPUNTAMENTO SET STATO_PRES = 3
    WHERE ID_APPUNT = ?
    <sql:param value="${n_app.ID_APPUNT}"/>
  </sql:update>
</c:forEach>

<jsp:forward page="RESP_appuntamenti.jsp"/>
