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
<c:set var="ruolo_pagina" value="FRANK"/>
<%@ include file="autorizzazione.jspf" %>

<sql:query var="rset_elenco">
   SELECT USERNAME
   FROM ACCOUNT
   WHERE ID_ACCOUNT = ?
   <sql:param value="${param.id_acc}"/>
</sql:query>

<sql:update>
   DELETE FROM ACCOUNT
   WHERE ID_ACCOUNT = ?
   <sql:param value="${param.id_acc}"/>
</sql:update>

<c:if test="${param.ruolo == 'PAZ'}">
  <sql:update>
     DELETE FROM PAZ
     WHERE ID_PAZ = ?
     <sql:param value="${param.id_acc}"/>
  </sql:update>
</c:if>

<c:if test="${param.ruolo == 'FARM'}">
  <sql:update>
     DELETE FROM FARM
     WHERE ID_FARM = ?
     <sql:param value="${param.id_acc}"/>
  </sql:update>
</c:if>

<c:if test="${param.ruolo == 'RESP'}">
  <sql:update>
     DELETE FROM RESP
     WHERE ID_RESP = ?
     <sql:param value="${param.id_acc}"/>
  </sql:update>
</c:if>

<c:if test="${param.ruolo == 'PRES'}">
  <sql:update>
     DELETE FROM PRES
     WHERE ID_PRES = ?
     <sql:param value="${param.id_acc}"/>
  </sql:update>
</c:if>

<c:set var="okmsg" scope="request">
   L'account ${rset_elenco.rows[0].USERNAME} e' stato eliminato con successo
</c:set>


<jsp:forward page="FRANK_elenco_acc.jsp"/>
