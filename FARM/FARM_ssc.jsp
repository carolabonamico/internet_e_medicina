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

    <!-- --------------------------- Intestazione ---------------------------->
<sql:query var="scheda">
  select DISTINCT ssc.ID_SSC, 
         ssc.NOME_STUDIO, 
         ssc.DESCRIZIONE,
         ssc.AREA_TERAPEUTICA, 
         ssc.POPOLAZIONE,
         ssc.DATA_INIZIO,
         ssc.DATA_FINE,
         ((ssc.COSTO_FISSO_STRUM+ssc.COSTO_FISSO_ANALISI+ssc.TOTPAZ)*ssc.INCENTIVO) AS 
         BUDGET_COMPLESSIVO,
         ssc.COSTO_FISSO_STRUM,
         ssc.COSTO_FISSO_ANALISI,
         ssc.INCENTIVO,
         ssc.IMPORTO_RAGGIUNTO,
         ssc.TOTCONV,
         ssc.TOTPAZ,
         ssc.COD_STATO_STUDIO,
         ssc.ID_PRES,
         ssc.ID_RESP,
         ssc.ESITO,
         ssc.MOTIVAZIONE,   
         s.descr,
         resp.NOME ,
         resp.COGNOME
  
  from SSC ssc, stato_studio s, RESP resp
  where ssc.ID_SSC=?
  <sql:param value="${param.id_ssc}"/>
        and ssc.COD_STATO_STUDIO=s.cod
        and (ssc.ID_RESP=resp.ID_RESP || ssc.ID_RESP=NULL)
</sql:query>
       
<!-- --------------------------- Intestazione --------------------------- -->

<!-- ==================== Tasto Indietro ===================== -->
  <tr>
        <td align="center" width="33%">
          <a href="FARM_studiclinici.jsp">
            <img src="undo.png" width="40" height="40" title="Indietro">
          </a>
        </td>
        <td>&nbsp</td>
        <td>&nbsp</td>
</tr>
<tr height="60%" width="100%"  valign="middle">
 <td colspan="3" align="center" bgcolor="white" cellpadding="10">
    <img src="healthcare2.png" height="150" alt="I miei studi"><br/><br/>
      <h2 style="color:#25544E">Scheda studio clinico<br/></h2>
        <p style="color:#25544E">
          <i>Scrollare la tabella per visualizzare i dettagli dello studio.</i>
        </p> 
  </td>
