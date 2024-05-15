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

<sql:query var="paz">
  SELECT NOME,COGNOME
  FROM PAZ
  WHERE ID_PAZ= ?
  <sql:param value="${param.id_paz}"/>
</sql:query>

      <!-- ==================== Corpo Centrale ===================== -->
      <tr valign="middle">
        <td colspan="2" align="center"><img src="eraser.png" height="150" alt="Cancella"></td>
      </tr>
      <tr>
        <td colspan="2" align="center">
          <h2>E' sicuro di voler cancellare l'appuntamento "${param.id_appunt_canc}", per lo studio "${param.nome_studio}"
            del paziente "${paz.rows[0].NOME} ${paz.rows[0].COGNOME}", delle "${param.data_studio}"?</h2>
        </td>
      </tr>
      <!-- --------------------- Pulsanti --------------------- -->
      <tr>
        <form action="RESP_aggiorna_canc.jsp" method="post">
          <td align="right" width="50%">
            <input type="submit" value="Si" style="color:#25544E">

            <input type="hidden" name="id_appunt" value="${param.id_appunt_canc}"/>
            <input type="hidden" name="id_iscriz" value="${param.id_iscriz}"/>
            <input type="hidden" name="id_paz" value="${param.id_paz}"/>
            <input type="hidden" name="totconv" value="${param.totconv}"/>
            <input type="hidden" name="nome_studio" value="${param.nome_studio}"/>

            <input type="hidden" name="data_inizio" value="${param.data_inizio}"/>
            <input type="hidden" name="data_fine" value="${param.data_fine}"/>
          </td>
        </form>
        <form action="RESP_appunt_paz.jsp" method="post">
          <td align="left"  width="50%">
            <input type="submit" value="No" style="color:#25544E">
            <input type="hidden" name="id_iscriz" value="${param.id_iscriz}"/>
            <input type="hidden" name="id_paz" value="${param.id_paz}"/>
            <input type="hidden" name="totconv" value="${param.totconv}"/>
            <input type="hidden" name="nome_studio" value="${param.nome_studio}"/>

            <input type="hidden" name="flag_pass" value="true"/>
            <input type="hidden" name="data_inizio" value="${param.data_inizio}"/>
            <input type="hidden" name="data_fine" value="${param.data_fine}"/>
          </td>
        </form>
      </tr>

<%@ include file="LAYOUT_BOTTOM.jspf" %>
