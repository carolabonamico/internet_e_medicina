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

<!-- ================================ CARTA/RATA ===================================== -->
<c:if test="${param.modpagam=='Carta' || param.modpagam=='Rate'}">

  <c:if test="${empty param.intestatario}">
    <c:set var="errint" value="true" scope="request" />
    <c:set var="errflg"  value="true" />
  </c:if>

  <c:if test="${empty param.numcarta}">
    <c:set var="errnum" value="true" scope="request" />
    <c:set var="errflg"     value="true" />
  </c:if>

  <c:if test="${empty param.mese || empty param.anno}">
    <c:set var="errdata" value="true" scope="request" />
    <c:set var="errflg"   value="true" />
  </c:if>

  <c:if test="${empty param.cvv}">
    <c:set var="errcvv" value="true" scope="request" />
    <c:set var="errflg"   value="true" />
  </c:if>

  <c:if test="${not empty errflg}">
    <c:set var="messaggio" value="Si sono omessi alcuni campi" />
  </c:if>

  <c:if test="${errflg}">
    <jsp:forward page="FARM_pagamento.jsp">
      <jsp:param name="errmsg" value="${messaggio}"/>
    </jsp:forward>
  </c:if>

  <jsp:forward page="FARM_riepilogo.jsp"/>
</c:if>

<!-- ================================ PAYPAL ======================================== -->

<c:if test="${param.modpagam=='PayPal'}">

  <c:if test="${empty param.email}">
    <c:set var="erremail" value="true" scope="request" />
    <c:set var="errflg"  value="true" />
  </c:if>

  <c:if test="${empty param.password}">
    <c:set var="errpass" value="true" scope="request" />
    <c:set var="errflg"     value="true" />
  </c:if>

  <c:if test="${not empty errflg}">
    <c:set var="messaggio" value="Si sono omessi alcuni campi" />
  </c:if>

  <c:if test="${errflg}">
    <jsp:forward page="FARM_pagamento.jsp">
      <jsp:param name="errmsg" value="${messaggio}"/>
    </jsp:forward>
  </c:if>

  <jsp:forward page="FARM_riepilogo.jsp"/>

</c:if>

<!-- ================================ BONIFICO ====================================== -->
<c:if test="${param.modpagam=='Bonifico'}">

  <c:if test="${empty param.intestatario}">
    <c:set var="errint" value="true" scope="request" />
    <c:set var="errflg"  value="true" />
  </c:if>

  <c:if test="${empty param.conto}">
    <c:set var="errconto" value="true" scope="request" />
    <c:set var="errflg"     value="true" />
  </c:if>

  <c:if test="${empty param.causale}">
    <c:set var="errcausale" value="true" scope="request" />
    <c:set var="errflg"   value="true" />
  </c:if>

  <c:if test="${not empty errflg}">
    <c:set var="messaggio" value="Si sono omessi alcuni campi" />
  </c:if>

  <c:if test="${errflg}">
    <jsp:forward page="FARM_pagamento.jsp">
      <jsp:param name="errmsg" value="${messaggio}"/>
    </jsp:forward>
  </c:if>

  <jsp:forward page="FARM_riepilogo.jsp"/>

</c:if>