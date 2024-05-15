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

<!----------SE IL FORM NON E' VUOTO AGGIORNO CODICE E PRESENZA --------------->

    <sql:update>
    UPDATE APPUNTAMENTO
    SET STATO_PRES = 2, PRESENZA = "Presente"
    WHERE ID_APPUNT = ?
    <sql:param value="${param.id_appuntamento}"/>
    </sql:update>

<!-- controllo l'inserimento nel db -->
<sql:query var="ctrl_ok">
  SELECT STATO_PRES, PRESENZA
  FROM APPUNTAMENTO
  WHERE ID_APPUNT=?
  <sql:param value="${param.id_appuntamento}"/>
</sql:query>

<c:if test="${ctrl_ok.rows[0].STATO_PRES == 2 && ctrl_ok.rows[0].PRESENZA == 'Presente'}">
    <c:set var="ok_msg" scope="request" value="true"/>

    <jsp:forward page="PAZ_calintegrato.jsp">
      <jsp:param name="update_nome_studio" value="${param.update_nome_studio}"/>
      <jsp:param name="orario" value="${param.orario}"/>
    </jsp:forward>
 
</c:if>

 <c:set var="no_ok_msg" scope="request" value="true"/>

    <jsp:forward page="PAZ_calintegrato.jsp">
      <jsp:param name="update_nome_studio" value="${param.update_nome_studio}"/>
      <jsp:param name="orario" value="${param.orario}"/>
    </jsp:forward>
