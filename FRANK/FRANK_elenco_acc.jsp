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
<c:set var="ruolo_pagina" value="FRANK"/>
<%@ include file="autorizzazione.jspf" %>

<!--=================== Estrazione dati =============-->
<sql:query var="rset_elenco">
  SELECT A.ID_ACCOUNT, A.USERNAME, A.PASSWORD, R.DESCRIZIONE, 
         S.DESCR_STATO
  FROM ACCOUNT A, RUOLO R, STATO_ACCOUNT S
  WHERE R.COD_RUOLO = A.COD_RUOLO AND
        S.COD_STATO = A.STATO_ACC AND
        A.USERNAME != 'FRANK' 
  <c:if test="${not empty param.FILTRO_RUOLO && param.FILTRO_RUOLO != ''}">
  AND R.DESCRIZIONE = ?
  <sql:param value="${param.FILTRO_RUOLO}"/>
  </c:if>
  <c:if test="${not empty param.FILTRO_STATO && param.FILTRO_STATO != ''}">
  AND S.DESCR_STATO = ?
  <sql:param value="${param.FILTRO_STATO}"/>
  </c:if>
  <c:if test="${not empty param.FILTRO_USERNAME && param.FILTRO_USERNAME != ''}">
  AND UPPER(A.USERNAME) LIKE ?
  <sql:param value="${fn:toUpperCase(param.FILTRO_USERNAME)}%"/>
  </c:if>
</sql:query>

<!--=================== Estrazione ruoli =============-->
<sql:query var="rset_ruoli">
 SELECT R.DESCRIZIONE FROM RUOLO R 
 WHERE R.DESCRIZIONE != 'FRANK'
</sql:query>

<!--=================== Estrazione stati =============-->
<sql:query var="rset_stati">
 SELECT S.DESCR_STATO FROM STATO_ACCOUNT S 
</sql:query>

