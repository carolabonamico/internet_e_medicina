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
<c:set var="ruolo_pagina" value="RESP"/>
<%@ include file="autorizzazione.jspf" %>

<!-- contrrollo sui dati, se anche uno dei dati ÃÂ¨ mancante seganlo l'errore -->
<c:if test="${empty param.Nome_ditta ||
              empty param.responsabile ||
              empty param.mail_farm ||
              empty param.indirizzo ||
              empty param.Username_farm ||
              empty param.password_farm ||
              empty param.conf_pass_farm ||
              empty param.telefono ||
              empty param.indirizzo}">
  <c:set var="errmsg" scope="request"> ATTENZIONE! Mancano dei dati!</c:set>

  <c:if test="${empty param.Nome_Ditta}">
  	<c:set var="errnome" value="true" scope="request"/>
  </c:if>

  <c:if test="${empty param.responsabile}">
  	<c:set var="errrespons" value="true" scope="request"/>
  </c:if>

  <c:if test="${empty param.telefono}">
  	<c:set var="errtell" value="true" scope="request"/>
  </c:if>

  <c:if test="${empty param.mail_farm}">
  	<c:set var="erremail" value="true" scope="request"/>
  </c:if>

  <c:if test="${empty param.indirizzo}">
  	<c:set var="errindirizzo" value="true" scope="request"/>
  </c:if>

  <c:if test="${empty param.Username_farm}">
    <c:set var="errusername_farm" value="true" scope="request"/>
  </c:if>

  <c:if test="${empty param.password_farm}">
    <c:set var="errpassword_farm" value="true" scope="request"/>
  </c:if>

  <c:if test="${empty param.conf_pass_farm}">
    <c:set var="errconf_pass_farm" value="true" scope="request"/>
  </c:if>

  <jsp:forward page="RESP_crea_farm.jsp"/>
</c:if>

<!-- CONTROLLO SE LE Password COMBACIANO -->
<c:if test="${param.password_farm != param.conf_pass_farm}">
 <c:set var="errmsg" scope="request">Le password non coincidono!!</c:set>
 <c:set var="errpassword" value="true" scope="request"/>
 <c:set var="errconf_pass" value="true" scope="request"/>
 <jsp:forward page="RESP_crea_farm.jsp"/>
</c:if>

<!--Controllo se l'username non ÃÂ¨ gia stato utilizzato nel database -->
<sql:query var="ctrl_username">
SELECT USERNAME
FROM ACCOUNT
WHERE USERNAME=?
<sql:param value="${param.Username_farm}"/>
</sql:query>

<c:if test="${not empty ctrl_username.rows}">
<c:set var ="errmsg" scope="request"> L'username inserito e' gia' stato utilizzato. Riprova!!</c:set>
<c:set var="errusername_farm" value="true" scope="request"/>
<jsp:forward page="RESP_crea_farm.jsp"/>
</c:if>

<!--Controllo se la password non ÃÂ¨ gia stata utilizzata nel database -->
<sql:query var="ctrl_password">
 SELECT PASSWORD
 FROM ACCOUNT
 WHERE PASSWORD=?
 <sql:param value="${param.password_farm}"/>
</sql:query>

<c:if test="${not empty ctrl_password.rows}">
 <c:set var ="errmsg" scope="request"> La password inserita e' gia' stata utilizzata. Riprova!!</c:set>
 <c:set var="errpassword_farm" value="true" scope="request"/>
 <c:set var="errconf_pass_farm" value="true" scope="request"/>
 <jsp:forward page="RESP_crea_farm.jsp"/>
</c:if>

<!-- SETTO IL RUOLO NUMERICAMENTE, dato che la registrazione ÃÂ¨ adibita
solo alla farm  setto il ruolo a 4 e lo stato che sarÃÂ  giÃÂ  attivo-->
 <c:set var="ruolo" value="4"/>
 <c:set var="stato_acc" value="20"/>

 <sql:transaction>
   <sql:query var="rset_codice">
    SELECT VALORE
    FROM CONTATORI
    WHERE ATTRIBUTO = 'ACCOUNT'
   </sql:query>
   <c:set var="id_farm" value="${rset_codice.rows[0].valore}"/>

   <sql:update>
    UPDATE CONTATORI set VALORE = VALORE + 1
    WHERE ATTRIBUTO = 'ACCOUNT'
   </sql:update>
 </sql:transaction>

<!-- inserisco i dati nella tabella account -->
<sql:update>
  INSERT INTO ACCOUNT (ID_ACCOUNT, USERNAME, PASSWORD, COD_RUOLO, STATO_ACC)
  VALUES (?,?,?,?,?)
  <sql:param value="${id_farm}"/>
  <sql:param value="${param.Username_farm}"/>
  <sql:param value="${param.password_farm}"/>
  <sql:param value="${ruolo}"/>
  <sql:param value="${stato_acc}"/>
</sql:update>

<!-- inserisco nella tabella -->
<sql:update>
  INSERT INTO FARM (ID_FARM, NOME_DITTA, EMAIL, INDIRIZZO_SEDE,
                    TITOLARE_DITTA, TELEFONO, ID_RESP)
  VALUES(?,?,?,?,?,?,?)
  <sql:param value="${id_farm}"/>
  <sql:param value="${param.Nome_ditta}"/>
  <sql:param value="${param.mail_farm}"/>
  <sql:param value="${param.indirizzo}"/>
  <sql:param value="${param.responsabile}"/>
  <sql:param value="${param.telefono}"/>
  <sql:param value="${id_user}"/>
</sql:update>

<!-- controllo che i dati siano stati inseriti correttamente-->

<sql:query var="rset_inserito">
  SELECT ID_FARM, NOME_DITTA, EMAIL, INDIRIZZO_SEDE, TITOLARE_DITTA, TELEFONO
  FROM FARM
  WHERE ID_FARM=?
  AND NOME_DITTA=?
  AND EMAIL=?
  AND INDIRIZZO_SEDE=?
  AND TITOLARE_DITTA=?
  AND TELEFONO=?
  <sql:param value="${id_farm}"/>
  <sql:param value="${param.Nome_ditta}"/>
  <sql:param value="${param.mail_farm}"/>
  <sql:param value="${param.indirizzo}"/>
  <sql:param value="${param.responsabile}"/>
  <sql:param value="${param.telefono}"/>
</sql:query>

<c:if test="${not empty rset_inserito.rows}">
  <c:set var="okmsg" scope="request">
    <font color="green"> <b>I dati sono stati inseriti correttamente nel DB. </b></font>
  </c:set>
    <jsp:forward page="RESP_crea_farm.jsp"/>
</c:if>
