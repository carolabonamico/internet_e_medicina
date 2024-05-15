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
<!-- ==== Area Principale ==== -->

<tr>
  <td align="center" valign="center">
    <img src="validation.png" height="150">
  </td>
</tr>
<tr height="60%" width="100%">
  <td valign="middle" align="center" bgcolor="white" colspan="7">
    <h2 align="center" style="color:#25544E">Si stanno per apportare del modifiche
      all'appuntamento "${param.id_appunt_mod}". Procedere con la modifica?</h2>

      <table valign="middle" align="center" border="0" cellspacing="0" cellpadding="10" width="50%" style="color:#468c7f">

        <tr height="60" width="15%">
          <form action="RESP_modifca_appunt.jsp" method="post">
            <td align="right">
              <input type="submit" value="Si" style="color:#25544E">
              <input type="hidden" name="id_appunt_mod" value="${param.id_appunt_mod}"/>
              <input type="hidden" name="luogo_old" value="${param.luogo}"/>
              <input type="hidden" name="dettagli_old" value="${param.dettagli}"/>
              <input type="hidden" name="data_old" value="${param.data}"/>

              <input type="hidden" name="id_iscriz" value="${param.id_iscriz}"/>
              <input type="hidden" name="id_paz" value="${param.id_paz}"/>
              <input type="hidden" name="totconv" value="${param.totconv}"/>
              <input type="hidden" name="nome_studio" value="${param.nome_studio}"/>
            <input type="hidden" name="data_inizio" value="${param.data_inizio}"/>
            <input type="hidden" name="data_fine" value="${param.data_fine}"/>
            </td>
          </form>

          <form action="RESP_appunt_paz.jsp" method="post">
          <td align="left">
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
      </table>
</td>
</tr>

<%@ include file="LAYOUT_BOTTOM.jspf" %>
