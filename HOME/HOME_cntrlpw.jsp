<%@ page session="true" 
language="java" 
contentType="text/html; charset=UTF-8" 
import="java.sql.*" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://it.unipv.bmilab.uploadtags"      prefix="upload" %>

    <!-- Controllo sui dati, se la risposta e' mancante segnalo l'errore -->
    <c:if test="${empty param.risposta}">
      <c:set var="errrisp" value="true" scope="request"/>
      <c:set var="msg" scope="request">
        Non si e' inserita alcuna risposta.<br/>
      </c:set>
      <c:set var="errflag" value="true"/>
    </c:if>
  
    <!-- Controllo se la risposta combacia con la domanda -->
    <c:if test="${not empty param.risposta}">
      <sql:query var="rset_domanda">
      SELECT S.COD_DOMANDA, P.RISPOSTA, A.PASSWORD
      FROM ACCOUNT A, SICUREZZA S, PAZ P
      WHERE S.COD_DOMANDA = P.ID_DOMANDA
      AND P.ID_PAZ = A.ID_ACCOUNT
      AND A.USERNAME = ?
      AND P.ID_DOMANDA = ?
      AND P.RISPOSTA = ?
      <sql:param value="${param.nome_user}"/>
      <sql:param value="${param.cod_domanda}"/>
      <sql:param value="${param.risposta}"/>
      </sql:query>
  
      <c:if test="${empty rset_domanda.rows}">
        <c:set var="msg" scope="request">
          La risposta indicata non e' corretta. Riprovare!<br/>
        </c:set>
        <c:set var="errflag" value="true"/>
      </c:if>
    </c:if>
  
  <c:if test="${errflag}">
    <jsp:forward page="HOME_pwdimenticata2.jsp">
      <jsp:param name="cod_domanda" value="${param.cod_domanda}"/>
      <jsp:param name="risposta" value="${param.risposta}"/>
      <jsp:param name="nome_user" value="${param.nome_user}"/>
    </jsp:forward>
  </c:if>

  <jsp:forward page="HOME_areariservata.jsp">
    <jsp:param name="username" value="${param.nome_user}"/>
    <jsp:param name="pass" value="${rset_domanda.rows[0].PASSWORD}"/>
  </jsp:forward>