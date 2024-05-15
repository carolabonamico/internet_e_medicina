<%@ page session="true" 
language="java" 
contentType="text/html; charset=UTF-8" 
import="java.sql.*" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://it.unipv.bmilab.uploadtags"      prefix="upload" %>

  <c:if test="${empty param.oggetto}">
    <c:set var="erroggetto" value="true" scope="request"/>
    <c:set var="msg1" scope="request">
      ${msg1}  
      Non si e' inserito alcun oggetto.<br/>
    </c:set>
    <c:set var="errflag" value="true"/>
  </c:if>

    <c:if test="${empty param.nome}">
      <c:set var="errnome" value="true" scope="request"/>
      <c:set var="msg1" scope="request">
        ${msg1}
        Non si e' inserito alcun nome.<br/>
      </c:set>
      <c:set var="errflag" value="true"/>
    </c:if>

    <c:if test="${empty param.messaggio}">
      <c:set var="errmessaggio" value="true" scope="request"/>
      <c:set var="msg1" scope="request">
        ${msg1}
        Non si e' inserito alcun messaggio.<br/>
      </c:set>
      <c:set var="errflag" value="true"/>
    </c:if>
  
  <c:if test="${errflag}">
    <jsp:forward page="Contattaci.jsp">
      <jsp:param name="nome" value="${param.nome}"/>
      <jsp:param name="oggetto" value="${param.oggetto}"/>
      <jsp:param name="messaggio" value="${param.messaggio}"/>
    </jsp:forward>
  </c:if>

  <c:set var="okmsg1" scope="request">
    La richiesta e' stata inoltrata correttamente!<br/>
  </c:set>

  <jsp:forward page="Contattaci.jsp"/>