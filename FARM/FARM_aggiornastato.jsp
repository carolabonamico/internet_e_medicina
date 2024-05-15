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
<c:set var="ruolo_pagina" value="FARM"/>
<%@ include file="autorizzazione.jspf" %>

<!-- ==================================== QUERY =================================== -->

<c:if test="${not empty aggstato}">

  <sql:update>
   update SSC set COD_STATO_STUDIO=50
   where ID_SSC=?
    <sql:param value="${param.id_ssc}"/>
  </sql:update>

  <jsp:forward page="FARM_confermapagam.jsp"/>

</c:if>

<jsp:forward page="FARM_confermapagam.jsp"/>

