<%@ page session="true"
language="java"
contentType="text/html; charset=UTF-8"
import="java.sql.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://it.unipv.bmilab.uploadtags"      prefix="upload" %>

<!-- nel caso in cui io sia rimandato alla login tolgo le sessioni per sicurezza -->
<c:remove var="id_user" scope="session"/>
<c:remove var="username" scope="session"/>
<c:remove var="ruolo_user" scope="session"/>

    <!-- CONTROLLO DEI DATI MANCANTI -->
    <c:if test="${empty param.username || empty param.password}">
      <c:set var="errmsg" scope="request">I campi non sono stati compilati correttamente!!</c:set>
      <jsp:forward page="HOME_areariservata.jsp">
        <jsp:param name="username" value="${param.username}"/>
      </jsp:forward>
    </c:if>

    <!-- ESTRAZIONE DEI CAMPI DEL DATABASE tramite query parametrica -->
    <sql:query var="rset_login">
      SELECT ID_ACCOUNT, USERNAME, PASSWORD, STATO_ACC
      FROM ACCOUNT
      where USERNAME = ?
      and PASSWORD = ?
      <sql:param value="${param.username}"/>
      <sql:param value="${param.password}"/>
    </sql:query>

     <c:if test="${empty rset_login.rows}">
       <c:set var="err_user" scope="request">L'Username o la  Password inserita non sono corretti</c:set>
       <jsp:forward page="HOME_areariservata.jsp"/>
     </c:if>

     <c:if test="${rset_login.rows[0].STATO_ACC == 10 || rset_login.rows[0].STATO_ACC == 30 }">
       <c:set var="errmsg" scope="request"> L'account e' stato sospeso,
         oppure e' in via di convalida da parte di FRANK!</c:set>
       <jsp:forward page="HOME_areariservata.jsp"/>
     </c:if>
     
     <c:if test="${not empty rset_login.rows}">
        <c:set var="id_user" scope="session">${rset_login.rows[0].ID_ACCOUNT}</c:set>
        <c:set var="username" scope="session">${param.username}</c:set>
        <jsp:forward page="HOME_dispatch.jsp"/>
     </c:if>
