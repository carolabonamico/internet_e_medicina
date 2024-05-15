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

<%-- =================================================================== --%>
<%-- Query per l estrazione dei pazienti iscritti allo studio con visita --%>
<%-- =================================================================== --%>
<sql:query var="rset_paz">
SELECT P.NOME, P.COGNOME, ST.descr, ST.cod, P.ID_PAZ, E.COD_IDONEITA
  FROM ISCRIZIONE I, PAZ P, stato_paz_studio ST, SSC S, ESITO_VISITA E
  WHERE I.ID_PAZ=P.ID_PAZ AND I.COD_STATO_PAZ=ST.cod AND S.ID_SSC=I.ID_SSC AND E.ID_VISITA=I.ID_VISITA
        AND I.ID_SSC = ?
        AND S.ID_RESP = ? 
        AND S.VIS_MED = 1
  <sql:param value="${param.id_ssc}"/>
  <sql:param value="${id_user}"/>
</sql:query>

<%-- ===================================================================== --%>
<%-- Query per l estrazione dei pazienti iscritti allo studio senza visita --%>
<%-- ===================================================================== --%>
<sql:query var="rset_paz_novis">
SELECT P.NOME, P.COGNOME, ST.descr, ST.cod, P.ID_PAZ
  FROM ISCRIZIONE I, PAZ P, stato_paz_studio ST, SSC S
  WHERE I.ID_PAZ=P.ID_PAZ AND I.COD_STATO_PAZ=ST.cod AND S.ID_SSC=I.ID_SSC 
        AND I.ID_SSC = ?
        AND S.ID_RESP = ? 
        AND S.VIS_MED = 0
  <sql:param value="${param.id_ssc}"/>
  <sql:param value="${id_user}"/>
</sql:query>
          
<!-- ==================== Corpo Centrale ===================== -->

      <!-- --------------------- Pulsante indietro --------------------- --> 
      <tr valign="top">
        <td align="left" width="20%">
          <form method="post" action="RESP_studi_pers_pg2.jsp">
            <input type="image" src="undo.png" width="40" height="40" />
               <input type="hidden" name="id_ssc" value="${param.id_ssc}"/>
               <input type="hidden" name="descr" value="${param.descr}"/>
               <input type="hidden" name="nome" value="${param.nome}"/>
               <input type="hidden" name="totconv" value="${param.totconv}"/>
               <input type="hidden" name="vis_med" value="${param.vis_med}"/>
          </form>
        </td>
      </tr>

      <!-- --------------------- Intestazione --------------------- --> 
      <tr>
  <td align="center" colspan="2">
    <table valign="middle" align="center" border="0" width="65%" cellspacing="0" cellpadding="20" style="color:#468c7f">
      <tr>
        <td  align="center" colspan="2">
          <c:if test="${not empty ok_arr}">
            <img src="medical_history.png" height="150" alt="Pazienti">
          </c:if>
          <c:if test="${not empty ok_scr}">
            <img src="medical_history.png" height="150" alt="Pazienti">
          </c:if>
          <c:if test="${not empty ok_drop}">
            <img src="medical_history.png" height="150" alt="Pazienti">
          </c:if>
        </td>
      </tr>
      <tr>
        <td align="center" colspan="2">
          <c:if test="${not empty ok_arr}">
            <b><font color="#CC0000">${ok_arr}</font></b>
          </c:if>
          <c:if test="${not empty ok_scr}">
            <b>${ok_scr}</b>
          </c:if>
          <c:if test="${not empty ok_drop}">
            <b>${ok_drop}</b>
          </c:if>
        </td>
      </tr>

  <c:if test="${empty ok_arr && empty ok_scr && empty ok_drop}">
        <img src="medical_history.png" height="150" alt="Pazienti"/><br/>
        <h3 align="center" style="color:#25544E">Elenco pazienti:<br/></h3>
        <p align="center" style="color:#468c7f">
          <i>In questa sezione e' possibile visualizzare i pazienti che fanno (o hanno fatto) parte dello studio.<br/>
             Se per lo studio e' richiesta una visita medica, vengono visualizzati solo i pazienti idonei.</i>
        </p>
  </c:if>
        </td>
      </tr>

  <c:if test="${param.vis_med == 1 && 
               (empty rset_paz.rows[0].COD_IDONEITA || rset_paz.rows[0].COD_IDONEITA == 0)}">
              <tr>
                <td valign="middle" align="center">
                  <font style="color:red"><b>Non risultano pazienti idonei.<br/></b></font>
                </td>
              </tr>
  </c:if>





      <!-- --------------------------------------------------------- --> 

      <!-- -------------------- Tabella -------------------- -->
      <tr>
        <td align="center">
          <div style="width:900px;height:450px;overflow-y: scroll; border:4px solid #2a5951;">
            <table valign="middle" align="center" border="0" width="100%" cellspacing="0" cellpadding="10">

              <tr bgcolor="#2a5951" style="color:white" height="60" width="15%">
                 <th> Nome </th>
                 <th> Cognome </th>
                 <th> Informazioni Aggiuntive </th>
                 <th> Stato </th>
                 <th> &nbsp </th>
              </tr>

