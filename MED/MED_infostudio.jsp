<%@ page session="true" 
language="java" 
contentType="text/html; charset=UTF-8" 
import="java.sql.*" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://it.unipv.bmilab.uploadtags"      prefix="upload" %>
<%@ page autoFlush="true" buffer="1094kb"%>

<!-- ==================================== Tagliola =================================== --> 
<c:set var="ruolo_pagina" value="MED"/>
<%@ include file="autorizzazione.jspf" %>

<!-- ==================================== TOP =================================== --> 

<%@ include file="LAYOUT_TOP.jspf" %>
<%@ include file="LAYOUT_MENU_MED.jspf" %>  

  <!-- ==================== Corpo Centrale ===================== -->
  <tr valign="top">
        <td align="center" width="33%">

          <a href="MED_pazienti.jsp">
            <img src="undo.png" width="40" height="40" title="Indietro">
          </a>
        </td>
        <td align="center" width="33%"></td>
        <td align="center" width="33%"></td>
  </tr>



  <!-- --------------------------- Intestazione --------------------------- -->
  <tr height="50%"  valign="middle" >
    <td align="center" width="100%" bgcolor="white" colspan="3">
      <img src="healthcare2.png" height="140" alt="I miei studi"><br/><br/>
      <h2 style="color:#25544E">Scheda clinica<br/></h2>
      <p style="color:#25544E">
        <i>Scrollare la pagina per visualizzare tutti i dettagli della SSC.</i>
      </p> 
    </td>
  </tr>


 <!-- ====  Tabella Scrollabile==== -->
  <!-- query di estrazione-->

  <sql:query var="sscdati">
  select S.ID_SSC, S.NOME_STUDIO, S.TOTPAZ,S.COSTO_FISSO_STRUM, S.COSTO_FISSO_ANALISI, S.INCENTIVO, S.COD_STATO_STUDIO, S.ID_RESP, S.DATA_INIZIO, S.DATA_FINE,S.POPOLAZIONE,S.DESCRIZIONE,S.AREA_TERAPEUTICA, S.RIVISTO, R.NOME,R.COGNOME
  from SSC S , RESP R 
  where R.ID_RESP=S.ID_RESP AND
 S.ID_SSC=?
  <sql:param value="${param.idstudio}"/> 

  </sql:query>
 
    <!--form method="post" action="/intermed/development/cgimon.jsp"-->
         
    <c:set var="idstudio" value="${sscdati.rows[0].ID_SSC}" scope="session"/>
    <c:set var="rivisto" value="${sscdati.rows[0].RIVISTO}" scope="request"/>
    <c:set var="nomestudio" value="${sscdati.rows[0].NOME_STUDIO}" scope="session"/>


          <c:if test="${not empty errore}">
          <tr><td colspan="3" align="center"><font color="red"><b><h3>${errore}</h3></b> 
          </font></td></tr>
          </c:if>

    <tr>
      <td valign="middle" align="center" bgcolor="white" colspan="3">

         <table valign="middle" align="center" border="0" width="50%" cellspacing="0" cellpadding="15">
                
            
            <tr bgcolor="#2a5951" style="color:white" height="50">

              <th width="50%" align="center"><b> Nome dello Studio:</b></td>
              <c:forEach items="${sscdati.rows}" var="mydati">
                <th width="50%" bgcolor="#f2f2f2" align="center" style="color:#468c7f"> ${mydati.NOME_STUDIO}</td>
              </c:forEach>
            </tr>

                 <tr  bgcolor="#2a5951" style="color:white" height="50">
                  <td width="50%" align="center"><h4><b>Descrizione:</b> </h4></td> 
                   <c:forEach items="${sscdati.rows}" var="mydati">
                  <th width="50%" bgcolor="#f2f2f2" align="center" style="color:#468c7f"> ${mydati.DESCRIZIONE}</td></c:forEach>

           <tr bgcolor="#2a5951" style="color:white" height="50">
              <td width="50%" align="center"><b> Popolazione:</b></td>
              <c:forEach items="${sscdati.rows}" var="mydati">
                <th width="50%" bgcolor="#f2f2f2" align="center" style="color:#468c7f"> ${mydati.POPOLAZIONE}</td>
              </c:forEach>
            </tr>
                </tr>   
                 <tr  bgcolor="#2a5951" style="color:white" height="50">
                  <td width="50%" align="center"><h4><b>Area Terapeutica:</b> </h4></td> 
                   <c:forEach items="${sscdati.rows}" var="mydati">
                  <th width="50%" bgcolor="#f2f2f2" align="center" style="color:#468c7f"> ${mydati.AREA_TERAPEUTICA}</td></c:forEach>
                </tr>   


        <tr bgcolor="#2a5951" style="color:white"  height="50">
              <td width="50%" align="center"><b>Numero di pazienti:</b></td>
              <c:forEach items="${sscdati.rows}" var="mydati">
                <th width="50%"  bgcolor="#f2f2f2" align="center" style="color:#468c7f"> ${mydati.TOTPAZ}</td>
              </c:forEach>
            </tr>

            <tr  bgcolor="#2a5951" style="color:white" height="50">
              <td width="50%" align="center"><b>Costo Fisso Della Strumentazione:</b></td>
              <c:forEach items="${sscdati.rows}" var="mydati">
                <th width="50%" bgcolor="#f2f2f2" align="center" style="color:#468c7f"> ${mydati.COSTO_FISSO_STRUM}</td>
              </c:forEach>
            </tr>
            <tr  bgcolor="#2a5951" style="color:white" height="50">
              <td width="50%" align="center"><b>Costo Fisso Delle Analisi:</b></td>
              <c:forEach items="${sscdati.rows}" var="mydati">
                <th width="50%" bgcolor="#f2f2f2" align="center" style="color:#468c7f"> ${mydati.COSTO_FISSO_ANALISI}</td>
              </c:forEach>
            </tr>
            
    

                
            <tr  bgcolor="#2a5951" style="color:white" height="50">
              <td width="50%" align="center"><b>Incentivo:</b></td>
              <c:forEach items="${sscdati.rows}" var="mydati">
                <th width="50%"  bgcolor="#f2f2f2"  align="center" style="color:#468c7f"> ${mydati.INCENTIVO}</td>
              </c:forEach>
            </tr>

            <tr  bgcolor="#2a5951" style="color:white"height="50">
              <td width="50%"  align="center"><h4><b> Respondabile:</b> </h4></td>
                <c:forEach items="${sscdati.rows}" var="mydati">
                <th width="50%" bgcolor="#f2f2f2"  align="center" style="color:#468c7f"> ${mydati.NOME} ${mydati.COGNOME}</td>
              </c:forEach>
            </tr>

             
                
                
                <tr  bgcolor="#2a5951" style="color:white" height="50">
                  <td width="50%" align="center"><h4><b>Data di inizio studio:</b> </h4></td> 

 

               
                   <c:forEach items="${sscdati.rows}" var="mydati">  
  <fmt:formatDate value="${mydati.DATA_INIZIO}" var="inizio"
                                type="date"
                                dateStyle="short"
                />

                  <th width="50%" bgcolor="#f2f2f2"  align="center" style="color:#468c7f"> ${inizio}</td></c:forEach>
                </tr>

                <tr  bgcolor="#2a5951" style="color:white" height="50">
                  <td width="50%"  align="center"><h4><b>Data di fine studio:</b></h4></td> 
                   <c:forEach items="${sscdati.rows}" var="mydati">
    <fmt:formatDate value="${mydati.DATA_FINE}" var="fine"
                                type="date"
                                dateStyle="short"
                />
                  <th width="50%"  bgcolor="#f2f2f2" align="center" style="color:#468c7f"> ${fine}</td></c:forEach>
                </tr>

   
          </table>

        
      </td>
    </tr> 



<%@ include file="LAYOUT_BOTTOM.jspf" %> 