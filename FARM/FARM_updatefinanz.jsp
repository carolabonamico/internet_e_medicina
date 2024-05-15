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

<!-- ==================== Query ===================== -->

<jsp:useBean id="now" class="java.util.Date"/>

<fmt:formatDate value="${now}" var="data_finanziamento"
 pattern="yyyy-MM-dd HH:mm:ss"/>

<fmt:parseDate value="${data_finanziamento}" var="data_ora"
  pattern="yyyy-MM-dd HH:mm:ss"/>

<sql:transaction>
  <sql:update>
    insert into FINANZIAMENTO (ID_FARM, ID_SSC, RATA, DATA_FINANZIAMENTO, IMPORTO, 
    METODO_PAGAMENTO) values (?,?,?,?,?,?)
    <sql:param value="${id_user}"/>
    <sql:param value="${param.id_ssc}"/>

    <c:if test="${param.modpagam =='Rate'}">
      <sql:param value="${param.numrata}"/>
    </c:if>
    <c:if test="${param.modpagam !='Rate'}">
      <sql:param value="0"/>
    </c:if>

    <sql:dateParam value="${data_ora}" type="timestamp"/>
    <sql:param value="${param.importo}"/>
    <sql:param value="${param.modpagam}"/>
  </sql:update>

  <sql:update>
   update SSC set IMPORTO_RAGGIUNTO=IMPORTO_RAGGIUNTO+?
    <sql:param value="${param.importo}"/>
   where ID_SSC=?
    <sql:param value="${param.id_ssc}"/>
  </sql:update>
</sql:transaction>

<c:if test="${not empty aggstato}">

  <sql:update>
   update SSC set COD_STATO_STUDIO=50
   where ID_SSC=?
    <sql:param value="${param.id_ssc}"/>
  </sql:update>

</c:if>

<jsp:forward page="FARM_confermapagam.jsp"/>