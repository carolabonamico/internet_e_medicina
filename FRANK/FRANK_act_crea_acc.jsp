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

<!-- contrrollo sui dati-->
<c:if test="${empty param.ruolo ||
              empty param.n_albo ||
              empty param.nome ||              
              empty param.cognome ||
              empty param.sesso ||
              empty param.cod_fiscale ||
              empty param.domicilio ||
              empty param.data_nascita ||
              empty param.telefono ||
              empty param.email ||
              empty param.username ||
              empty param.password ||
              empty param.conf_pass}">
      <c:set var="errmsg" scope="request"> ATTENZIONE! Mancano dei dati!</c:set>

      <c:if test="${empty param.ruolo}">
      	<c:set var="errruolo" value="true" scope="request"/>
      </c:if>

      <c:if test="${empty param.n_albo}">
      	<c:set var="erralbo" value="true" scope="request"/>
      </c:if>

      <c:if test="${empty param.nome}">
      	<c:set var="errnome" value="true" scope="request"/>
      </c:if>

      <c:if test="${empty param.cognome}">
      	<c:set var="errcognome" value="true" scope="request"/>
      </c:if>

      <c:if test="${empty param.sesso}">
      	<c:set var="errsesso" value="true" scope="request"/>
      </c:if>

      <c:if test="${empty param.cod_fiscale}">
      	<c:set var="errcod_fiscale" value="true" scope="request"/>
      </c:if>

      <c:if test="${empty param.domicilio}">
      	<c:set var="errdomicilio" value="true" scope="request"/>
      </c:if>

      <c:if test="${empty param.data_nascita}">
      	<c:set var="errdata_nascita" value="true" scope="request"/>
      </c:if>

      <c:if test="${empty param.telefono}">
      	<c:set var="errtelefono" value="true" scope="request"/>
      </c:if>

      <c:if test="${empty param.email}">
      	<c:set var="erremail" value="true" scope="request"/>
      </c:if>

      <c:if test="${empty param.username}">
        <c:set var="errusername" value="true" scope="request"/>
      </c:if>

      <c:if test="${empty param.password}">
        <c:set var="errpassword" value="true" scope="request"/>
      </c:if>

      <c:if test="${empty param.conf_pass}">
        <c:set var="errconf_pass" value="true" scope="request"/>
      </c:if>

      <jsp:forward page="FRANK_CREA_ACC.jsp"/>
   </c:if>

   <!-- CONTROLLO SE LE Password COMBACIANO -->
   <c:if test="${not empty param.password && not empty param.conf_pass && param.password != param.conf_pass}">
     <c:set var="errmsg" scope="request">Le password non coincidono!!</c:set>
     <c:set var="errpassword" value="true" scope="request"/>
     <c:set var="errconf_pass" value="true" scope="request"/>
     <jsp:forward page="FRANK_CREA_ACC.jsp"/>
   </c:if>

   <!--Controllo se lo username non e gia stato utilizzato  -->
   <sql:query var="ctrl_username">
     SELECT USERNAME
     FROM ACCOUNT
     WHERE USERNAME=?
     <sql:param value="${param.username}"/>
   </sql:query>

   <c:if test="${not empty ctrl_username.rows}">
   <c:set var ="errmsg" scope="request"> 
      L'Username inserito e' gia' stato utilizzato.
   </c:set>
   <c:set var="errusername"  value="true" scope="request"/>
   <jsp:forward page="FRANK_CREA_ACC.jsp"/>
   </c:if>

   <!-- SETTO IL RUOLO E LO STATO -->
   <c:if test="${fn:toUpperCase(param.ruolo) == 'RESPONSABILE'}">
      <c:set var="RUOLO" value="2"/>
   </c:if>
   <c:if test="${fn:toUpperCase(param.ruolo) == 'PRESIDENTE'}">
      <c:set var="RUOLO" value="3"/>
   </c:if>
   <c:if test="${fn:toUpperCase(param.ruolo) == 'MEDICO'}">
      <c:set var="RUOLO" value="6"/>
   </c:if>
   
   <c:set var="STATO_ACC" value="20"/>

   <!-- AGGIORNO IL CONTATORE -->
   <sql:query var="rset_acc">
      SELECT VALORE
      FROM CONTATORI
      WHERE ATTRIBUTO = 'ACCOUNT'
   </sql:query>
   <c:set var="ID" value="${rset_acc.rows[0].valore}"/>

   <sql:update>
    UPDATE CONTATORI set VALORE = VALORE + 1
    WHERE ATTRIBUTO = 'ACCOUNT'
   </sql:update>
   
   <!-- INSERISCO I DATI NELLE TABELLE -->
   <sql:update>
      INSERT INTO ACCOUNT (ID_ACCOUNT, USERNAME, PASSWORD, COD_RUOLO, STATO_ACC)
      VALUES (?,?,?,?,?)
      <sql:param value="${ID}"/>
      <sql:param value="${param.username}"/>
      <sql:param value="${param.password}"/>
      <sql:param value="${RUOLO}"/>
      <sql:param value="${STATO_ACC}"/>
   </sql:update>

   <c:if test="${fn:toUpperCase(param.ruolo) == 'RESPONSABILE'}">
      <sql:update>
         INSERT INTO RESP (ID_RESP, NOME, COGNOME, SESSO, CF, DOMICILIO, DATA_NASCITA, 
            MAIL, CELLULARE, N_ALBO)
         VALUES (?,?,?,?,?,?,?,?,?,?)
         <sql:param value="${ID}"/>
         <sql:param value="${param.nome}"/>
         <sql:param value="${param.cognome}"/>
         <sql:param value="${param.sesso}"/>
         <sql:param value="${param.cod_fiscale}"/>
         <sql:param value="${param.domicilio}"/>
         <sql:param value="${param.data_nascita}"/>
         <sql:param value="${param.email}"/>
         <sql:param value="${param.telefono}"/>
         <sql:param value="${param.n_albo}"/>
      </sql:update>
   </c:if> 

   <c:if test="${fn:toUpperCase(param.ruolo) == 'PRESIDENTE'}">
      <sql:update>
         INSERT INTO PRES (ID_PRES, NOME, COGNOME, SESSO, CF, DOMICILIO, DATA_NASCITA, 
            MAIL, CELLULARE, N_ALBO)
         VALUES (?,?,?,?,?,?,?,?,?,?)
         <sql:param value="${ID}"/>
         <sql:param value="${param.nome}"/>
         <sql:param value="${param.cognome}"/>
         <sql:param value="${param.sesso}"/>
         <sql:param value="${param.cod_fiscale}"/>
         <sql:param value="${param.domicilio}"/>
         <sql:param value="${param.data_nascita}"/>
         <sql:param value="${param.email}"/>
         <sql:param value="${param.telefono}"/>
         <sql:param value="${param.n_albo}"/>
      </sql:update>
   </c:if> 

   <c:if test="${fn:toUpperCase(param.ruolo) == 'MEDICO'}">
      <sql:update>
         INSERT INTO MED (ID_MED, NOME, COGNOME, SESSO, CF, DOMICILIO, DATA_NASCITA, 
            MAIL, CELLULARE, N_ALBO)
         VALUES (?,?,?,?,?,?,?,?,?,?)
         <sql:param value="${ID}"/>
         <sql:param value="${param.nome}"/>
         <sql:param value="${param.cognome}"/>
         <sql:param value="${param.sesso}"/>
         <sql:param value="${param.cod_fiscale}"/>
         <sql:param value="${param.domicilio}"/>
         <sql:param value="${param.data_nascita}"/>
         <sql:param value="${param.email}"/>
         <sql:param value="${param.telefono}"/>
         <sql:param value="${param.n_albo}"/>
      </sql:update>
   </c:if> 

   <c:set var="creamsg" value="true" scope="request" />

 <jsp:forward page="FRANK_elenco_acc.jsp"/>