</tr>

    <!-- --------------------------- Tabella scrollabile -------------------------->
       <tr width="100%"> 
          <td valign="middle" bgcolor="white" align="center" colspan="3" height="100%" 
           width="100%">
              <table border="0" align="center" width="80%"  cellpadding="15" 
                cellspacing="0">

              <c:if test="${scheda.rows[0].descr=='Inviato'}">

               <c:forEach items="${scheda.rows}" var="riga">

                <tr bgcolor="#2a5951" style="color:white">
                  <td align="center">
                    <h4><b>Nome Studio Clinico</b> </h4>
                  </td>
                  <td bgcolor="#f2f2f2" align="center" style="color:#468c7f"><c:out 
                   value="${riga.NOME_STUDIO}"/></td>
                </tr>

                <tr bgcolor="#2a5951" style="color:white">
                  <td align="center">
                    <h4><b>Descrizione</b> </h4>
                  </td>
                  <td bgcolor="#f2f2f2" align="center" style="color:#468c7f"><c:out 
                    value="${riga.DESCRIZIONE}"/></td>
                </tr>

                <tr bgcolor="#2a5951" style="color:white">
                  <td align="center">
                    <h4><b>Area Terapeutica</b> </h4>
                  </td>
                  <td bgcolor="#f2f2f2" align="center" style="color:#468c7f"><c:out 
                     value="${riga.AREA_TERAPEUTICA}"/></td>
                </tr>

                <tr bgcolor="#2a5951" style="color:white">
                  <td align="center">
                    <h4><b>Popolazione</b> </h4>
                  </td>
                  <td bgcolor="#f2f2f2" align="center" 
                      style="color:#468c7f">${riga.POPOLAZIONE}</td>
                </tr>

                <tr bgcolor="#2a5951" style="color:white">
                  <td align="center">
                    <h4><b>Data di Inizio</b> </h4>
                  </td>
                  <fmt:formatDate var="var_data_inizio" value="${riga.DATA_INIZIO}" 
                       type="date" dateStyle="medium" />
                  <td bgcolor="#f2f2f2" align="center" 
                      style="color:#468c7f">${var_data_inizio}</td>
                 
                </tr>

                <tr bgcolor="#2a5951" style="color:white">
                  <td align="center">
                    <h4><b>Data di Fine</b> </h4>
                  </td>
                  <fmt:formatDate var="var_data_fine" value="${riga.DATA_FINE}" 
                       type="date" dateStyle="medium" />
                  <td bgcolor="#f2f2f2" align="center" 
                      style="color:#468c7f">${var_data_fine}</td>
                </tr>

                <tr bgcolor="#2a5951" style="color:white"">
                  <td align="center">
                    <h4><b>Costo Strumentazione</b> </h4>
                  </td>
                  <td bgcolor="#f2f2f2" align="center" 
                      style="color:#468c7f">${riga.COSTO_FISSO_STRUM} Euro</td>
                </tr>

                <tr  bgcolor="#2a5951" style="color:white">
                  <td align="center">
                    <h4><b>Costo Analisi</b> </h4>
                  </td>
                  <td bgcolor="#f2f2f2" align="center" 
                      style="color:#468c7f">${riga.COSTO_FISSO_ANALISI} Euro</td>
                </tr>

                <tr  bgcolor="#2a5951" style="color:white">
                  <td align="center">
                    <h4><b>Incentivo</b> </h4>
                  </td>
                  <td bgcolor="#f2f2f2" align="center" 
                      style="color:#468c7f">${riga.INCENTIVO} Euro</td>
                </tr>


                <tr bgcolor="#2a5951" style="color:white">
                  <td align="center">
                    <h4><b>Budget Complessivo</b> </h4>
                  </td>
                  <td bgcolor="#f2f2f2" align="center" 
                      style="color:#468c7f">${riga.BUDGET_COMPLESSIVO} Euro</td>
                </tr>


                <tr bgcolor="#2a5951" style="color:white">
                  <td align="center">
                    <h4><b>Totale Pazienti</b> </h4>
                  </td>
                  <td bgcolor="#f2f2f2" align="center" 
                      style="color:#468c7f">${riga.TOTPAZ}</td>
                </tr>

                <tr bgcolor="#2a5951" style="color:white">
                  <td align="center">
                    <h4><b>Stato Studio</b> </h4>
                  </td>
                  <td bgcolor="#f2f2f2" align="center" 
                      style="color:#468c7f">${riga.descr}</td>
                </tr>

                <tr bgcolor="#2a5951" style="color:white">
                  <td  align="center">
                    <h4><b>Responsabile</b> </h4>
                  </td>
                  <td bgcolor="#f2f2f2" align="center" 
                      style="color:#468c7f">${riga.NOME} ${riga.COGNOME}</td>
                </tr>

                </c:forEach>
                </c:if>


                <c:if test="${scheda.rows[0].descr=='Approvato'}">
                <c:forEach items="${scheda.rows}" var="riga">


                <tr bgcolor="#2a5951" style="color:white">
                  <td align="center">
                    <h4><b>Nome Studio Clinico</b> </h4>
                  </td>
                  <td bgcolor="#f2f2f2" align="center" style="color:#468c7f"><c:out 
                   value="${riga.NOME_STUDIO}"/></td>
                </tr>


                <tr bgcolor="#2a5951" style="color:white">
                  <td align="center">
                    <h4><b>Descrizione</b> </h4>
                  </td>
                  <td bgcolor="#f2f2f2" align="center" style="color:#468c7f"><c:out 
                    value="${riga.DESCRIZIONE}"/></td>
                </tr>

                <tr bgcolor="#2a5951" style="color:white">
                  <td align="center">
                    <h4><b>Area Terapeutica</b> </h4>
                  </td>
                  <td bgcolor="#f2f2f2" align="center" style="color:#468c7f"><c:out 
                     value="${riga.AREA_TERAPEUTICA}"/></td>
                </tr>

                <tr bgcolor="#2a5951" style="color:white">
                  <td align="center">
                    <h4><b>Popolazione</b> </h4>
                  </td>
                  <td bgcolor="#f2f2f2" align="center" 
                      style="color:#468c7f">${riga.POPOLAZIONE}</td>
                </tr>

                <tr bgcolor="#2a5951" style="color:white">
                  <td align="center">
                    <h4><b>Data di Inizio</b> </h4>
                  </td>
                  <fmt:formatDate var="var_data_inizio" value="${riga.DATA_INIZIO}" 
                       type="date" dateStyle="medium" />
                  <td bgcolor="#f2f2f2" align="center" 
                      style="color:#468c7f">${var_data_inizio}</td>
                 
                </tr>

                <tr bgcolor="#2a5951" style="color:white">
                  <td align="center">
                    <h4><b>Data di Fine</b> </h4>
                  </td>
                  <fmt:formatDate var="var_data_fine" value="${riga.DATA_FINE}" 
                       type="date" dateStyle="medium" />
                  <td bgcolor="#f2f2f2" align="center" 
                      style="color:#468c7f">${var_data_fine}</td>
                </tr>

                <tr bgcolor="#2a5951" style="color:white"">
                  <td align="center">
                    <h4><b>Costo Strumentazione</b> </h4>
                  </td>
                  <td bgcolor="#f2f2f2" align="center" 
                      style="color:#468c7f">${riga.COSTO_FISSO_STRUM} Euro</td>
                </tr>

                <tr  bgcolor="#2a5951" style="color:white">
                  <td align="center">
                    <h4><b>Costo Analisi</b> </h4>
                  </td>
                  <td bgcolor="#f2f2f2" align="center" 
                      style="color:#468c7f">${riga.COSTO_FISSO_ANALISI} Euro</td>
                </tr>

                <tr  bgcolor="#2a5951" style="color:white">
                  <td align="center">
                    <h4><b>Incentivo</b> </h4>
                  </td>
                  <td bgcolor="#f2f2f2" align="center" 
                      style="color:#468c7f">${riga.INCENTIVO} Euro</td>
                </tr>

                
                <tr bgcolor="#2a5951" style="color:white">
                  <td align="center">
                    <h4><b>Importo Raggiunto</b> </h4>
                  </td>
                  <td bgcolor="#f2f2f2" align="center" 
                      style="color:#468c7f">${riga.IMPORTO_RAGGIUNTO} Euro</td>
                </tr>

                <tr bgcolor="#2a5951" style="color:white">
                  <td align="center">
                    <h4><b>Budget Complessivo</b> </h4>
                  </td>
                  <td bgcolor="#f2f2f2" align="center" 
                      style="color:#468c7f">${riga.BUDGET_COMPLESSIVO} Euro</td>
                </tr>


                <tr bgcolor="#2a5951" style="color:white">
                  <td align="center">
                    <h4><b>Totale Pazienti</b> </h4>
                  </td>
                  <td bgcolor="#f2f2f2" align="center" 
                      style="color:#468c7f">${riga.TOTPAZ}</td>
                </tr>

                <tr bgcolor="#2a5951" style="color:white">
                  <td align="center">
                    <h4><b>Stato Studio</b> </h4>
                  </td>
                  <td bgcolor="#f2f2f2" align="center" 
                      style="color:#468c7f">${riga.descr}</td>
                </tr>

                <tr bgcolor="#2a5951" style="color:white">
                  <td  align="center">
                    <h4><b>Responsabile</b> </h4>
                  </td>
                  <td bgcolor="#f2f2f2" align="center" 
                      style="color:#468c7f">${riga.NOME} ${riga.COGNOME}</td>
                </tr>

 
                <tr bgcolor="#2a5951" style="color:white">
                  <td align="center">
                    <h4><b>Motivazione Approvazione</b> </h4>
                  </td>
                  <td bgcolor="#f2f2f2" align="center" 
                      style="color:#468c7f"><c:out value="${riga.Motivazione}"/></td>
                </tr>

                </c:forEach>
                </c:if>



              <c:if test="${scheda.rows[0].descr=='Attivo'}">

              <c:forEach items="${scheda.rows}" var="riga">

               <tr bgcolor="#2a5951" style="color:white">
                  <td align="center">
                    <h4><b>Nome Studio Clinico</b> </h4>
                  </td>
                  <td bgcolor="#f2f2f2" align="center" style="color:#468c7f"><c:out 
                   value="${riga.NOME_STUDIO}"/></td>
                </tr>


                <tr bgcolor="#2a5951" style="color:white">
                  <td align="center">
                    <h4><b>Descrizione</b> </h4>
                  </td>
                  <td bgcolor="#f2f2f2" align="center" style="color:#468c7f"><c:out 
                    value="${riga.DESCRIZIONE}"/></td>
                </tr>

                <tr bgcolor="#2a5951" style="color:white">
                  <td align="center">
                    <h4><b>Area Terapeutica</b> </h4>
                  </td>
                  <td bgcolor="#f2f2f2" align="center" style="color:#468c7f"><c:out 
                     value="${riga.AREA_TERAPEUTICA}"/></td>
                </tr>

                <tr bgcolor="#2a5951" style="color:white">
                  <td align="center">
                    <h4><b>Popolazione</b> </h4>
                  </td>
                  <td bgcolor="#f2f2f2" align="center" 
                      style="color:#468c7f">${riga.POPOLAZIONE}</td>
                </tr>

                <tr bgcolor="#2a5951" style="color:white">
                  <td align="center">
                    <h4><b>Data di Inizio</b> </h4>
                  </td>
                  <fmt:formatDate var="var_data_inizio" value="${riga.DATA_INIZIO}" 
                       type="date" dateStyle="medium" />
                  <td bgcolor="#f2f2f2" align="center" 
                      style="color:#468c7f">${var_data_inizio}</td>
                 
                </tr>

                <tr bgcolor="#2a5951" style="color:white">
                  <td align="center">
                    <h4><b>Data di Fine</b> </h4>
                  </td>
                  <fmt:formatDate var="var_data_fine" value="${riga.DATA_FINE}" 
                       type="date" dateStyle="medium" />
                  <td bgcolor="#f2f2f2" align="center" 
                      style="color:#468c7f">${var_data_fine}</td>
                </tr>

                <tr bgcolor="#2a5951" style="color:white"">
                  <td align="center">
                    <h4><b>Costo Strumentazione</b> </h4>
                  </td>
                  <td bgcolor="#f2f2f2" align="center" 
                      style="color:#468c7f">${riga.COSTO_FISSO_STRUM} Euro</td>
                </tr>

                <tr  bgcolor="#2a5951" style="color:white">
                  <td align="center">
                    <h4><b>Costo Analisi</b> </h4>
                  </td>
                  <td bgcolor="#f2f2f2" align="center" 
                      style="color:#468c7f">${riga.COSTO_FISSO_ANALISI} Euro</td>
                </tr>

                <tr  bgcolor="#2a5951" style="color:white">
                  <td align="center">
                    <h4><b>Incentivo</b> </h4>
                  </td>
                  <td bgcolor="#f2f2f2" align="center" 
                      style="color:#468c7f">${riga.INCENTIVO} Euro</td>
                </tr>

                
                <tr bgcolor="#2a5951" style="color:white">
                  <td align="center">
                    <h4><b>Importo Raggiunto</b> </h4>
                  </td>
                  <td bgcolor="#f2f2f2" align="center" 
                      style="color:#468c7f">${riga.IMPORTO_RAGGIUNTO} Euro</td>
                </tr>

                <tr bgcolor="#2a5951" style="color:white">
                  <td align="center">
                    <h4><b>Budget Complessivo</b> </h4>
                  </td>
                  <td bgcolor="#f2f2f2" align="center" 
                      style="color:#468c7f">${riga.BUDGET_COMPLESSIVO} Euro</td>
                </tr>


                <tr bgcolor="#2a5951" style="color:white">
                  <td align="center">
                    <h4><b>Totale Pazienti</b> </h4>
                  </td>
                  <td bgcolor="#f2f2f2" align="center" 
                      style="color:#468c7f">${riga.TOTPAZ}</td>
                </tr>

                <tr bgcolor="#2a5951" style="color:white">
                  <td align="center">
                    <h4><b>Stato Studio</b> </h4>
                  </td>
                  <td bgcolor="#f2f2f2" align="center" 
                      style="color:#468c7f">${riga.descr}</td>
                </tr>

                <tr bgcolor="#2a5951" style="color:white">
                  <td  align="center">
                    <h4><b>Responsabile</b> </h4>
                  </td>
                  <td bgcolor="#f2f2f2" align="center" 
                      style="color:#468c7f">${riga.NOME} ${riga.COGNOME}</td>
                </tr>

                <tr bgcolor="#2a5951" style="color:white">
                  <td align="center">
                    <h4><b>Pazienti Convalidati</b> </h4>
                  </td>
                  <td bgcolor="#f2f2f2" align="center" 
                      style="color:#468c7f">${riga.TOTCONV}</td>
                </tr>

                <tr bgcolor="#2a5951" style="color:white">
                  <td align="center">
                    <h4><b>Esito</b> </h4>
                  </td>
                  <td bgcolor="#f2f2f2" align="center" 
                      style="color:#468c7f"><c:out value="${riga.ESITO}"/></td>
                </tr>

                </c:forEach>
               </c:if>

              </table>
          </td>
        </tr> 

<c:if test="${scheda.rows[0].COD_STATO_STUDIO=='40'}">
<tr>
             <form method="post" action="FARM_importo.jsp">
               <td align="center" colspan="3" width="100%" height="100%">
                 <input type="submit" name="finanzia" value="Finanzia">
                 <input type="hidden" name="id_ssc" value="${scheda.rows[0].ID_SSC}">
               </td>
             </form> 
           </tr>
</c:if>



<%@ include file="LAYOUT_BOTTOM.jspf" %>