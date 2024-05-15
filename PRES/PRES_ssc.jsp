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
 
<c:set var="ruolo_pagina" value="PRES"/>
<%@ include file="autorizzazione.jspf" %>

<!-- ==================================== TOP =================================== --> 

<%@ include file="LAYOUT_TOP.jspf" %>
<%@ include file="LAYOUT_MENU_PRES.jspf" %>  

  <!-- ==================== Corpo Centrale ===================== -->

<!-- --------------------- Pulsante indietro --------------------- --> 
<c:choose><c:when test="${empty param.visualizza2}"> 
     <tr valign="top">
        <td align="center" width="33%">

          <a href="PRES_studiclinici.jsp">
            <img src="undo.png" width="40" height="40" title="Indietro">
          </a>
        </td>
 <td align="center" width="33%"></td>
 <td align="center" width="33%"></td>
      </tr>
</c:when><c:otherwise>
       <tr valign="top">
        <td align="center" width="33%">

          <a href="PRES_imieistudi.jsp">
            <img src="undo.png" width="40" height="40" title="Indietro">
          </a>
        </td>
 <td align="center" width="33%"></td>
 <td align="center" width="33%"></td>
      </tr>
</c:otherwise></c:choose>

  <!-- --------------------------- Intestazione --------------------------- -->
  <tr height="50%"  valign="middle">
    <td align="center" width="100%" bgcolor="white" colspan="3">
      <img src="healthcare2.png" height="150" alt="I miei studi"><br/><br/>
      <h2 style="color:#25544E">Scheda clinica<br/></h2>
      <p style="color:#25544E">
        <i>Scrollare la pagina per visualizzare tutti i dettagli della SSC.</i>
      </p> 
    </td>
  </tr>

  <!-- ====  Tabella Scrollabile==== -->
  <!-- query di estrazione-->

  <sql:query var="sscdati">
  select S.ID_SSC, S.NOME_STUDIO, S.TOTPAZ,S.COSTO_FISSO_STRUM, S.COSTO_FISSO_ANALISI, S.INCENTIVO, S.COD_STATO_STUDIO, S.ID_RESP, S.DATA_INIZIO, S.DATA_FINE,S.POPOLAZIONE,S.RISPOSTA, S.DESCRIZIONE,S.AREA_TERAPEUTICA, S.RIVISTO, R.NOME,R.COGNOME
  from SSC S , RESP R 
  where R.ID_RESP=S.ID_RESP AND
 S.ID_SSC=?
  <sql:param value="${param.form_idssc}"/> 

  </sql:query>
 
    <!--form metod="post" action="/intermed/development/cgimon.jsp"-->
         
    <c:set var="idstudio" value="${sscdati.rows[0].ID_SSC}" scope="session"/>
    <c:set var="rivisto" value="${sscdati.rows[0].RIVISTO}" scope="request"/>
   <c:set var="nomestudio" value="${sscdati.rows[0].NOME_STUDIO}" scope="session"/>


          <c:if test="${not empty errore}">
          <tr><td colspan="3" align="center"><font color="red"><b><h3>${errore}</h3></b> 
          </font></td></tr>
          </c:if>

    <tr>
      <td valign="middle" align="center" bgcolor="white" colspan="3">

         <table valign="middle" align="center" border="0" width="60%" cellspacing="0" cellpadding="10">
                
            
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
              <td width="50%"  align="center"><h4><b> Responsabile:</b> </h4></td>
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
<c:if test="${not empty sscdati.rows[0].RISPOSTA}">
        <tr  bgcolor="#2a5951" style="color:white"height="50">
              <td width="50%"  align="center"><h4><b> Risposta del responsabile:</b> </h4></td>
                <c:forEach items="${sscdati.rows}" var="mydati">
                <th width="50%" bgcolor="#f2f2f2"  align="center" style="color:#468c7f"> ${mydati.RISPOSTA}</td>
              </c:forEach>
            </tr>
</c:if > 
          </table>

        
      </td>
    </tr> 



      <!--tabella per tasti-->    

        <c:choose>
          <c:when test="${empty param.visualizza2}">
         <c:choose>
          <c:when test="${rivisto == 1}" >
<tr style="color:#2a5951">
              <form metod="post" action="PRES_modificastato.jsp">
              <th colspan="3" align="center" style="color:#2a5951"><input type="checkbox" name="visita" value="Visita" style="color:#2a5951"<c:if test="${param.visita=='Visita'}"> checked="checked"</c:if>> Richiesta Visita Medica </checkbox></td>
          
           <tr style="color:#2a5951"> <td align="center" colspan="3"> <b>MOTIVAZIONE:*</b><br/><br/>Specificare la scelta effettuata!</td></tr>

          
            
            
                <tr style="color:#468c7f"> <th align="center" colspan="3">
<textarea cols="70"style="color:#2a5951" rows="10" name="motivazione" placeholder="Inserire qui i motivi della scelta effettuata"></textarea></td></tr>
<tr><td>&nbsp</td></tr>
                <tr>
                <td align="center" width="50%">
                  <input type="submit"  name="approva" value="Approvare">
                  <input type="hidden" value="${param.form_idssc}"/>
                </td>                   
                <td align="center" width="50%">
                  <input type="submit" name="non_approvare" value="Non Approvare"> 
                  <input type="hidden" value="${param.form_idssc}"/>
                </td>  
            </tr>

           </form> 
         </c:when>
        <c:when test="${rivisto == 0}">
           <tr>
                        <form metod="post" action="PRES_modificastato.jsp">
              <td colspan="3" align="center" style="color:#2a5951"><input type="checkbox" style="color:#2a5951" name="visita"> Richiesta Visita Medica </checkbox></td>
          
           <tr style="color:#2a5951"> <td align="center" colspan="3"> <b>MOTIVAZIONE:*</b><br/><br/>Specificare la scelta effettuata!</td></tr>
          
           
            
                <tr> 
                  <td align="center" colspan="3" style="color:#2a5951"> 
                    <textarea cols="70" rows="10" name="motivazione" style="color:#2a5951" placeholder="Inserire qui i motivi della scelta effettuata"></textarea>

                   </td>
                 </tr>

              <tr>
            
                <td align="right" width="33%">
                  <input type="submit"  name="approva" value="Approvare">
                  <input type="hidden" value="${param.form_idssc}"/>
                </td>    
                 <td align="center" width="33%">
                  <input type="submit"  name="rivisto" value="Da Rivedere">
                  <input type="hidden" value="${param.form_idssc}"/>
                </td>                   
                <td align="left" width="33%">
                  <input type="submit"  name="non_approvare" value="Non Approvare"> 
                  <input type="hidden" value="${param.form_idssc}"/>
                </td> 

            </tr>
            

          
         </c:when>
         </c:choose>
         </form> 
          </c:when>

          
          <c:otherwise>
              <tr height="60">
                <td height="100%" align="center" colspan="3" style="color:#25544E"><i><h3>${param.messaggio}</h3></i></td>
              </tr>
          </c:otherwise>
        </c:choose>

<%@ include file="LAYOUT_BOTTOM.jspf" %>