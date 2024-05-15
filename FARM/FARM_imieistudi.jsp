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

<%@ include file="LAYOUT_TOP.jspf"%>
<%@ include file="LAYOUT_MENU_FARM.jspf"%>

<!-- ==================== Query ===================== -->

<sql:query var="filtro_stato">
  select DISTINCT s.descr
  from stato_studio s
  where s.cod=50 || s.cod=40
</sql:query>

<!--ESTRAGGO I DATI CHE MI SERVONO NELLE RIGHE DELLA TABELLA-->

<c:if test="${not empty param.studio_select && param.studio_select != '' && 
 param.studio_select=='Attivo' }">
<sql:query var="estraz_dati">
  select  DISTINCT ssc.ID_SSC, ssc.COD_STATO_STUDIO, s.descr, ssc.NOME_STUDIO, ssc.DATA_INIZIO, ssc.ID_RESP, f.IMPORTO, f.DATA_FINANZIAMENTO, f.RATA,f.METODO_PAGAMENTO
  from SSC ssc, stato_studio s, FINANZIAMENTO f, ACCOUNT a
  where ssc.COD_STATO_STUDIO=s.cod and ssc.ID_SSC=f.ID_SSC and f.ID_FARM=a.ID_ACCOUNT
  and a.USERNAME= ?
  <sql:param value="${username}"/>
  and ssc.COD_STATO_STUDIO=50
  order by f.RATA, f.DATA_FINANZIAMENTO,ssc.ID_SSC
</sql:query>
</c:if>

<c:if test="${not empty param.studio_select && param.studio_select != '' && 
 param.studio_select=='Approvato' }">
<sql:query var="estraz_dati">
  select  DISTINCT ssc.ID_SSC, ssc.COD_STATO_STUDIO, s.descr, ssc.NOME_STUDIO, ssc.DATA_INIZIO, ssc.ID_RESP, f.IMPORTO, f.DATA_FINANZIAMENTO, f.RATA, f.METODO_PAGAMENTO
  from SSC ssc, stato_studio s, FINANZIAMENTO f, ACCOUNT a
  where ssc.COD_STATO_STUDIO=s.cod and ssc.ID_SSC=f.ID_SSC and f.ID_FARM=a.ID_ACCOUNT
  and a.USERNAME= ?
  <sql:param value="${username}"/>
  and ssc.COD_STATO_STUDIO=40
  order by f.RATA, f.DATA_FINANZIAMENTO,ssc.ID_SSC
</sql:query>
</c:if>

<c:if test="${ empty param.studio_select || param.studio_select == '' }">
<sql:query var="estraz_dati">
  select  DISTINCT ssc.ID_SSC, ssc.COD_STATO_STUDIO, s.descr, ssc.NOME_STUDIO, ssc.DATA_INIZIO, ssc.ID_RESP, f.IMPORTO, f.DATA_FINANZIAMENTO, f.RATA, f.METODO_PAGAMENTO
  from SSC ssc, stato_studio s, FINANZIAMENTO f, ACCOUNT a
  where ssc.COD_STATO_STUDIO=s.cod and ssc.ID_SSC=f.ID_SSC and f.ID_FARM=a.ID_ACCOUNT
  and a.USERNAME= ?
  <sql:param value="${username}"/>
  and (ssc.COD_STATO_STUDIO=50 || ssc.COD_STATO_STUDIO=40)
  order by f.RATA, f.DATA_FINANZIAMENTO,ssc.ID_SSC
</sql:query>
</c:if>


     <!-- ==================== Corpo Centrale ===================== -->

     <!-- --------------------------- Intestazione --------------------------- -->
          <tr height="20%" width="100%"  valign="middle">
            <td align="center" bgcolor="white" colspan="7" cellpadding="10">
              <img src="capsules.png" height="150" alt="I miei studi"><br/><br/>
              <h2 style="color:#25544E">I miei studi<br/></h2>
              <p style="color:#25544E">
                <i>In questa area e' possibile visualizzare gli studi clinici finanziai e 
                   il dettaglio del finanziamento.</i>
              </p> 
            </td>
          </tr>

                        <!-- ========= primo filtro ========= -->
         <tr align="center" height="10%">
           <td align="center" width="50%" colspan="2">
             <label for="ricerca">Cerca:</label>
             <input type="text" id="ricerca"  onkeyup="cerca()" name="ricerca" 
              placeholder="Cerca per nome dello studio"><br/><br/>
            </td>
  
                       <!-- ========= secondo filtro ========= -->

           <td align="center" width="50%" colspan="2">
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
        </tr>
 

     <!-- ===================== tabella account + azioni ===================== -->
        
            
        <tr height="70%" width="100%">
          <td valign="middle" align="center" bgcolor="white" colspan="3">
                        <!-- ==== Tabella SCROLLABILE ==== -->
                <table valign="middle" align="center" border="0" width="80%" 
                    cellspacing="0" cellpadding="15" id="tabella">
                <tr bgcolor="#2a5951" style="color:white" height="60">
                    <th> Nome Studio</th>
                    <th> Stato </th>
                    <th> Importo </th>
                    <th> Data della Transazione </th>
                    <th> Numero Rate </th>
                    <th> Metodo di Pagamento </th>
                    <th> &nbsp </th>
                  </tr>

                  <c:forEach items="${estraz_dati.rows}" var="dati">
                  <tr bgcolor="f2f2f2" height="70%" align="center" valign="middle" 
                     style="color:#468c7f">
                              
                    <td><c:out value="${dati.NOME_STUDIO}"/></td>
                    <td>${dati.descr}</td>
                    <td>${dati.IMPORTO}</td>
                    <fmt:formatDate var="var_riga" value="${dati.DATA_FINANZIAMENTO}" 
                       type="date" dateStyle="medium" />
                    <td>${var_riga}</td>
                    <td>${dati.RATA}</td>
                    <td>${dati.METODO_PAGAMENTO}</td>
                    <form method="post" action="FARM_ssc.jsp">
                      <td>
                        <input type="submit" name="visualizza" value="Visualizza">
                        <input type="hidden" name="id_ssc" value="${dati.ID_SSC}">
                      </td>
                    </form>
                  </tr>
                  </c:forEach>
 
                </table>
            </td>
          </tr>

    <!-- ===================== script per la ricerca del nome ===================== -->
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
      <tr><td>&nbsp</td></tr>

   <!-- ===================== script per la ricerca della data ===================== -->
  <SCRIPT>
  function cerca_data() {
  var input, filter, table, tr, td, i, txtValue;
  input = document.getElementById("ricerca_data");
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
           <!-- ===================== Layout Finale ===================== -->
<%@ include file="LAYOUT_BOTTOM.jspf" %>