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

   <sql:query var="studio">
        select distinct NOME_STUDIO, COD_STATO_STUDIO, ID_PRES, ID_SSC
        FROM SSC 
        WHERE (COD_STATO_STUDIO=30 || COD_STATO_STUDIO=40 ||COD_STATO_STUDIO=50)
        AND ID_PRES = ?
       <sql:param value="${id_user}"/>

  <%-- CONTROLLO NOME STUDIO --%>
 <c:if test="${not empty param.nome_studio}">
 AND UPPER(NOME_STUDIO) LIKE ?
 <sql:param value="${fn:toUpperCase(param.nome_studio)}%"/>
 </c:if>   
   </sql:query>


        <!-- ==================== Corpo Centrale ===================== -->
<c:remove var="idstudio" scope="session"/>
 
<!-- ===================================INTESTAZIONE ================================ -->

  <tr height="10%" width="100%"  valign="middle">
    <td align="center" bgcolor="white" cellpadding="0">
      <img src="healthcare.png" height="150" alt="I miei studi"><br/><br/>
      <h2 style="color:#25544E">I miei studi<br/></h2>
      <p style="color:#25544E">
        <i>Ora e' possibile visionare gli studi di cui si e' il presidente.
        <br/>           <i>Per ripristinare il valore dei filtri, resettare manualmente i 
            campi</i>
      </p>
    </td>
  </tr>



<c:remove var="messaggio" scope="session"/>
<c:remove var="nomestudio" scope="session"/>


<!-- ==================================== RICERCA =================================== --> 
 
 

 <c:if test="${studio.rowCount == 0 && (
      empty param.nome_studio )}">
      <tr>
        <td valign="middle" align="center">
          <font  style="color:#25544E"><b><i>Al momento non ci sono studi presi in carico.</i></b></font>
        </td>
      </tr>
 </c:if>


 <tr>
   <td valign="middle" align="center">
     <table valign="middle" align="center" border="0" width="30%" cellspacing="0" 
            cellpadding="0">
       <tr bgcolor="f2f2f2" height="40" align="center" valign="middle" 
           style="color:#468c7f">
         <td width="25%"> 
          <img src="bottone_verde.png" height="30" width="30"/> 
         </td>
         <td width="25%" align="left"> <font color="#468c7f">  Approvato  </font></td>

         <td width="25%"> 
          <img src="bottone_rosso.png" height="30" width="30"/> 
         </td>
          <td width="25%" align="left"> <font color="#468c7f">  Annullato  </font> </td>
      </tr>
     </table>
   </td>
 </tr>
<!-- ==================================== FILTRO =================================== --> 

<td align="center"  colspan="4">
  <label for="ricerca">Cerca:</label>
  <input type="text" id="ricerca"  onkeyup="cerca()" name="ricerca" 
  placeholder="Cerca...">
</td>
</tr>
<!----------------------------- messaggio di conferma------------------>
<c:if test="${not empty messaggio}">
<tr height="20%"> <th> <font style="color:#25544E"> ${messaggio} </font> </th> </tr>
</c:if>


<!-- ==================================== TABELLA =================================== --> 

 <tr width="100%"> 
   <td align="center" colspan="3">
    <table border="0" align="center" width="60%" height="100%" cellpadding="15" cellspacing="0" id="tabella">
         <tr  align="center" bgcolor="#2a5951" style="color:white" height="60">
<td></td>
                   <th><b> Nome Studio</b></td>
                   <th><b> Stato Studio </b></td>
                   <th>&nbsp</td>
         </tr>  

         <c:forEach items="${studio.rows}" var="mystudio"> 
         <tr bgcolor="f2f2f2" valign="center"  align="center" style="color:#468c7f" height="50">
<td><img src="volunteering.png" align="center" height="40" width="40"></td>
           <td valign="center"> ${mystudio.NOME_STUDIO}</td>
           <td valign="center">
                    <c:choose> 
                        <c:when test="${mystudio.COD_STATO_STUDIO==40||mystudio.COD_STATO_STUDIO==40||mystudio.COD_STATO_STUDIO==50}">
                            <IMG SRC="bottone_verde.png" align="center" alt="Approvata" 
                              width="30" heigth="30">
                        </c:when>
                        <c:otherwise>
                            <IMG SRC="bottone_rosso.png" align="center" alt="Annullata" 
                              width="30" heigth="30" >
                       </c:otherwise>
                    </c:choose>
            </td>

            <form method="post" action="PRES_ssc.jsp">
                    <td align="center">
                        <input type="submit" name="visualizza2" value="Dettagli" 
                          ></td>
                        <input type="HIDDEN" name="messaggio" value="Questo studio e' gia' 
                           stato preso in carico">
                        <input type="hidden" name="form_idssc" value="${mystudio.ID_SSC}">
            </form>
           </tr>
           </c:forEach> 
     </table>
   </td>
 </tr>



   <!-- ========================JAVASCRIPT FILTRO RICERCA========================= --> 

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
      



<!-- ================================== LAYOUT FINALE================================ --> 

<%@ include file="LAYOUT_BOTTOM.jspf" %>