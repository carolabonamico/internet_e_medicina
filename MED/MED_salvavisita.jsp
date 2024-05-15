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
<c:set var="ruolo_pagina" value="MED"/>
<%@ include file="autorizzazione.jspf" %>

<!-- ====================== MESSAGGI D'ERRORE ========================= -->



  <c:if test="${empty param.altezza}">
	<c:set var="erralt" value="true" scope="request"/>
	<c:set var="msg" scope="request">
		${msg}
		Si e' omessa l'altezza.<br/>
	</c:set>
	<c:set var="errflg" value="true"/>
  </c:if>



  <c:if test="${empty param.peso}">
	<c:set var="errpeso" value="true" scope="request"/>
	<c:set var="msg" scope="request">
		${msg}
		Si e' omesso il peso.<br/>
	</c:set>
	<c:set var="errflg" value="true"/>
  </c:if>



 
  <c:if test="${empty param.pressionemin}">
	<c:set var="errpres" value="true" scope="request"/>
	<c:set var="msg" scope="request">
		${msg}
		Si e' omessa la pressione minima.<br/>
	</c:set>
	<c:set var="errflg" value="true"/>
  </c:if>
  <c:if test="${empty param.complicazioni}">
	<c:set var="errcomp" value="true" scope="request"/>
	<c:set var="msg" scope="request">
		${msg}
		Si sono omesse le complicazioni.<br/>
	</c:set>
	<c:set var="errflg" value="true"/>
  </c:if>
  <c:if test="${empty param.pressionemax}">
	<c:set var="errpres1" value="true" scope="request"/>
	<c:set var="msg" scope="request">
		${msg}
		Si e' omessa la pressione massima.<br/>
	</c:set>
	<c:set var="errflg" value="true"/>
  </c:if>

  <c:if test="${empty param.battiti}">
	<c:set var="errbatt" value="true" scope="request"/>
	<c:set var="msg" scope="request">
		${msg}
		Si e' omessa la frequenza cardiaca.<br/>
	</c:set>
	<c:set var="errflg" value="true"/>
  </c:if>
<c:if test="${errflg}">
      <jsp:forward page="MED_visita.jsp">
       <jsp:param name="errore" value="${messaggio}"/>
       <jsp:param   name="paz" value="${param.idpaz}"/>
       <jsp:param name="nome" value="${param.nome}"/>
       <jsp:param name="cognome" value="${param.cognome}"/>
       <jsp:param  name="nascita" value="${param.nascita}"/>
       <jsp:param  name="studio" value="${param.studio}"/>
       <jsp:param  name="cf" value="${param.cf}"/>
       <jsp:param  name="peso" value="${param.peso}"/>
       <jsp:param   name="salute" value="${param.salute}"/>
       <jsp:param   name="idstudio" value="${param.idstudio}"/>
       <jsp:param   name="visita" value="${param.visita}"/>
       <jsp:param   name="altezza" value="${param.altezza}"/>
       <jsp:param  name="battiti" value="${param.battiti}"/>
       <jsp:param  name="complicazioni" value="${param.complicazioni}"/>
       <jsp:param   name="pressionemin" value="${param.pressionemin}"/>
       <jsp:param   name="pressionemax" value="${param.pressionemax}"/>
       <jsp:param   name="idoneita" value="${param.idoneita}"/>
       <jsp:param   name="certificato" value="${param.form_certificato}"/>
      
      </jsp:forward>
  </c:if>


  


<!-- ===================== FORMATO DATA ========================= -->

<%-- DATA CORRENTE --%>
<jsp:useBean id="now" class="java.util.Date"/>
<fmt:formatDate value="${now}" var="data_ora_VISITA"
 pattern="yyyy-MM-dd HH:mm:ss"/>

<fmt:parseDate value="${data_ora_VISITA}" var="data_ora"
  pattern="yyyy-MM-dd HH:mm:ss"/>


<!-- ===================== UPDATE DATABASE ========================= -->



<sql:update>
UPDATE ESITO_VISITA
SET ALTEZZA_CM=?
<sql:param value="${param.altezza}"/>
WHERE 
ID_VISITA=?
AND
ID_MED=?
<sql:param value="${param.idvisita}"/>
<sql:param value="${id_user}"/>
</sql:update>

<sql:update>
UPDATE ESITO_VISITA
SET PESO_KG=?
<sql:param value="${param.peso}"/>
WHERE 
ID_VISITA=?
AND
ID_MED=?
<sql:param value="${param.idvisita}"/>
<sql:param value="${id_user}"/>
</sql:update>

<sql:update>
UPDATE ESITO_VISITA
SET PRESSIONE_MIN=?
<sql:param value="${param.pressionemin}"/>
WHERE 
ID_VISITA=?
AND
ID_MED=?
<sql:param value="${param.idvisita}"/>
<sql:param value="${id_user}"/>
</sql:update>

<sql:update>
UPDATE ESITO_VISITA
SET PRESSIONE_MAX=?
<sql:param value="${param.pressionemax}"/>
WHERE 
ID_VISITA=?
AND
ID_MED=?
<sql:param value="${param.idvisita}"/>
<sql:param value="${id_user}"/>
</sql:update>

<sql:update>
UPDATE ESITO_VISITA
SET FREQUENZA_CARDIACA=?
<sql:param value="${param.battiti}"/>
WHERE 
ID_VISITA=?
AND
ID_MED=?
<sql:param value="${param.idvisita}"/>
<sql:param value="${id_user}"/>
</sql:update>

<sql:update>
UPDATE ESITO_VISITA
SET COMPLICANZE=?
<sql:param value="${param.complicazioni}"/>
WHERE 
ID_VISITA=?
AND
ID_MED=?
<sql:param value="${param.idvisita}"/>
<sql:param value="${id_user}"/>
</sql:update>

<sql:update>
UPDATE ESITO_VISITA
SET DATA_VISITA=?
<sql:dateParam value="${data_ora}"  type="timestamp"/>
WHERE 
ID_VISITA=?
AND
ID_MED=?
<sql:param value="${param.idvisita}"/>
<sql:param value="${id_user}"/>
</sql:update>

<c:if test="${empty param.idoneita}">
<sql:update>
UPDATE ESITO_VISITA
SET COD_IDONEITA=0
WHERE 
ID_VISITA=?
AND
ID_MED=?
<sql:param value="${param.idvisita}"/>
<sql:param value="${id_user}"/>
</sql:update>

  <sql:update>
    UPDATE ISCRIZIONE 
    SET COD_STATO_PAZ = 40
    WHERE ID_VISITA = ?
    <sql:param value="${param.idvisita}"/>
  </sql:update>
  </c:if>

<c:if test="${not empty param.idoneita}">
<sql:update>
UPDATE ESITO_VISITA
SET COD_IDONEITA=1
WHERE 
ID_VISITA=?
AND
ID_MED=?
<sql:param value="${param.idvisita}"/>
<sql:param value="${id_user}"/>
</sql:update>
</c:if>



<upload:saveFileContents inputName="form_certificato"
                          result="certificato_disponibile"
                          fileName="certificato${param.idvisita}.pdf"/>

 <sql:update>
 UPDATE ESITO_VISITA 
 SET CERTIFICATO = ?
<sql:param value="certificato${param.idvisita}"/>
  WHERE ID_VISITA = ?
  AND ID_MED = ?
  <sql:param value="${param.idvisita}"/>
  <sql:param value="${id_user}"/>
  </sql:update>


<c:set var="messaggio" value="La visita del paziente ${param.cognome} ${param.nome} e' stata salvata correttamente." scope="request"/>

<jsp:forward page="MED_storicovisita.jsp"/>



