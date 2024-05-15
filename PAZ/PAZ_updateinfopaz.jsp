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
<c:set var="ruolo_pagina" value="PAZ"/>
<%@ include file="autorizzazione.jspf" %>

<sql:query var="rset_anagrafica">
  SELECT ID_PAZ, NOME, COGNOME, DATA_NASCITA, SESSO, EMAIL, TELEFONO, INDIRIZZO, 
  CODICE_FISC, PROFESSIONE, STATO_SALUTE, ID_DOMANDA, RISPOSTA
  FROM PAZ
  WHERE ID_PAZ = ?
  <sql:param value="${id_user}"/>
</sql:query>

<c:set var="nomeset" value="${rset_anagrafica.rows[0].NOME}"/>
<c:set var="cognomeset" value="${rset_anagrafica.rows[0].COGNOME}"/>
<c:set var="sessoset" value="${rset_anagrafica.rows[0].SESSO}"/>
<c:set var="emailset" value="${rset_anagrafica.rows[0].EMAIL}"/>
<c:set var="telefonoset" value="${rset_anagrafica.rows[0].TELEFONO}"/>
<c:set var="indirizzoset" value="${rset_anagrafica.rows[0].INDIRIZZO}"/>
<c:set var="cod_fiscaleset" value="${rset_anagrafica.rows[0].CODICE_FISC}"/>
<c:set var="professioneset" value="${rset_anagrafica.rows[0].PROFESSIONE}"/>
<c:set var="stato_saluteset" value="${rset_anagrafica.rows[0].STATO_SALUTE}"/>
<c:set var="cod_domandaset" value="${rset_anagrafica.rows[0].ID_DOMANDA}"/>
<c:set var="rispostaset" value="${rset_anagrafica.rows[0].RISPOSTA}"/>

<c:if test="${param.nome != nomeset}">
    <sql:update>
    UPDATE PAZ 
    SET NOME = ?
    WHERE ID_PAZ = ?
    <sql:param value="${param.nome}"/>
    <sql:param value="${id_user}"/>
    </sql:update>
    <c:set var="flag" value="true"/>
</c:if>

<c:if test="${param.cognome != cognomeset}">
    <sql:update>
    UPDATE PAZ 
    SET COGNOME = ?
    WHERE ID_PAZ = ?
    <sql:param value="${param.cognome}"/>
    <sql:param value="${id_user}"/>
    </sql:update>
    <c:set var="flag" value="true"/>
</c:if>

<c:if test="${param.sesso != sessoset}">
    <sql:update>
    UPDATE PAZ 
    SET SESSO = ?
    WHERE ID_PAZ = ?
    <sql:param value="${param.sesso}"/>
    <sql:param value="${id_user}"/>
    </sql:update>
    <c:set var="flag" value="true"/>
</c:if>

<c:if test="${param.email != emailset}">
    <sql:update>
    UPDATE PAZ 
    SET EMAIL = ?
    WHERE ID_PAZ = ?
    <sql:param value="${param.email}"/>
    <sql:param value="${id_user}"/>
    </sql:update>
    <c:set var="flag" value="true"/>
</c:if>

<c:if test="${param.telefono != telefonoset}">
    <sql:update>
    UPDATE PAZ 
    SET TELEFONO = ?
    WHERE ID_PAZ = ?
    <sql:param value="${param.telefono}"/>
    <sql:param value="${id_user}"/>
    </sql:update>
    <c:set var="flag" value="true"/>
</c:if>

<c:if test="${param.indirizzo != indirizzoset}">
    <sql:update>
    UPDATE PAZ 
    SET INDIRIZZO = ?
    WHERE ID_PAZ = ?
    <sql:param value="${param.indirizzo}"/>
    <sql:param value="${id_user}"/>
    </sql:update>
    <c:set var="flag" value="true"/>
</c:if>

<c:if test="${param.cod_fiscale != cod_fiscaleset}">
    <sql:update>
    UPDATE PAZ 
    SET CODICE_FISC = ?
    WHERE ID_PAZ = ?
    <sql:param value="${param.cod_fiscale}"/>
    <sql:param value="${id_user}"/>
    </sql:update>
    <c:set var="flag" value="true"/>
</c:if>

<c:if test="${param.professione != professioneset}">
    <sql:update>
    UPDATE PAZ 
    SET PROFESSIONE = ?
    WHERE ID_PAZ = ?
    <sql:param value="${param.professione}"/>
    <sql:param value="${id_user}"/>
    </sql:update>
    <c:set var="flag" value="true"/>
</c:if>

<c:if test="${param.stato_salute != stato_saluteset}">
    <sql:update>
    UPDATE PAZ 
    SET STATO_SALUTE = ?
    WHERE ID_PAZ = ?
    <sql:param value="${param.stato_salute}"/>
    <sql:param value="${id_user}"/>
    </sql:update>
    <c:set var="flag" value="true"/>
</c:if>

<c:if test="${param.cod_domanda != cod_domandaset}">
    <sql:update>
    UPDATE PAZ 
    SET ID_DOMANDA = ?
    WHERE ID_PAZ = ?
    <sql:param value="${param.cod_domanda}"/>
    <sql:param value="${id_user}"/>
    </sql:update>
    <c:set var="flag" value="true"/>
</c:if>

<c:if test="${param.risposta != rispostaset}">
    <sql:update>
    UPDATE PAZ 
    SET RISPOSTA = ?
    WHERE ID_PAZ = ?
    <sql:param value="${param.risposta}"/>
    <sql:param value="${id_user}"/>
    </sql:update>
    <c:set var="flag" value="true"/>
</c:if>

<c:if test="${flag}">
    <c:set var="msg" scope="request">Le modifiche sono state apportate correttamente!</c:set>
</c:if>

<c:if test="${empty flag}">
    <c:set var="msg" scope="request">Non e' stata applicata nessuna modifica.</c:set>
</c:if>

<jsp:forward page="anagrafica.jsp"/>