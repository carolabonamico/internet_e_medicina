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

<!-- =================================== QUERY ======================================= -->
<sql:query var="donazione">
   select ID_SSC, 
          ((COSTO_FISSO_STRUM+COSTO_FISSO_ANALISI+TOTPAZ*INCENTIVO)-IMPORTO_RAGGIUNTO) AS 
          IMP_NEC, 
          IMPORTO_RAGGIUNTO AS IMP_RAGG
   from SSC
   where ID_SSC="${param.id_ssc}" 
</sql:query>

<!-- ============================= ERRORE: PARAMETRO VUOTO =========================== -->
<c:forEach items="${donazione.rows}" var="riga">
  <c:if test="${empty param.importo}">
    <c:set var="errmsg" value="L'importo non e' stato inserito" scope="request"/>
    <jsp:forward page="FARM_importo.jsp"/>
  </c:if>

<!-- ========================= ERRORE: IMPORTO TROPPO GRANDE ========================= -->

  <c:if test="${param.importo>riga.IMP_NEC}">
    <c:set var="errmsg" value="E' stato inserito un importo superiore a quello necessario. 
        <br/>Inserire un importo inferiore o uguale a ${riga.IMP_NEC}" scope="request"/>
    <jsp:forward page="FARM_importo.jsp"/>
  </c:if>

<!-- ================================= TUTTO OKAY ==================================== -->

  <c:if test="${param.importo==riga.IMP_NEC}">
    <c:set var="aggstato" value="1" scope="session"/>
    <jsp:forward page="FARM_modpagam.jsp"/>
  </c:if>


  <jsp:forward page="FARM_modpagam.jsp"/>

</c:forEach>