<!-- Se lo studio non richiede la visita medica vengono visualizzati tutti i pazienti -->
<c:if test="${param.vis_med == 0}">
            <c:forEach items="${rset_paz_novis.rows}" var="var_paz">

              <tr bgcolor="f2f2f2" height="50" align="center" valign="middle" style="color:#468c7f">
                  <td>${var_paz.NOME}</td>
                  <td>${var_paz.COGNOME}</td>
                  <td>
                  <form method="post" action="RESP_dettagli_paziente.jsp">
                    <input type="submit" value="Visualizza">
                    <input type="hidden" name="cognome" value="${param.cognome}" />
                    <input type="hidden" name="nome_paz" value="${var_paz.NOME}" />
                    <input type="hidden" name="cognome_paz" value="${var_paz.COGNOME}"/>
                    <input type="hidden" name="descr_paz" value="${var_paz.descr}" />
                    <input type="hidden" name="id_ssc" value="${param.id_ssc}"/>
                    <input type="hidden" name="descr" value="${param.descr}"/>
                    <input type="hidden" name="nome" value="${param.nome}"/>
                    <input type="hidden" name="totconv" value="${param.totconv}"/>
                    <input type="hidden" name="id_paz" value="${var_paz.ID_PAZ}"/>
                    <input type="hidden" name="vis_med" value="${param.vis_med}"/>
                    </form>
                   </td>
                   <td>${var_paz.descr}</td>

              <c:if test="${var_paz.descr != 'Iscritto'}">
                   <td>
                    <form method="post" action="RESP_arruola_scarta.jsp">
                    <input type="submit" value="Arruola" disabled="disabled"/> 
                    <input type="hidden" name="nome_paz" value="${var_paz.NOME}" />
                    <input type="hidden" name="cognome_paz" value="${var_paz.COGNOME}"/>
                    <input type="hidden" name="cod" value="${var_paz.cod}"/>
                    <input type="hidden" name="flag_arruola" value="true"/>
                    <input type="hidden" name="id_ssc" value="${param.id_ssc}"/>
                    <input type="hidden" name="descr" value="${param.descr}"/>
                    <input type="hidden" name="nome" value="${param.nome}"/>
                    <input type="hidden" name="id_paz" value="${var_paz.ID_PAZ}"/>
                    </form>
                    <form method="post" action="RESP_arruola_scarta.jsp">
                    <input type="submit" value="Scarta" disabled="disabled" />   
                    <input type="hidden" name="nome_paz" value="${var_paz.NOME}" />
                    <input type="hidden" name="cognome_paz" value="${var_paz.COGNOME}"/>
                    <input type="hidden" name="cod" value="${var_paz.cod}"/>
                    <input type="hidden" name="flag_scarta" value="true"/>
                    <input type="hidden" name="id_ssc" value="${param.id_ssc}"/>
                    <input type="hidden" name="descr" value="${param.descr}"/>
                    <input type="hidden" name="nome" value="${param.nome}"/>
                    <input type="hidden" name="id_paz" value="${var_paz.ID_PAZ}"/>
                     </form>
                   </td>
               </c:if>
               <c:if test="${var_paz.descr == 'Iscritto'}">
                   <td>
                    <form method="post" action="RESP_conferma_arruola.jsp">
                    <input type="submit" value="Arruola" /> 
                    <input type="hidden" name="nome_paz" value="${var_paz.NOME}" />
                    <input type="hidden" name="cognome_paz" value="${var_paz.COGNOME}"/>
                    <input type="hidden" name="cod" value="${var_paz.cod}"/>
                    <input type="hidden" name="flag_arruola" value="true"/>
                    <input type="hidden" name="id_ssc" value="${param.id_ssc}"/>
                    <input type="hidden" name="descr" value="${param.descr}"/>
                    <input type="hidden" name="nome" value="${param.nome}"/>
                    <input type="hidden" name="id_paz" value="${var_paz.ID_PAZ}"/>
                    </form>
                    <form method="post" action="RESP_conferma_scarta.jsp">
                    <input type="submit" value="Scarta" />   
                    <input type="hidden" name="nome_paz" value="${var_paz.NOME}" />
                    <input type="hidden" name="cognome_paz" value="${var_paz.COGNOME}"/>
                    <input type="hidden" name="cod" value="${var_paz.cod}"/>
                    <input type="hidden" name="flag_scarta" value="true"/>
                    <input type="hidden" name="id_ssc" value="${param.id_ssc}"/>
                    <input type="hidden" name="descr" value="${param.descr}"/>
                    <input type="hidden" name="nome" value="${param.nome}"/>
                    <input type="hidden" name="id_paz" value="${var_paz.ID_PAZ}"/>
                     </form>
                   </td>
               </c:if>
              </tr>
            </c:forEach>
