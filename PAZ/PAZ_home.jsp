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

<!-- ==================================== TOP =================================== --> 

<%@ include file="LAYOUT_TOP.jspf" %>
<%@ include file="LAYOUT_MENU_PAZ.jspf" %>  


<!-- ==================== Corpo Centrale ===================== -->
<sql:query var="nome">
  SELECT NOME, COGNOME, SESSO
  FROM PAZ
  WHERE ID_PAZ = ?
  <sql:param value="${id_user}"/>
</sql:query>

<sql:query var="stato_paz">
SELECT COUNT(*), COD_STATO_PAZ
FROM ISCRIZIONE
WHERE ID_PAZ = ?
<sql:param value="${id_user}"/>
GROUP BY COD_STATO_PAZ
</sql:query>

<sql:query var="appuntamento_da_convalidare">
  SELECT AP.ID_APPUNT, AP.LUOGO, AP.DETTAGLI_LUOGO, AP.DATA_ORA,
  R.NOME, R.COGNOME, R.ID_RESP, S.NOME_STUDIO
  FROM APPUNTAMENTO AP, AVERE_APPUNT AV, ISCRIZIONE I, RESP R, SSC S
  WHERE AP.ID_APPUNT = AV.ID_APPUNT
  AND AV.ID_ISCRIZIONE = I.ID_ISCRIZ
  AND I.ID_SSC = S.ID_SSC
  AND S.ID_RESP = R.ID_RESP
  AND AP.STATO_PRES = 3
  AND I.ID_PAZ = ?
  ORDER BY AP.DATA_ORA DESC
  <sql:param value="${id_user}"/>
</sql:query>

<!-- QUERY PER IL CALENDARIO GENERALE -->
<sql:query var="calendario">
  SELECT AP.ID_APPUNT, 
  UCASE(LEFT(AP.LUOGO,1)) AS INIZIALE_LUOGO, LCASE(RIGHT(AP.LUOGO,LENGTH(AP.LUOGO)-1)) AS RESTO_LUOGO, 
  UCASE(LEFT(AP.DETTAGLI_LUOGO,1)) AS INIZIALE_DETT_LUOGO, LCASE(RIGHT(AP.DETTAGLI_LUOGO,LENGTH(AP.DETTAGLI_LUOGO)-1)) AS RESTO_DETT_LUOGO,
  AP.DATA_ORA, AP.PRESENZA, SP.DESCRIZIONE_PRES,
  UCASE(LEFT(AP.NOTE,1)) AS INIZIALE_NOTE, LCASE(RIGHT(AP.NOTE,LENGTH(AP.NOTE)-1)) AS RESTO_NOTE,
  R.NOME, R.COGNOME, R.ID_RESP, S.NOME_STUDIO
  FROM APPUNTAMENTO AP, AVERE_APPUNT AV, ISCRIZIONE I, RESP R, SSC S, STATO_PRESENZA SP
  WHERE AP.ID_APPUNT = AV.ID_APPUNT
  AND AV.ID_ISCRIZIONE = I.ID_ISCRIZ
  AND I.ID_SSC = S.ID_SSC
  AND S.ID_RESP = R.ID_RESP
  AND AP.STATO_PRES = SP.STATO_PRES
  AND I.ID_PAZ = ?
  <sql:param value="${id_user}"/>
</sql:query>

<sql:query var="incentivi">
  SELECT S.INCENTIVO, S.ID_SSC, S.NOME_STUDIO, I.COD_STATO_PAZ
  FROM SSC S, ISCRIZIONE I
  WHERE S.ID_SSC = I.ID_SSC
  AND I.ID_PAZ = ?
  <sql:param value="${id_user}"/>
