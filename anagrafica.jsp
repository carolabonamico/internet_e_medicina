<%@ page session="true" 
language="java" 
contentType="text/html; charset=UTF-8" 
import="java.sql.*" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://it.unipv.bmilab.uploadtags"      prefix="upload" %>

<!-- ================================================================================= -->
<!-- ================================== MED ========================================= -->
<!-- ================================================================================= -->

<c:if test="${ruolo_user == 'MED'}">

<%@ include file="LAYOUT_TOP.jspf" %>
<%@ include file="LAYOUT_MENU_MED.jspf" %>

<!-- ==================== Query ===================== -->
<sql:query var="anagrafica">
select NOME, COGNOME,MAIL, SESSO, CF, DOMICILIO,DATA_NASCITA,CELLULARE, N_ALBO
from MED
where ID_MED=?
<sql:param value="${id_user}"/>
</sql:query>

   <!-- ==================== Tabella ===================== -->
   <tr>
      <td align="center">
         <table valign="middle" align="center" border="0" width="65%" cellspacing="0" cellpadding="10" style="color:#468c7f">
            <tr>
               <img src="personal.png" height="150" alt="Informazioni personali"/><br/>
               <h2 style="color:#25544E">Dati anagrafici e contatti<br/></h2>
            </tr>

            <tr bgcolor="#f2f2f2" height="60" width="15%">
               <td>Nome</td>
               <c:forEach items="${anagrafica.rows}" var="myanag">
                  <td>${myanag.NOME}</td>
               </c:forEach>
            </tr>

            <tr height="60" width="15%">
               <td>Cognome</td>
               <c:forEach items="${anagrafica.rows}" var="myanag">
                  <td>${myanag.COGNOME}</td>
               </c:forEach>
            </tr>

            <tr bgcolor="#f2f2f2" height="60" width="15%">
               <td>Sesso</td>
               <c:forEach items="${anagrafica.rows}" var="myanag">
                  <td>${myanag.SESSO}</td>
               </c:forEach>
            </tr>

              <tr height="60" width="15%">
               <td>Codice Fiscale</td>
               <c:forEach items="${anagrafica.rows}" var="myanag">
                  <td>${myanag.CF}</td>
               </c:forEach>
            </tr>

           <tr bgcolor="#f2f2f2" height="60" width="15%">
               <td>Data di Nascita</td>
               <!-- Formattazione dell'output date -->
                <fmt:formatDate value="${myanag.DATA_NASCITA}" var="nascita"
                                type="date"
                                dateStyle="short"
                />
               <c:forEach items="${anagrafica.rows}" var="myanag">
                  <td>${myanag.DATA_NASCITA}</td>
               </c:forEach>
            </tr>

        <tr height="60" width="15%">
               <td>Cellulare</td>
               <c:forEach items="${anagrafica.rows}" var="myanag">
                  <td>${myanag.CELLULARE}</td>
               </c:forEach>
            </tr>

            <tr bgcolor="#f2f2f2" height="60" width="15%">
               <td>E-mail</td>
               <c:forEach items="${anagrafica.rows}" var="myanag">
                  <td>${myanag.MAIL}</td>
               </c:forEach>
            </tr>

              <tr height="60" width="15%">
               <td>Numero Albo</td>
               <c:forEach items="${anagrafica.rows}" var="myanag">
                  <td>${myanag.N_ALBO}</td>
               </c:forEach>
            </tr>
            
         </table>
      </td>
   </tr>
</c:if>

<!-- ================================================================================= -->
<!-- ================================== PAZ ========================================= -->
<!-- ================================================================================= -->
<c:if test="${ruolo_user == 'PAZ'}">

<%@ include file="LAYOUT_TOP.jspf" %>
<%@ include file="LAYOUT_MENU_PAZ.jspf" %>

<!-- QUERY PER ESTRARRE I DATI ANAGRAFICI -->
<sql:query var="rset_anagrafica">
  SELECT P.NOME, P.COGNOME, P.DATA_NASCITA, P.SESSO, P.EMAIL, 
  P.TELEFONO, P.INDIRIZZO, P.CODICE_FISC, P.PROFESSIONE, P.STATO_SALUTE,
  S.DOMANDA, P.RISPOSTA, P.ID_DOMANDA
  FROM PAZ P, SICUREZZA S
  WHERE P.ID_DOMANDA = S.COD_DOMANDA
  AND P.ID_PAZ = ?
  <sql:param value="${id_user}"/>
