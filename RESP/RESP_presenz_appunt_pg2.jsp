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

<!-- ==================== Corpo Centrale ===================== -->

  <!-- --------------------- Pulsante indietro --------------------- -->
      <tr valign="top">
        <td align="center" width="17%">
          <a href="RESP_presenz_appunt.jsp">
            <img src="undo.png" width="40" height="40" title="Indietro">
          </a>
        </td>
        <td width="17%">&nbsp</td>
        <td width="17%">&nbsp</td>
        <td width="17%">&nbsp</td>
        <td width="16%">&nbsp</td>
        <td width="16%">&nbsp</td>
      </tr>

<!-- --------------------- Intestazione --------------------- -->
<tr>
  <td align="center" colspan="6">
    <img src="validation.png" height="150" alt="Validazione"/><br/>
    <h3 align="center" style="color:#25544E">
      Si vuole confermare la presenza del paziente "${param.nome} ${param.cognome}" all'appuntamento del "${param.data}"
    </h3>
  </td>
</tr>

<!-- --------------------- Tabella --------------------- -->
<tr>
  <td align="center" colspan="6">
    <table valign="middle" align="center" border="0" width="85%" cellspacing="0" cellpadding="10">
      <tr  bgcolor="f2f2f2" height="50" align="center" valign="middle" style="color:#468c7f">
        <td><b>Inserire le note sullo stato di salute del paziente, se necessario:</b><br>
             <i>(se il paziente si e' presentato all'appuntamento)</i></td>
        <td>
          <form method="post" action="RESP_controllo_presenza.jsp">
            <textarea name="salute_paz" rows="5" cols="80" wrap="soft"
              placeholder="Inserire qua le note"></textarea>
        </td>
      </tr>
    </table>
  </td>
</tr>

<!-- --------------------- Pulsanti --------------------- -->
<tr>
    <td align="right" width="50%" colspan="3">
      <input type="submit" value="Conferma Presenza" style="color:#25544E"/>
      <input type="hidden" name="flag_presenza" value="true"/>
      <input type="hidden" name="id_appunt" value="${param.id_appunt}"/>
      <input type="hidden" name="id_iscriz" value="${param.id_iscriz}"/>
      <input type="hidden" name="id_ssc" value="${param.id_ssc}"/>
    </td>
  </form>
  <form action="RESP_controllo_presenza.jsp" method="post">
    <td align="left" width="50%" colspan="3">
      <input type="submit" value="Paziente Assente" style="color:#25544E"/>
      <input type="hidden" name="flag_assenza" value="true"/>
      <input type="hidden" name="id_appunt" value="${param.id_appunt}"/>
      <input type="hidden" name="id_iscriz" value="${param.id_iscriz}"/>
      <input type="hidden" name="id_ssc" value="${param.id_ssc}"/>
    </td>
  </form>
</tr>

<%@ include file="LAYOUT_BOTTOM.jspf" %>
