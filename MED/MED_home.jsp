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

<!-- ==================================== TOP =================================== --> 

<%@ include file="LAYOUT_TOP.jspf" %>
<%@ include file="LAYOUT_MENU_MED.jspf" %>  


<!-- ==================== Corpo Centrale ===================== -->
<sql:query var="nome">
  SELECT NOME, COGNOME, SESSO
  FROM MED
  WHERE ID_MED = ?
  <sql:param value="${id_user}"/>
</sql:query>

<sql:query var="visita">
  SELECT P.NOME,P.COGNOME,S.NOME_STUDIO,S.ID_SSC,P.ID_PAZ,E.ID_VISITA
  FROM PAZ P, SSC S, ESITO_VISITA E,ISCRIZIONE I
  WHERE E.ID_VISITA=I.ID_VISITA
        AND I.ID_PAZ=P.ID_PAZ
        AND I.ID_SSC=S.ID_SSC
        AND E.COD_IDONEITA IS NULL
        AND E.ID_MED=?
  <sql:param value="${id_user}"/>
</sql:query>


<!-- ============================ Notifiche in ingresso=========================== --> 

      <tr>
        <td align="center">
          <h2><c:if test="${nome.rows[0].SESSO == 'M'}">Benvenuto Dottor</c:if><c:if test="${nome.rows[0].SESSO == 'F'}">Benvenuta Dottoressa</c:if> ${nome.rows[0].COGNOME} ${nome.rows[0].NOME}</h2>
          <h4><i>Ora e' possibile navigare nella sua area riservata.<br/></i></h4>
        </td>
      </tr>

      <c:if test="${empty visita.rows}">
      <tr>
        <td align="center">
          <img src="welcome.png" height="250" alt="welcome"><br/>
        </td>
      </tr>

      <tr>
        <td align="center">
          <table style="border-bottom:4px solid #2a5951; border-top:4px solid #2a5951;" cellpadding="10">
            <tr>
              <td align="center"><form action="MED_storicovisita.jsp" method="post"/>
                Non sono presenti pazienti da visitare. Per visualizzare le visite concluse,premere qui!<br/></a><br/><input type="submit" value="Vai ai dettagli" style="color:#2a5951"/></form>
              </td>
            </tr>
          </table>
        </td>
      </tr>
    </c:if>

    <c:if test="${not empty visita.rows}">
      <tr>
        <td align="center">
          <img src="notification.png" height="150" alt="Notifica"><br/>
        </td>
      </tr>

      <tr>
        <td align="center">
          <table style="border-bottom:4px solid #2a5951; border-top:4px solid #2a5951;" cellpadding="10">
            <tr>
              <td align="center"><form action="MED_pazienti.jsp" method="post"/>
                Sono presenti pazienti in attesa di visita medica. Per visualizzare le loro generalita',premere qui!<br/><br/><input type="submit" value="Vai ai dettagli" style="color:#2a5951"/></form>
              </td>
            </tr>
          </table>
        </td>
      </tr>
    </c:if>

<!-- ==================================TOP FINALE =================================== --> 

<%@ include file="LAYOUT_BOTTOM.jspf" %>