</sql:query>

      <!-- ==================== Corpo Centrale ===================== -->
 <!form metod="post" action="/intermed/development/cgimon.jsp">
      <tr>
        <td align="center">
          <form action="PAZ_modificainfopaz.jsp" method="post">
            <table valign="middle" align="center" border="0" width="50%" cellspacing="0" cellpadding="10" style="color:#468c7f">
              
              <c:if test="${not empty msg}">
                <tr height="60">
                  <td align="center" colspan="2">
                    <b><font color="green">${msg}<br/><br/><br/></font></b>
                  </td>
                </tr>
              </c:if>

              <tr>
                <img src="personal.png" height="200" alt="Informazioni personali"/><br/>
                <h2 style="color:#25544E">Dati anagrafici e generalita'<br/><br/><br/></h2>
              </tr> 

            <c:forEach items="${rset_anagrafica.rows}" var="anagrafica">
              <tr bgcolor="#f2f2f2" height="60">
                <td>Nome</td>
                <td>${anagrafica.NOME}</td>
              </tr>
              <tr height="60" width="15%">
                <td>Cognome</td>
                <td>${anagrafica.COGNOME}</td>
                <c:set var="cognome" scope="request"/>
              </tr>
              <tr bgcolor="#f2f2f2" height="60">
                <td>Sesso</td>
                <td>
                  <c:if test="${anagrafica.SESSO == 'M'}">
                    Maschio
                  </c:if>
                  <c:if test="${anagrafica.SESSO == 'F'}">
                    Femmina
                  </c:if>
                </td>
              </tr>
              <tr height="60" width="15%">
                <td>Codice Fiscale</td>
                <td>${anagrafica.CODICE_FISC}</td>
              </tr>
              <tr bgcolor="#f2f2f2" height="60">
                <td>Data di nascita</td>
                <!-- Formattazione dell'output date -->
                <fmt:formatDate value="${anagrafica.DATA_NASCITA}" var="nascita"
                                type="date"
                                dateStyle="short"
                />
                <td>${nascita}</td>
              </tr>
              <tr height="60" width="15%">
                <td>Cellulare</td>
                <td>${anagrafica.TELEFONO}</td>
              </tr>
              <tr bgcolor="#f2f2f2" height="60">
                <td>E-mail</td>
                <td>${anagrafica.EMAIL}</td>
              </tr>
              <tr height="60" width="15%">
                <td>Indirizzo</td>
                <td>${anagrafica.INDIRIZZO}</td>
              </tr>
              <tr bgcolor="#f2f2f2" height="60">
                <td>Professione</td>
                <td>${anagrafica.PROFESSIONE}</td>
              </tr>

              <tr height="60" width="15%">
                <td>Stato di Salute</td>
                <td>${anagrafica.STATO_SALUTE}</td>
              </tr>

              <tr bgcolor="#f2f2f2" height="60" width="15%">
                <td>Domanda di sicurezza</td>
                <td>${anagrafica.DOMANDA}</td>
              </tr>

              <tr height="60" width="15%">
                <td>Risposta di sicurezza</td>
                <td>${anagrafica.RISPOSTA}</td>
              </tr>

            </table>
        </td>
      </tr>

      <tr height="60" width="15%">
        <td align="center">
          <input type="submit" name="Modifica_anagrafica" value="Modifica" style="color:#468c7f"/>
          
          <input type="hidden" name="nome" value="${anagrafica.NOME}"/>
          <input type="hidden" name="cognome" value="${anagrafica.COGNOME}"/>
          <input type="hidden" name="sesso" value="${anagrafica.SESSO}"/>
          <input type="hidden" name="cod_fiscale" value="${anagrafica.CODICE_FISC}"/>
          <input type="hidden" name="data_nascita" value="${anagrafica.DATA_NASCITA}"/>
          <input type="hidden" name="telefono" value="${anagrafica.TELEFONO}"/>
          <input type="hidden" name="email" value="${anagrafica.EMAIL}"/>
          <input type="hidden" name="indirizzo" value="${anagrafica.INDIRIZZO}"/>
          <input type="hidden" name="professione" value="${anagrafica.PROFESSIONE}"/>
          <input type="hidden" name="stato_salute" value="${anagrafica.STATO_SALUTE}"/>
          <input type="hidden" name="cod_domanda" value="${anagrafica.ID_DOMANDA}"/>
          <input type="hidden" name="risposta" value="${anagrafica.RISPOSTA}"/>
          </form>
            </c:forEach>
        </td>
      </tr>
</c:if>

<!-- ================================================================================= -->
<!-- ================================== FARM ========================================= -->
<!-- ================================================================================= -->

