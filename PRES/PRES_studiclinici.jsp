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
 
<c:set var="ruolo_pagina" value="PRES"/>
<%@ include file="autorizzazione.jspf" %>

<!-- ==================================== TOP =================================== --> 

<%@ include file="LAYOUT_TOP.jspf" %>
<%@ include file="LAYOUT_MENU_PRES.jspf" %>  

<!-- ----------------------QUERY PER TABELLA E FILTRO---------------------- -->

<sql:query var="myssc">
 select ID_SSC, NOME_STUDIO
 from SSC
 where ((COD_STATO_STUDIO=20 AND RIVISTO=0 and ID_PRES IS NULL)
OR (COD_STATO_STUDIO=20 AND RIVISTO=1 AND ID_PRES=?))
<sql:param value="${id_user}"/>

</sql:query>

        <!-- ==================== Corpo Centrale ===================== -->
 <tr height="10" width="100%" valign="middle">
    <td align="center" bgcolor="white" cellpadding="10">
      <img src="healthcare.png" height="150" alt="I miei studi"><br/><br/>
      <h2 style="color:#25544E">Studi attivi<br/></h2>
      <p style="color:#25544E">
        <i>Ora e' possibile visionare gli studi non ancora presi in carico.
        <br/>Attenzione: utilizzare lo scroll per visualizzare tutte le informazioni.<br/> 
        <br>
         Per ripristinare il valore dei filtri, resettare manualmente i campi.</i>
      </p>
   </td>
 </tr>

<c:if test="${not empty messaggio}">
<tr height="20%"> <th> <font style="color:#25544E"> ${messaggio} </font> </th> </tr>
</c:if>

<c:remove var="messaggio" scope="session"/>
<c:remove var="nomestudio" scope="session"/>


                        <!-- ========= filtro ricerca ========= -->

<tr align="center" height="10" > 
    <td align="center" >
      <label for="ricerca">Cerca:</label>
       <input type="text" id="ricerca"  onkeyup="cerca()" name="ricerca" 
        placeholder="Cerca..."><br/><br/>
    </td>
 </tr>
  <!------MESSAGGIO NO STUDI---->
<c:if test="${myssc.rowCount==0}"> 
<tr width=100%><th style="color:#2a5951"><i>Al momento non ci sono studi disponibili</i></th></tr></c:if>
    
                                 <!----- tabella------>
        
<tr width="100%" height="10" >
   <td align="center" >       
      <table border="0" align="center" width="60%"  cellpadding="15" 
         cellspacing="0"  id="tabella">

          <tr align="center" bgcolor="#2a5951" style="color:white" height="60" 
               colspan="3">
                 <th width="20%"></th>     
                <th width="60%"> Nome dello studio</th>
                <th width="20%">&nbsp</th>
  
          </tr>
              
       <!-- ========= estrazione dati dal database nella tabella ========= -->
          <c:forEach items="${myssc.rows}" var="riga_ssc">
          <tr bgcolor="f2f2f2"align="center"  style="color:#468c7f" height="60" width="100%" colspan="3">
            <td align="center"> <img src="studioclinico.png" height="50" width="50"></td>
            <td name="nome_studio" width="50%">${riga_ssc.NOME_STUDIO}</td>
                 <form method="post" action="PRES_ssc.jsp">

                   <td width="50%"><input type="submit" name="visualizza" 
                       value="Visualizza">
                    <input type="hidden" name="form_idssc" value="${riga_ssc.ID_SSC}"> 
                    <input type="hidden" name="form_descrizione" 
                      value="${riga_ssc.NOME_STUDIO}">
                 </form>
             </td>
           </tr> 
          </c:forEach>
     </table>
   </td>
 </tr>


 
        
                  <!-- ========= javascript filtro ricerca ========= -->
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

                         <!-- ========= Layout finale ========= -->



<%@ include file="LAYOUT_BOTTOM.jspf" %>