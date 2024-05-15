<%@ page session="true"
language="java"
contentType="text/html; charset=UTF-8"
import="java.sql.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://it.unipv.bmilab.uploadtags"      prefix="upload" %>

<!-- CONTROLLO SE E' PRESENTE UN UTENTE IN  SESSIONE -->
<c:if test="${empty id_user}">
 <jsp:forward page="HOME_areariservata.jsp"/>
</c:if>

    <!--ESTRAZIONE DEI DATI DAL DATABASE-->
    <sql:query var="rset_account">
      SELECT A.ID_ACCOUNT, A.USERNAME, R.DESCRIZIONE
      FROM ACCOUNT A, RUOLO R
      WHERE A.COD_RUOLO=R.COD_RUOLO
      AND ID_ACCOUNT=?
      AND USERNAME= ?
      <sql:param value="${id_user}"/>
      <sql:param value="${username}"/>
    </sql:query>

 <c:if test="${not empty rset_account.rows}">

      <c:if test="${rset_account.rows[0].DESCRIZIONE == 'FRANK'}">
        <c:set var="ruolo_user" scope="session">${rset_account.rows[0].DESCRIZIONE}</c:set>
        <jsp:forward page="FRANK_home.jsp"/>
      </c:if>

      <c:if test="${rset_account.rows[0].DESCRIZIONE == 'RESP'}">
        <c:set var="ruolo_user" scope="session">${rset_account.rows[0].DESCRIZIONE}</c:set>
        <jsp:forward page="RESP_home.jsp"/>
      </c:if >

      <c:if  test="${rset_account.rows[0].DESCRIZIONE == 'PRES'}">
        <c:set var="ruolo_user" scope="session">${rset_account.rows[0].DESCRIZIONE}</c:set>
        <jsp:forward page="PRES_home.jsp"/>
      </c:if>

      <c:if test="${rset_account.rows[0].DESCRIZIONE == 'FARM'}">
        <c:set var="ruolo_user" scope="session">${rset_account.rows[0].DESCRIZIONE}</c:set>
        <jsp:forward page="FARM_home.jsp"/>
      </c:if>

      <c:if test="${rset_account.rows[0].DESCRIZIONE == 'PAZ'}">
         <c:set var="ruolo_user" scope="session">${rset_account.rows[0].DESCRIZIONE}</c:set>
        <jsp:forward page="PAZ_home.jsp"/>
      </c:if>

      <c:if test="${rset_account.rows[0].DESCRIZIONE == 'MED'}">
        <c:set var="ruolo_user" scope="session">${rset_account.rows[0].DESCRIZIONE}</c:set>
        <jsp:forward page="MED_home.jsp"/>
      </c:if>
</c:if>
