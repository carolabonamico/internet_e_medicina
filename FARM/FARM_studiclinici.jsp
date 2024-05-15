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
<c:set var="ruolo_pagina" value="FARM"/>
<%@ include file="autorizzazione.jspf" %>

<!-- =================================== TOP ========================================= -->
<%@ include file="LAYOUT_TOP.jspf"%>
<%@ include file="LAYOUT_MENU_FARM.jspf"%>

<!-- ===================================== Query ===================================== -->

<sql:query var="filtro_stato">
  select DISTINCT s.descr
  from stato_studio s
  where s.cod=20 || s.cod=40
</sql:query>

<!--ESTRAGGO I DATI CHE MI SERVONO NELLE RIGHE DELLA TABELLA-->

<c:if test="${not empty param.studio_select && param.studio_select != '' && 
 param.studio_select=='Inviato' }">
<sql:query var="estraz_dati">
  select DISTINCT ssc.ID_SSC, 
         ssc.NOME_STUDIO, 
         ssc.AREA_TERAPEUTICA, 
         (ssc.COSTO_FISSO_STRUM+ssc.COSTO_FISSO_ANALISI+ssc.TOTPAZ*ssc.INCENTIVO) AS 
         BUDGET_COMPLESSIVO, 
         ssc.IMPORTO_RAGGIUNTO,
         ssc.COD_STATO_STUDIO, 
         s.descr
  from SSC ssc, stato_studio s
  where ssc.COD_STATO_STUDIO=s.cod
  and ssc.COD_STATO_STUDIO=20
</sql:query>
</c:if>

<c:if test="${not empty param.studio_select && param.studio_select != '' && 
              param.studio_select=='Approvato' }">
  <sql:query var="estraz_dati">
    select DISTINCT ssc.ID_SSC, 
           ssc.NOME_STUDIO, 
           ssc.AREA_TERAPEUTICA, 
           (ssc.COSTO_FISSO_STRUM+ssc.COSTO_FISSO_ANALISI+ssc.TOTPAZ*ssc.INCENTIVO) AS 
           BUDGET_COMPLESSIVO, 
           ssc.IMPORTO_RAGGIUNTO,
           ssc.COD_STATO_STUDIO, 
           s.descr
    from SSC ssc, stato_studio s
    where ssc.COD_STATO_STUDIO=s.cod
          and ssc.COD_STATO_STUDIO=40
  </sql:query>
</c:if>

<c:if test="${ empty param.studio_select || param.studio_select == ''}" >
<sql:query var="estraz_dati">
  select DISTINCT ssc.ID_SSC, 
         ssc.NOME_STUDIO, 
         ssc.AREA_TERAPEUTICA, 
         (ssc.COSTO_FISSO_STRUM+ssc.COSTO_FISSO_ANALISI+ssc.TOTPAZ*ssc.INCENTIVO) AS 
         BUDGET_COMPLESSIVO, 
         ssc.IMPORTO_RAGGIUNTO,
         ssc.COD_STATO_STUDIO, 
         s.descr
  from SSC ssc, stato_studio s
  where ssc.COD_STATO_STUDIO=s.cod
  and (ssc.COD_STATO_STUDIO=40 || ssc.COD_STATO_STUDIO=20)
</sql:query>
</c:if>

<!-- =============================== Corpo Centrale ================================== -->
<c:remove var="idstudio" scope="session"/>

<!-- ------------------------------- Intestazione ------------------------------------ -->
<tr height="60%" width="100%"  valign="middle">
  <td colspan="4" align="center" bgcolor="white" cellpadding="10">
    <img src="healthcare2.png" height="150" alt="I miei studi"><br/><br/>
      <h2 style="color:#25544E">Studi Clinici<br/></h2>
        <p style="color:#25544E">
          <i>In questa area e' possibile visualizzare gli studi clinici in attesa di 
             approvazione o gia' approvati. E' possibile finanziare solo gli studi clinici 
             approvati.</i>
        </p> 
  </td>
</tr>
<!-- ================================ primo filtro =================================== -->
<tr align="center">
 <td align="center" width="50%" >
  <form action="#" method="post">
      <select name="studio_select" onChange="this.form.submit();">
        <option value=""> -- Stato Studio -- </option>
        <c:forEach items="${filtro_stato.rows}" var="studio">
          <option value="${studio.descr}"
            <c:if test="${param.studio_select == studio.descr}">
            selected="selected"
            </c:if>
            > ${studio.descr}</option>
        </c:forEach>
      </select>
     </form>
  </td>

<!-- ============================= secondo filtro =================================== -->
 <td align="center" width="50%" >
  <label for="ricerca">Cerca:</label>
  <input type="text" id="ricerca"  onkeyup="cerca()" name="ricerca" 
  placeholder="Cerca per nome dello studio"><br/><br/>
 </td>
</tr>

<!-- -------------------------------- Tabella scrollabile --------------------------- -->
       <tr height="60%" width="100%"> 
          <td valign="middle" align="center" colspan="2" height="100%" width="100%">
              <table valign="middle" align="center" border="0" width="80%" cellspacing="0" 
                 cellpadding="15" id="tabella">
                <tr bgcolor="#2a5951" style="color:white" height="60">
             
                   <th width="15%"> Nome Studio </th>
                   <th width="15%"> Area Terapeutica </th>
                   <th width="15%"> Budget Complessivo </th> 
                   <th width="15%"> Importo Raggiunto</th>
                   <th width="15%"> Stato Studio </th>
                   <th width="15%">&nbsp</th>
                </tr>  

                <c:forEach items="${estraz_dati.rows}" var="dati"> 
                <tr valign="middle" align="center" style="color:#468c7f" height="70" 
                 bgcolor="f2f2f2">

                    <td width="15%"><c:out value="${dati.NOME_STUDIO}"/></td>
                    <td width="15%"><c:out value="${dati.AREA_TERAPEUTICA}"/></td>
                    <td width="15%">${dati.BUDGET_COMPLESSIVO} Euro</td>
                    <td width="15%">${dati.IMPORTO_RAGGIUNTO} Euro</td>
                    <td width="15%">${dati.descr}</td>

                  <form method="post" action="FARM_ssc.jsp">
                    <td width="15%">
                        <input type="submit" name="visualizza" value="Visualizza"> </td>
                        <input type="hidden" name="id_ssc" value="${dati.ID_SSC}">
                  </form>
                </tr>
               </c:forEach> 
              </table>
          </td>
        </tr> 
 <!-- --------------------------- Funzione per barra di ricerca ------------------------->
  <SCRIPT>
  function cerca() {
  var input, filter, table, tr, td, i, txtValue;
  input = document.getElementById("ricerca");
  filter = input.value.toUpperCase();
  table = document.getElementById("tabella");
  tr = table.getElementsByTagName("tr");

  for (i = 0; i < tr.length; i++) {
    td = tr[i].getElementsByTagName("td")[0];
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

<%@ include file="LAYOUT_BOTTOM.jspf" %>