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
    <img src="contract.png" height="150">
  </td>
</tr>

<c:if test="${not empty errmsg}">
<tr>
  <td align="center" valign="center">
    <font color="red"> <b>${errmsg}</b></font>
  </td>
</tr>
</c:if>

<tr height="60%" width="100%">
  <td valign="middle" align="center" bgcolor="white" colspan="7">
    <h3 align="center" style="color:#25544E">Inserire le modifche per l'appuntamento "${param.id_appunt_mod}" nei campi sottostanti:</h3>
      <table valign="middle" align="center" border="0" cellspacing="0" cellpadding="15" width="75%" style="color:#468c7f">
        <tr bgcolor="#2a5951" style="color:white" height="60">
          <th colspan="2" align="center"> Dati del vecchio appuntamento</th>
          <th colspan="2" align="center"> Modifiche da apportare</th>
        </tr>

      <form action="RESP_aggiorna_modifica.jsp" method="post">
        <tr bgcolor="#f2f2f2" height="60" width="15%">
            <td width="20%">Vecchia data:</td>
            <td width="30%">
              ${param.data_old}
            </td>
            <td width="20%">Selezionare la nuova data:</td>
            <td width="30%"><input type="datetime-local" name="data_new" value="${param.data_new}"></td>
        </tr>
        <tr height="60" width="15%">
            <td width="20%"> Ubicazione precedente per l'appuntamento:</td>
            <td width="30%">
              ${param.luogo_old}
            </td>
            <td width="20%"> Inserire il nuovo luogo in cui si svolgera' l'appuntamento:</td>
            <td width="30%">
              <textarea name="luogo_new" rows="3" cols="50"
              placeholder="Inserire qui il luogo"
              value="${param.luogo_new}"
              ></textarea>
            </td>
        </tr>
        <tr bgcolor="#f2f2f2" height="60" width="15%">
            <td width="20%"> Precedenti dettagli del luogo dell'appuntamento: </td>
            <td width="30%">
              ${param.dettagli_old}
            </td>
            <td width="20%"> Inserire i nuovi dettagli per il luogo dell'appuntamento: </td>
            <td width="30%">
              <textarea name="dettagli_new" rows="3" cols="50"
              placeholder="Inserie i dettagli. es:(Scala A,Piano 2,Laboratorio 5)"
              value="${param.dettagli_new}"
              ></textarea>
            </td>
        </tr>
</table>
</td>
</tr>
        <tr height="60" width="15%">
          <td colspan="4" align="center">
            <input type="submit" value="Invia Modifica" style="color:#25544E">

            <input type="hidden" name="id_appunt_mod" value="${param.id_appunt_mod}">
            <input type="hidden" name="id_iscriz" value="${param.id_iscriz}"/>
            <input type="hidden" name="id_paz" value="${param.id_paz}"/>
            <input type="hidden" name="totconv" value="${param.totconv}"/>
            <input type="hidden" name="nome_studio" value="${param.nome_studio}"/>

            <input type="hidden" name="data_old" value="${param.data_old}"/>
            <input type="hidden" name="luogo_old" value="${param.luogo_old}"/>
            <input type="hidden" name="dettagli_old" value="${param.dettagli_old}"/>

            <input type="hidden" name="data_inizio" value="${param.data_inizio}"/>
            <input type="hidden" name="data_fine" value="${param.data_fine}"/>

          </td>
          </form>
        </tr>      

<%@ include file="LAYOUT_BOTTOM.jspf" %>