<c:if test="${ruolo_user == 'FARM'}">
<!-- ================================== Query ======================================== -->

<sql:query var="areariservata">
  select f.NOME_DITTA, f.TELEFONO, f.TITOLARE_DITTA, f.ID_RESP, f.INDIRIZZO_SEDE, f.EMAIL, 
         f.BUDGET_DISPONIBILE
  from FARM f, ACCOUNT a
  where a.ID_ACCOUNT=f.ID_FARM 
        and a.USERNAME= ?
  <sql:param value="${username}"/>
</sql:query>

<!-- ===================================== TOP ======================================= -->

<%@ include file="LAYOUT_TOP.jspf"%>
<%@ include file="LAYOUT_MENU_FARM.jspf"%>    

<!-- ============================== Corpo Centrale =================================== -->
 <tr>
   <td align="center">
     <form action="#">
       <table valign="middle" align="center" border="0" width="65%" cellspacing="0" 
        cellpadding="10" style="color:#468c7f">
        
         <tr>
           <img src="vitamin.png" height="150" alt="Informazioni della ditta"/><br/><br/>
           <h2 style="color:#25544E">I miei dati<br/><br/></h2>
         </tr> 
         
<!-- ===================================== TABELLA =================================== -->
         
         <c:forEach items="${areariservata.rows}" var="riga">
         <tr height="60" width="15%">
            <td><b>Societa' Farmaceutica</b></td>
            <td><c:out value="${riga.NOME_DITTA}"/></td>
         </tr>

         <tr bgcolor="#f2f2f2" height="60" width="15%">
            <td><b>Indirizzo Sede Centrale</b></td>
            <td><c:out value="${riga.INDIRIZZO_SEDE}"/></td>
         </tr>

         <tr height="60" width="15%">
            <td><b>Telefono</b></td>
            <td>+39 ${riga.TELEFONO}</td>
         </tr>

         <tr bgcolor="#f2f2f2" height="60" width="15%">
            <td><b>titolare della Ditta</b></td>
            <td>${riga.TITOLARE_DITTA}</td>
         </tr>

         <tr height="60" width="15%">
            <td><b>E-mail</b></td>
            <td><c:out value="${riga.EMAIL}"/></td>
         </tr>
          
         <tr bgcolor="#f2f2f2" height="60" width="15%">
            <td><b> Responsabile di riferimento</b></td>
            <td>${riga.ID_RESP}</td>
         </tr>
         
         <tr height="60" width="15%">
            <td><b>BUDGET DISPONIBILE</b></td>
            <td>${riga.BUDGET_DISPONIBILE} Euro</td>
         </tr>
        </c:forEach>
       </table>
     </form>
   </td>
 </tr>
</c:if>

<!-- ================================================================================= -->
<!-- ================================== PRES ========================================= -->
<!-- ================================================================================= -->

<c:if test="${ruolo_user == 'PRES'}">

<!-- ==================================== TOP =================================== -->

<%@ include file="LAYOUT_TOP.jspf" %>
<%@ include file="LAYOUT_MENU_PRES.jspf" %>   

<!-- ==================== Query ===================== -->
<sql:query var="anagrafica">
select NOME, COGNOME,MAIL, SESSO, CF, DOMICILIO,DATA_NASCITA,CELLULARE, N_ALBO
from PRES
where ID_PRES=?
<sql:param value="${id_user}"/>
</sql:query>

   <!-- ==================== Tabella ===================== -->
   <tr>
      <td align="center">
         <table valign="middle" align="center" border="0" width="65%" cellspacing="0" cellpadding="10" style="color:#468c7f">
            <tr>
               <img src="personal.png" height="150" alt="Informazioni personali"/><br/>
               <h2 style="color:#25544E">Dati anagrafici e contatti<br/></h2>
            </tr>

            <tr bgcolor="#f2f2f2" height="60" width="15%">
               <td>Nome</td>
               <c:forEach items="${anagrafica.rows}" var="myanag">
                  <td>${myanag.NOME}</td>
               </c:forEach>
            </tr>

            <tr height="60" width="15%">
               <td>Cognome</td>
               <c:forEach items="${anagrafica.rows}" var="myanag">
                  <td>${myanag.COGNOME}</td>
               </c:forEach>
            </tr>

            <tr bgcolor="#f2f2f2" height="60" width="15%">
               <td>Sesso</td>
               <c:forEach items="${anagrafica.rows}" var="myanag">
                  <td>${myanag.SESSO}</td>
               </c:forEach>
            </tr>

              <tr height="60" width="15%">
               <td>Codice Fiscale</td>
               <c:forEach items="${anagrafica.rows}" var="myanag">
                  <td>${myanag.CF}</td>
               </c:forEach>
            </tr>

           <tr bgcolor="#f2f2f2" height="60" width="15%">
               <td>Data di Nascita</td>
               <!-- Formattazione dell'output date -->
                <fmt:formatDate value="${myanag.DATA_NASCITA}" var="nascita"
                                type="date"
                                dateStyle="short"
                />
               <c:forEach items="${anagrafica.rows}" var="myanag">
                  <td>${myanag.DATA_NASCITA}</td>
               </c:forEach>
            </tr>

        <tr height="60" width="15%">
               <td>Cellulare</td>
               <c:forEach items="${anagrafica.rows}" var="myanag">
                  <td>${myanag.CELLULARE}</td>
               </c:forEach>
            </tr>

            <tr bgcolor="#f2f2f2" height="60" width="15%">
               <td>E-mail</td>
               <c:forEach items="${anagrafica.rows}" var="myanag">
                  <td>${myanag.MAIL}</td>
               </c:forEach>
            </tr>

              <tr height="60" width="15%">
               <td>Numero Albo</td>
               <c:forEach items="${anagrafica.rows}" var="myanag">
                  <td>${myanag.N_ALBO}</td>
               </c:forEach>
            </tr>
            
         </table>
      </td>
   </tr>
