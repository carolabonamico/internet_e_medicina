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

<!--------------------------query per pazienti------------------------------>

<sql:query var="pazienti">
SELECT P.NOME,P.COGNOME,S.NOME_STUDIO,S.ID_SSC,P.ID_PAZ,I.ID_VISITA, E.DATA_VISITA
FROM PAZ P, SSC S, ESITO_VISITA E,ISCRIZIONE I
WHERE E.ID_VISITA=I.ID_VISITA
AND I.ID_PAZ=P.ID_PAZ
AND I.ID_SSC=S.ID_SSC
AND E.COD_IDONEITA IS  NOT NULL
AND E.ID_MED=?
<sql:param value="${id_user}"/>
</sql:query>
<!----------------------------------INTESTAZIONE-------------------------------------->

<tr height="10%" width="100%"  valign="middle">
    <td align="center" bgcolor="white" cellpadding="10" colspan="3">
      <img src="healthcare.png" height="150" alt="I miei studi"><br/><br/>
      <h2 style="color:#25544E">Pazienti visitati<br/></h2>
      <p style="color:#25544E">
        <i>Ora e' possibile visionare i dettagli delle visita svolte.
        <br/>Attenzione: utilizzare lo scroll per visualizzare tutte le informazioni.<br/></i>
      </p>
    </td>
</tr>

       <!-- =============== filtro di ricerca per nome paziente================ -->
<tr> 
 <td align="center" width="33.3%" >
   <label for="ricerca">Cerca:</label>
   <input type="text" id="ricerca"  onkeyup="cerca()" name="ricerca" 
    placeholder="Cerca per nome paziente"><br/><br/>
 </td>

       <!-- =============== filtro di ricerca per nome studio================ -->
 
 <td align="center" width="33.3%" >
  <label for="ricerca">Cerca:</label>
  <input type="text" id="ricerca2"  onkeyup="cerca2()" name="ricerca2" 
  placeholder="Cerca per nome studio"><br/><br/>
 </td>
</tr>
<!--------------------------messaggio visita------------------------->
<c:if test="${pazienti.rowCount==0}">
<tr><td align="center" colspan="2"><font style="color:green" ><i><b>Al momento non ci sono visite effettuate</i></b></font></td></tr></c:if>
<!----------------------------------TABELLA PAZIENTI------------------------------>
<c:if test="${not empty messaggio}">
  <tr valign="middle">
    <td align="center" colspan="2">
      <h4><font color="green">${messaggio}</font></h4>
    </td>
  </tr>
</c:if>

<tr valign="middle">
  <td colspan="2">
    <table border="0" align="center" width="80%" height="100%"  cellpadding="15" 
       cellspacing="0"  id="tabella">
      <tr align="center" bgcolor="#2a5951" style="color:white" height="60">
        <th></th>
        <th>Paziente</th>
        <th>Studio Clinico</th>
        <th>Data della visita</th>
        <th>Dettagli Visita</th>
      </tr>
      
      <c:forEach items="${pazienti.rows}" var="mypaz">
       <tr bgcolor="#f2f2f2" height="60" valign="middle">
        <td align=center><img src="stethoscope.png" height=40" width="40"></td>
        <td align="center">${mypaz.NOME} ${mypaz.COGNOME}</td>
        <td align="center">${mypaz.NOME_STUDIO}</td>

        <!-- Formattazione dell'output date -->
        <fmt:formatDate value="${mypaz.DATA_VISITA}" var="orario_vis"
                        type="both"
                        dateStyle="short"
        />

        <td align="center">${orario_vis}</td>
        <td align="center">
          <form method="post" action="MED_detvisita.jsp">
            <input type="submit" name="paziente" value="Dettagli Visita">
            <input type="hidden" name="idpaz" value="${mypaz.ID_PAZ}">
            <input type="hidden" name="idstudio" value="${mypaz.ID_SSC}">
            <input type="hidden" name="idvisita" value="${mypaz.ID_VISITA}">
            <input type="hidden" name="nomestudio" value="${mypaz.NOME_STUDIO}">
          </form>
        </td>
       </tr>
      </c:forEach>
    </table>
 </td>
</tr>

<!---------------------------------FINE PAGINA------------------------------------->
<%@ include file="LAYOUT_BOTTOM.jspf" %>

    <!-- ---------------- Funzione per barra di ricerca paziente -------------------->
  <SCRIPT>
  function cerca() {
  var input, filter, table, tr, td, i, txtValue;
  input = document.getElementById("ricerca");
  filter = input.value.toUpperCase();
  table = document.getElementById("tabella");
  tr = table.getElementsByTagName("tr");

  for (i = 0; i < tr.length; i++) {
    td = tr[i].getElementsByTagName("td")[1];
    if (td) {
      txtValue = td.textContent || td.innerText;
      if (txtValue.toUpperCase().indexOf(filter) > -1) {
        tr[i].style.display = "";
      } else {
        tr[i].style.display = "none";
      }
    }
  }
}
      </SCRIPT>
  <!-- ---------------- Funzione per barra di ricerca nome studio -------------------->
  <SCRIPT>
  function cerca2() {
  var input, filter, table, tr, td, i, txtValue;
  input = document.getElementById("ricerca2");
  filter = input.value.toUpperCase();
  table = document.getElementById("tabella");
  tr = table.getElementsByTagName("tr");

  for (i = 0; i < tr.length; i++) {
    td = tr[i].getElementsByTagName("td")[2];
    if (td) {
      txtValue = td.textContent || td.innerText;
      if (txtValue.toUpperCase().indexOf(filter) > -1) {
        tr[i].style.display = "";
      } else {
        tr[i].style.display = "none";
      }
    }
  }
}
      </SCRIPT>