</c:if>

<c:if test="${param.vis_med == 1 && rset_paz.rows[0].COD_IDONEITA == 1}">
            <c:forEach items="${rset_paz.rows}" var="var_paz">

              <tr bgcolor="f2f2f2" height="50" align="center" valign="middle" style="color:#468c7f">
                  <td>${var_paz.NOME}</td>
                  <td>${var_paz.COGNOME}</td>
                  <td>
                  <form method="post" action="RESP_dettagli_paziente.jsp">
                    <input type="submit" value="Visualizza">
                    <input type="hidden" name="cognome" value="${param.cognome}" />
                    <input type="hidden" name="nome_paz" value="${var_paz.NOME}" />
                    <input type="hidden" name="cognome_paz" value="${var_paz.COGNOME}"/>
                    <input type="hidden" name="descr_paz" value="${var_paz.descr}" />
                    <input type="hidden" name="id_ssc" value="${param.id_ssc}"/>
                    <input type="hidden" name="descr" value="${param.descr}"/>
                    <input type="hidden" name="nome" value="${param.nome}"/>
                    <input type="hidden" name="totconv" value="${param.totconv}"/>
                    <input type="hidden" name="id_paz" value="${var_paz.ID_PAZ}"/>
                    <input type="hidden" name="vis_med" value="${param.vis_med}"/>
                    </form>
                   </td>
                   <td>${var_paz.descr}</td>

              <c:if test="${var_paz.descr != 'Iscritto'}">
                   <td>
                    <form method="post" action="RESP_arruola_scarta.jsp">
                    <input type="submit" value="Arruola" disabled="disabled"/> 
                    <input type="hidden" name="nome_paz" value="${var_paz.NOME}" />
                    <input type="hidden" name="cognome_paz" value="${var_paz.COGNOME}"/>
                    <input type="hidden" name="cod" value="${var_paz.cod}"/>
                    <input type="hidden" name="flag_arruola" value="true"/>
                    <input type="hidden" name="id_ssc" value="${param.id_ssc}"/>
                    <input type="hidden" name="descr" value="${param.descr}"/>
                    <input type="hidden" name="nome" value="${param.nome}"/>
                    <input type="hidden" name="id_paz" value="${var_paz.ID_PAZ}"/>
                    </form>
                    <form method="post" action="RESP_arruola_scarta.jsp">
                    <input type="submit" value="Scarta" disabled="disabled" />   
                    <input type="hidden" name="nome_paz" value="${var_paz.NOME}" />
                    <input type="hidden" name="cognome_paz" value="${var_paz.COGNOME}"/>
                    <input type="hidden" name="cod" value="${var_paz.cod}"/>
                    <input type="hidden" name="flag_scarta" value="true"/>
                    <input type="hidden" name="id_ssc" value="${param.id_ssc}"/>
                    <input type="hidden" name="descr" value="${param.descr}"/>
                    <input type="hidden" name="nome" value="${param.nome}"/>
                    <input type="hidden" name="id_paz" value="${var_paz.ID_PAZ}"/>
                     </form>
                   </td>
               </c:if>
               <c:if test="${var_paz.descr == 'Iscritto'}">
                   <td>
                    <form method="post" action="RESP_conferma_arruola.jsp">
                    <input type="submit" value="Arruola" /> 
                    <input type="hidden" name="nome_paz" value="${var_paz.NOME}" />
                    <input type="hidden" name="cognome_paz" value="${var_paz.COGNOME}"/>
                    <input type="hidden" name="cod" value="${var_paz.cod}"/>
                    <input type="hidden" name="flag_arruola" value="true"/>
                    <input type="hidden" name="id_ssc" value="${param.id_ssc}"/>
                    <input type="hidden" name="descr" value="${param.descr}"/>
                    <input type="hidden" name="nome" value="${param.nome}"/>
                    <input type="hidden" name="id_paz" value="${var_paz.ID_PAZ}"/>
                    </form>
                    <form method="post" action="RESP_conferma_scarta.jsp">
                    <input type="submit" value="Scarta" />   
                    <input type="hidden" name="nome_paz" value="${var_paz.NOME}" />
                    <input type="hidden" name="cognome_paz" value="${var_paz.COGNOME}"/>
                    <input type="hidden" name="cod" value="${var_paz.cod}"/>
                    <input type="hidden" name="flag_scarta" value="true"/>
                    <input type="hidden" name="id_ssc" value="${param.id_ssc}"/>
                    <input type="hidden" name="descr" value="${param.descr}"/>
                    <input type="hidden" name="nome" value="${param.nome}"/>
                    <input type="hidden" name="id_paz" value="${var_paz.ID_PAZ}"/>
                     </form>
                   </td>
               </c:if>
              </tr>
            </c:forEach>
</c:if>




            </table>
          </div>
        </td>
      </tr>

<%@ include file="LAYOUT_BOTTOM.jspf" %>