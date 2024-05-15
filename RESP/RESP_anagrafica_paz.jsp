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

<%@ include file="LAYOUT_TOP.jspf"%>
<%@ include file="LAYOUT_MENU_RESP.jspf"%>

<%-- ======================================================================= --%>
<%-- Query per l estrazione dei parametri relativi al paziente               --%>
<%-- ======================================================================= --%>
<sql:query var="rset_paz">
SELECT P.NOME, P.COGNOME, P.SESSO, P.CODICE_FISC, P.DATA_NASCITA, P.TELEFONO, P.EMAIL, P.INDIRIZZO, P.PROFESSIONE, P.STATO_SALUTE
  FROM ISCRIZIONE I, PAZ P
  WHERE I.ID_PAZ = P.ID_PAZ
       AND I.ID_SSC = ?
       AND I.ID_PAZ = ?
  <sql:param value="${param.id_ssc}"/>
  <sql:param value="${param.id_paz}"/>
</sql:query>


      <!-- ==================== Corpo Centrale ===================== -->

      <!-- --------------------- Pulsante indietro --------------------- --> 
      <tr valign="top">
        <td align="center" width="17%">
          <form method="post" action="RESP_dettagli_paziente.jsp">
            <input type="image" src="undo.png" width="40" height="40" />
            <input type="hidden" name="id_ssc" value="${param.id_ssc}" />
            <input type="hidden" name="nome" value="${param.nome}" />
            <input type="hidden" name="nome_paz" value="${param.nome_paz}" />
            <input type="hidden" name="cognome_paz" value="${param.cognome_paz}"/>
            <input type="hidden" name="descr_paz" value="${param.descr_paz}" />
            <input type="hidden" name="totconv" value="${param.totconv}"/>
            <input type="hidden" name="id_paz" value="${param.id_paz}"/>
            <input type="hidden" name="vis_med" value="${param.vis_med}"/>
         </form>
        </td>
        <td width="17%">&nbsp</td>
        <td width="17%">&nbsp</td>
        <td width="17%">&nbsp</td>
        <td width="16%">&nbsp</td>
        <td width="16%">&nbsp</td>
      </tr>

      <!-- --------------------- Tabella --------------------- -->
      <tr>
        <td align="center" colspan="6">
          <form action="RESP_dettagli_paziente.jsp">
            <table valign="middle" align="center" border="0" width="65%" cellspacing="0" cellpadding="10" style="color:#468c7f">
              
            <tr>
              <img src="personal.png" height="150" alt="Informazioni personali"/><br/>
              <h2 style="color:#25544E">Dati anagrafici e generalita'<br/></h2>
            </tr>
                      
            <tr bgcolor="#f2f2f2" height="60" width="15%">
              <td><b>Nome</b></td>
              <td>${rset_paz.rows[0].NOME}</td>
            </tr>
            <tr height="60" width="15%">
              <td><b>Cognome</b></td>
              <td>${rset_paz.rows[0].COGNOME}</td>
            </tr>
            <tr bgcolor="#f2f2f2" height="60" width="15%">
              <td><b>Sesso</b></td>
              <td>${rset_paz.rows[0].SESSO}</td>
            </tr>
            <tr height="60" width="15%">
              <td><b>Codice Fiscale</b></td>
              <td>${rset_paz.rows[0].CODICE_FISC}</td>
            </tr>
            <tr bgcolor="#f2f2f2" height="60" width="15%">
              <td><b>Data di nascita</b></td>
              <td>${rset_paz.rows[0].DATA_NASCITA}</td>
            </tr>
            <tr height="60" width="15%">
              <td><b>Cellulare</b></td>
              <td>${rset_paz.rows[0].TELEFONO}</td>
            </tr>
            <tr bgcolor="#f2f2f2" height="60" width="15%">
              <td><b>E-mail</b></td>
              <td>${rset_paz.rows[0].EMAIL}</td>
            </tr>
            <tr height="60" width="15%">
              <td><b>Domicilio</b></td>
              <td>${rset_paz.rows[0].INDIRIZZO}</td>
            </tr>
            <tr bgcolor="#f2f2f2" height="60" width="15%">
              <td><b>Professione</b></td>
              <td>${rset_paz.rows[0].PROFESSIONE}</td>
            </tr>
            <tr height="60" width="15%">
              <td><b>Stato di Salute</b></td>
              <td>${rset_paz.rows[0].STATO_SALUTE}</td>
            </tr>
            <tr height="60" width="15%">
            </tr>

            </table>
          </form>
        </td>
      </tr>

<%@ include file="LAYOUT_BOTTOM.jspf" %>