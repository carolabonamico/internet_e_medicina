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

<sql:update>
   UPDATE ACCOUNT SET STATO_ACC = 30
   WHERE ID_ACCOUNT = ?
   <sql:param value="${param.id_acc}"/>
</sql:update>

<sql:query var="rset_elenco">
   SELECT USERNAME
   FROM ACCOUNT
   WHERE ID_ACCOUNT = ?
   <sql:param value="${param.id_acc}"/>
</sql:query>

<c:set var="okmsg" scope="request">
   L'account ${rset_elenco.rows[0].USERNAME} e' stato sospeso con successo
</c:set>

<jsp:forward page="FRANK_elenco_acc.jsp"/>