</sql:query>

  <!-- ============================ Notifiche in ingresso =========================== --> 
      <tr>
        <td align="center">
          <h2><c:if test="${nome.rows[0].SESSO == 'M'}">Benvenuto signor</c:if><c:if test="${nome.rows[0].SESSO == 'F'}">Benvenuta signora</c:if> ${nome.rows[0].COGNOME} ${nome.rows[0].NOME}</h2>
          <h4><i>Ora e' possibile navigare nella sua area riservata.<br/></i></h4>
        </td>
      </tr>

      <c:if test="${empty iscrizioni.rows &&
                    empty appuntamento_da_convalidare.rows &&
                    empty calendario.rows &&
                    empty incentivi.rows}">
      <tr>
        <td align="center">
          <img src="welcome.png" height="150" alt="welcome"><br/>
        </td>
      </tr>
      </c:if>

      <c:if test="${not empty iscrizioni.rows ||
        not empty appuntamento_da_convalidare.rows ||
        not empty calendario.rows ||
        not empty incentivi.rows}">
      <tr>
        <td align="center">
          <img src="notification.png" height="150" alt="Notifica"><br/>
        </td>
      </tr>
      
      <tr>
        <td align="center">
          <table style="border-bottom:4px solid #2a5951; border-top:4px solid #2a5951;" cellpadding="10">

          <c:if test="${not empty stato_paz.rows}">
            <c:forEach items="${stato_paz.rows}" var="pos">        
            <tr>

              <c:if test="${pos.COD_STATO_PAZ == 10}">
              <td align="center">
                Per visualizzare gli studi a cui si e' <b>iscritti</b>, premere qui!
              </td>
              </c:if>
              <c:if test="${pos.COD_STATO_PAZ == 20}">
              <td align="center">
                Per visualizzare gli studi a cui si e' <b>arruolati</b>, premere qui!
              </td>
              </c:if>
              <c:if test="${pos.COD_STATO_PAZ == 30}">
              <td align="center">
                Per visualizzare gli studi per cui si e' stati <b>scartati</b>, premere qui!
              </td>
              </c:if>
              <c:if test="${pos.COD_STATO_PAZ == 40}">
              <td align="center">
                Per visualizzare gli studi a cui si e' dichiariti <b>dropout</b>, premere qui!
              </td>
              </c:if>
              <c:if test="${pos.COD_STATO_PAZ == 50}">
              <td align="center">
                Per visualizzare gli studi per cui si e' stati <b>testati</b>, premere qui!
              </td>
              </c:if>

              <td align="center">
                <form method="post" action="PAZ_imieistudi.jsp">
                  <input type="submit" name="home" value="Vai ai dettagli" style="color:#2a5951"/>
                  <input type="hidden" name="codice_stato_studio_home" value="${pos.COD_STATO_PAZ}"/>
               </form>
              </td>
            </tr>
            </c:forEach>
          </c:if>

          <c:if test="${not empty appuntamento_da_convalidare.rows}">
            <tr>
              <td align="center">
                E' presente un <b>appuntamento</b> per cui simulare la presenza. Per visualizzarlo, premere qui!
              </td>
              <td align="center">
              <form method="post" action="PAZ_calintegrato.jsp">
                <input type="submit" value="Vai ai dettagli" style="color:#2a5951"/>
              </form>
              </td>
            </tr>
          </c:if>

          <c:if test="${not empty calendario.rows}">
            <tr>
              <td align="center">
                Sono presenti <b>appuntamenti</b> relativi agli studi per cui si e' stati arruolati. Per visualizzarli, premere qui!
              </td>
              <td align="center">
              <form method="post" action="PAZ_calintegrato.jsp">
                <input type="submit" value="Vai ai dettagli" style="color:#2a5951"/>
              </form>
              <td align="center"></td>
            </tr>
          </c:if>

          <c:if test="${not empty incentivi.rows}">
            <tr>
              <td align="center">
                Per visualizzare il proprio <b>portafoglio incentivi</b>, premere qui!
              </td>
              <td align="center">
              <form method="post" action="PAZ_portafoglio.jsp">
                <input type="submit" value="Vai ai dettagli" style="color:#2a5951"/>
              </form>
              </td>
            </tr>
          </c:if>
          </table>
        </td>
      </tr>
      </c:if>
      

<%@ include file="LAYOUT_BOTTOM.jspf" %>