<%@ include file="LAYOUT_TOP.jspf" %>
<%@ include file="LAYOUT_MENU_FRANK.jspf" %>

            <!-- ==================== Corpo Centrale ===================== -->
  
       <!-- --------------------------- Intestazione --------------------------- -->
        <tr height="60%" width="100%"  valign="middle">
            <td align="center" bgcolor="white" cellpadding="10" colspan="3">
              <img src="elenco_account.png" height="150" alt="Account"><br/><br/>
              <h2 style="color:#25544E">Elenco Account<br/></h2>
              <p style="color:#25544E">
                <i>In questa pagina sono visibili gli account creati che possono essere sospesi, riabilitati o eliminati. </br>
                   Selezionando 'dettagli' e' possibile visualizzare tutte le informazioni inserite al momento della creazione del profilo.</i>
              </p> 
            </td>
        </tr> 


     <tr align="center">
        
            <!-- ========= primo filtro ========= -->
            <td align="right" width="33%">
                <FORM ACTION="#" METHOD="POST">
                    <SELECT NAME="FILTRO_RUOLO" onChange="this.form.submit();">
                        <OPTION VALUE="" checked> -- Filtro Ruolo -- </OPTION>
                        <c:forEach items="${rset_ruoli.rows}" var="myvar">
                         <OPTION VALUE="${myvar.DESCRIZIONE}" 
                           <c:if test="${param.FILTRO_RUOLO == myvar.DESCRIZIONE}">
                              selected="selected"
                            </c:if>
                         > ${myvar.DESCRIZIONE} </OPTION>
                        </c:forEach>
                    </SELECT>
            </td>
  
            <!-- ========= secondo filtro ========= -->
            <td align="center" width="33%">
                    <SELECT NAME="FILTRO_STATO" onChange="this.form.submit();">
                        <OPTION VALUE="" checked> -- Filtro Stato -- </OPTION>
                        <c:forEach items="${rset_stati.rows}" var="myvar">
                         <OPTION VALUE="${myvar.DESCR_STATO}"
                           <c:if test="${param.FILTRO_STATO == myvar.DESCR_STATO}">
                            selected="selected"
                           </c:if>
                         > ${myvar.DESCR_STATO} </OPTION>
                        </c:forEach>
                    </SELECT>
            </td>
                </FORM>

            <!-- ========= terzo filtro ========= -->
            <td align="left" width="33%">
               <label for="ricerca">Cerca:</label>
               <input type="text" id="ricerca"  onkeyup="cerca()" name="ricerca" 
                placeholder="Cerca per username">
            </td>  
    </tr>
         
        <!-- ===================== Messaggi di conferma ===================== -->
   <c:if test="${not empty okmsg || not empty creamsg}">
    <tr width="100%">
        <td align="center" colspan="3"> 
          <c:if test="${not empty okmsg}">        
            <b><font color="green"><br/>${okmsg}</font></b>
          </c:if>
          <c:if test="${not empty creamsg}">
            <b><font color="green"><br/>L'account e' stato creato correttamente<br/></font></b>
          </c:if>   
        </td>
    </tr>
   </c:if> 
 
      <!-- ===================== tabella account + azioni ===================== -->  
     <tr valign="middle">
       <td align="center" colspan="3">
            <table valign="middle" align="center" border="0" width="1100px" cellspacing="0" cellpadding="15" id="tabella">
                 <tr bgcolor="#2a5951" style="color:white" height="60">
                                    <th> Username </th>
                                    <th> ID_account </th>
                                    <th> Password </th>
                                    <th title="ruolo dell'account"> Ruolo </th>
                                    <th title="stato dell'account"> Stato </th>
                                    <th> &nbsp </th>
                                    <th> &nbsp </th>
                                    <th> &nbsp </th>
                                    <th> &nbsp </th>
                  </tr>
                  <c:forEach items="${rset_elenco.rows}" var="myvar">
                  <tr bgcolor="f2f2f2" height="60" align="center" valign="middle" 
                    style="color:#468c7f">
                                    <td>${myvar.USERNAME}</td>
                                    <td>${myvar.ID_ACCOUNT}</td>
                                    <td>${myvar.PASSWORD}</td>
                                    <td>${myvar.DESCRIZIONE}</td>
                                    <td>${myvar.DESCR_STATO}</td>
                                    <!-- tasti azioni-->
                                    <td>
                                     <form method="post" action="FRANK_info.jsp">
                                       <input type="submit" name="Dettagli" 
                                        value="Dettagli" style="color:#468c7f"/>
                                       <input type="hidden" name="id_acc" 
                                        value="${myvar.ID_ACCOUNT}"/>
                                       <input type="hidden" name="ruolo" 
                                        value="${myvar.DESCRIZIONE}"/>
                                      </form>
                                    </td>
                                    <td>
                                      <form method="post" action="FRANK_act_sospendi.jsp">
                                        <input type="submit" name="Sospendi" 
                                           value="Sospendi" style="color:#468c7f"
                                         <c:if test="${myvar.DESCR_STATO == 'ATTESA' || 
                                            myvar.DESCR_STATO == 'SOSPESO'}">
                                                  disabled="disabled"
                                         </c:if>
                                        />
                                        <input type="hidden" name="id_acc" 
                                          value="${myvar.ID_ACCOUNT}"/>
                                      </form>
                                    </td>
                                    <td>
                                     <form method="post" action="FRANK_act_riabilita.jsp">
                                        <input type="submit" name="Riabilita" 
                                          value="Riabilita" style="color:#468c7f"
                                           <c:if test="${myvar.DESCR_STATO != 'SOSPESO'}">
                                                  disabled="disabled"
                                            </c:if>
                                         />
                                         <input type="hidden" name="id_acc" 
                                          value="${myvar.ID_ACCOUNT}"/>
                                     </form>
                                    </td>
                                    <td>
                                      <form method="post" action="FRANK_conf_elimina.jsp">
                                        <input type="submit" name="Elimina" 
                                           value="Elimina" style="color:#468c7f"/>
                                         <input type="hidden" name="id_acc" 
                                            value="${myvar.ID_ACCOUNT}"/>
                                         <input type="hidden" name="ruolo" 
                                             value="${myvar.DESCRIZIONE}"/>
                                      </form>
                                    </td>
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
            
<!-- frammento layout bottom generale -->
<%@ include file="LAYOUT_BOTTOM.jspf" %>