</c:if>
<!-- ================================================================================= -->
<!-- ================================== RESP ========================================= -->
<!-- ================================================================================= -->
<c:if test="${ruolo_user == 'RESP'}">

<sql:query var="resp">
  SELECT NOME, COGNOME, SESSO, CF, DOMICILIO, DATA_NASCITA, MAIL, CELLULARE, N_ALBO
  FROM RESP
  WHERE ID_RESP = ?
  <sql:param value="${id_user}"/>
</sql:query>

<%@ include file="LAYOUT_TOP.jspf"%>
<%@ include file="LAYOUT_MENU_RESP.jspf"%>

  <!-- ==================== Corpo Centrale ===================== -->

  <form method="post" action="RESP_home.jsp">
    <tr>
      <td align="center">
          <table valign="middle" align="center" border="0" width="65%" cellspacing="0" cellpadding="10" style="color:#468c7f">

            <tr>
              <img src="identity_card.png" height="150" alt="Informazioni responsabile"/><br/><br/>
              <h2 style="color:#25544E">Generalita' e contatti<br/><br/></h2>
            </tr>

            <tr bgcolor="#f2f2f2" height="60" width="15%">
              <td><b>Nome</b></td>
              <td>${resp.rows[0].NOME}</td>
            </tr>
            <tr height="60" width="15%">
              <td><b>Cognome</b></td>
              <td>${resp.rows[0].COGNOME}</td>
            </tr>
            <tr bgcolor="#f2f2f2" height="60" width="15%">
              <td><b>Sesso</b></td>
              <td>${resp.rows[0].SESSO}</td>
            </tr>
            <tr height="60" width="15%">
              <td><b>Codice Fiscale</b></td>
              <td>${resp.rows[0].CF}</td>
            </tr>
            <tr bgcolor="#f2f2f2" height="60" width="15%">
              <td><b>Data di nascita</b></td>
              <fmt:formatDate var="DATA_NASCITA"
                         value="${resp.rows[0].DATA_NASCITA}"
                         type="both"
                         dateStyle="medium"
                         timeStyle="medium"/>
              <td>${DATA_NASCITA}</td>
            </tr>
            <tr height="60" width="15%">
              <td><b>Numero Albo di ricerca</b></td>
              <td>${resp.rows[0].N_ALBO}</td>
            </tr>
            <tr bgcolor="#f2f2f2" height="60" width="15%">
              <td><b>Cellulare</b></td>
              <td>${resp.rows[0].CELLULARE}</td>
            </tr>
            <tr height="60" width="15%">
              <td><b>E-mail</b></td>
              <td>${resp.rows[0].MAIL}</td>
            </tr>

          </table>
      </td>
    </tr>

    <tr height="60" width="15%">
      <td align="center" colspan="2">
        <input type="submit" name="Indietro" value="Indietro" style="color:#468c7f"/>
      </td>
    </tr>
  </form>
</c:if>

<c:if test="${empty ruolo_user}">
  <c:set var="errmsg" scope="request">Si e' effettuato l'accesso ad una pagina riservata. Ritentare l'accesso!</c:set>
  <jsp:forward page="HOME_areariservata.jsp"/>
</c:if>
      
<%@ include file="LAYOUT_BOTTOM.jspf" %>