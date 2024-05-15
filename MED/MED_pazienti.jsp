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
     <!-- ------------------------query per pazienti---------------------------- -->

<sql:query var="pazienti">
  SELECT P.NOME,P.COGNOME,S.NOME_STUDIO,S.ID_SSC,P.ID_PAZ,E.ID_VISITA
  FROM PAZ P, SSC S, ESITO_VISITA E,ISCRIZIONE I
  WHERE E.ID_VISITA=I.ID_VISITA
        AND I.ID_PAZ=P.ID_PAZ
        AND I.ID_SSC=S.ID_SSC
        AND E.COD_IDONEITA IS NULL
        AND E.ID_MED=?
  <sql:param value="${id_user}"/>
</sql:query>
<!----------------------------------INTESTAZIONE-------------------------------------->

<tr height="10%" width="100%"  valign="middle">
  <td align="center" bgcolor="white" cellpadding="10" colspan="3">
    <img src="healthcare.png" height="150" alt="I miei studi"><br/><br/>
    <h2 style="color:#25544E">Pazienti da visitare<br/></h2>
    <p style="color:#25544E">
      <i>Ora e' possibile visionare le informazione dei pazienti e degli studi.
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

<!-------------------------------MESS NO PAZIENTI---------------------->


<c:if test="${pazienti.rowCount==0}">
<tr><td align="center" colspan="2"><font style="color:red" ><i><b>Al momento non ci sono pazienti da visitare</b></i></font></td></tr></c:if>
<!-- --------------------------------TABELLA PAZIENTI---------------------------- -->

          
<tr width="100%">
  <td align="center" colspan="2">
    <table border="0" align="center" width="60%" cellpadding="15" 
     cellspacing="0"  id="tabella">
      <tr align="center" bgcolor="#2a5951" style="color:white" height="60" colspan="4">
        <th width="15%"></th>
        <th width="20%"> Paziente</td>
        <th width="20%">Studio Clinico</td>
        <th width="45%" align="center" colspan="2">Dettagli</td>
      </tr>

      <c:forEach items="${pazienti.rows}" var="mypaz">
        <tr  bgcolor="#f2f2f2" height="50"><td width="15%"><img src="patient.png" height="40" width="40"></td>
          <td width="20%" align="center"> ${mypaz.NOME}  ${mypaz.COGNOME}</td>
          <td width="20%"align="center"> ${mypaz.NOME_STUDIO}  </td>
          <td width="22%" align="right">
            <form method="post" action="MED_infopaz.jsp"> 
              <input type="submit" name="paziente" value="Paziente"> 
              <input type="hidden" name="idpaz" value="${mypaz.ID_PAZ}">
              <input type="hidden" name="idstudio" value="${mypaz.ID_SSC}">
              <input type="hidden" name="nomestudio" value="${mypaz.NOME_STUDIO}">
              <input type="hidden" name="idvisita" value="${mypaz.ID_VISITA}">
            </form>
          </td>
          <td width="23%" align="left">
            <form method="post" action="MED_infostudio.jsp"> 
              <input type="submit" name="studio" value="Studio clinico">
              <input type="hidden" name="idstudio" value="${mypaz.ID_SSC}">
              <input type="hidden" name="nomestudio" value="${mypaz.NOME_STUDIO}">
            </form>
          </td>
        </tr>
      </c:forEach>
   </table>
  </td>
</tr>

  <!-- -------------------------------FINE PAGINA------------------------------------->

<%@ include file="LAYOUT_BOTTOM.jspf" %>

<!-- --------------------------- Funzione per barra di ricerca ------------------------->

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