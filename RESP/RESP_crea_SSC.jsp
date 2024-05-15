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
        <!-- Intestazione -->
    <tr>
      <td align="center" colspan="2">
      <img src="health_insurance.png" height="150" alt="SSC"/><br/>
      <h3 align="center" style="color:#25544E">In questa sezione e'
        possibile creare nuove ssc, tramite il modulo sottostante<br/></h3>
      </td>
    </tr>

<c:if test="${not empty errmsg}">
<tr>
  <td> <font color="red"> <b> ${errmsg}</b></font> </td>
</tr>
</c:if>

<form action="RESP_salva_SSC.jsp" method="post">
<tr>
  <td align="center" colspan="2">
    <table valign="middle" align="center" border="0" width="65%" cellspacing="0" cellpadding="15" style="color:#468c7f">
      <tr bgcolor="#f2f2f2">
        <td colspan="2">
          <b><font color="#468c7f">Selezionare lo studio da intraprendere:</font></b><br>
          <i>Il campo e' obbligatorio!!</i>
        </td>
        <td align="left" colspan="2">
          <input type="text" name="studio" value="${param.studio}" size=40 required/>
        </td>
      </tr>

      <tr>
        <td>
          <b><font color="#468c7f">Data di inzio dello studio:</font></b>
        </td>
        <td align="left">
          <input type="date" name="data_inizio" value="${param.data_inizio}">
        </td>

        <td>
          <b><font color="#468c7f">Data di fine dello studio:</font></b>
        </td>
        <td align="left">
          <input type="date" name="data_fine" value="${param.data_fine}">
        </td>
      </tr>

      <tr bgcolor="#f2f2f2">
        <td>
          <b><font color="#468c7f">Costo fisso per la strumentazione:<br><i>(in euro)</i></font></b>
        </td>
        <td align="left">
          <input type="number" min="0" name="costo_stru" value="${param.costo_stru}">
        </td>

        <td>
          <b><font color="#468c7f">Costo fisso per le analisi:<br><i>(in euro)</i></font></b>
        </td>
        <td align="left">
          <input type="number" min="0" name="costo_analisi" value="${param.costo_analisi}">
        </td>
      </tr>

      <tr>
        <td>
          <b><font color="#468c7f">Incentivo assegnato ad ogni paziente:</b><i>(in euro)</i></font></b>
        </td>
        <td align="left">
          <input type="number" min="0" name="incentivo" value="${param.incentivo}">
        </td>

        <td>
          <b><font color="#468c7f">Totale convocazioni per ogni paziente:</font></b>
        </td>
        <td align="left">
          <input type="number" min="1" name="totconv" value="${param.totconv}">
        </td>
      </tr>

      <tr bgcolor="#f2f2f2">
        <td>
          <b><font color="#468c7f">Totale di pazienti reclutabili:</font></b>
        </td>
        <td align="left">
          <input type="number" min="1" name="totpaz" value="${param.totpaz}">
        </td>

        <td>
          <b><font color="#468c7f">Area Terapeutica:</font></b>
        </td>
        <td> <input type="text" name="area" value="${param.area}"></td>
        </tr>

      <tr>
        <td colspan="2" align="center">
          <p><b><font color="#468c7f">Descrizione dello studio:</font></b></p>
          <textarea name="descrizione" cols="70" rows="5" wrap="soft"
                    placeholder="Inserire qui la descrizione dello studio"
                    value="${param.descrizione}">${param.descrizione}</textarea>
        </td>

        <td colspan="2" align="center">
          <p><b><font color="#468c7f">Popolazione ammissibile allo studio:</font></b></p>
          <textarea name="popolazione" cols="70" rows="5" wrap="soft"
                    placeholder="Inserire qui la popolazione ammessa allo studio"
                    value="${param.popolazione}">${param.popolazione}</textarea>
        </td>
      </tr>
    </table>
  </td>
</tr>

<tr>
  <td align="right" width="50%"><input type="submit" value="Salva" style="color:#468c7f"></td>
    <input type="hidden" name="studio" value="${param.studio}"/>
    <input type="hidden" name="area" value="${param.area}"/>
    <input type="hidden" name="flag_mod" value="${param.flag_mod}"/>
    <input type="hidden" name="id_ssc_mod" value="${param.id_ssc_mod}">

    <td align="left" width="50%">
      <input type="reset" name="Reset" style="color:#468c7f">
    </td>
  </form>
</tr>


<%@ include file="LAYOUT_BOTTOM.jspf" %>
