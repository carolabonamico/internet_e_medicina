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

<!-------------------------query-------------------------->
<sql:query var="anagrafica">
select ID_PAZ,NOME, COGNOME, CODICE_FISC, DATA_NASCITA, SESSO, EMAIL, TELEFONO, INDIRIZZO, PROFESSIONE, STATO_SALUTE FROM PAZ 
where ID_PAZ=?
<sql:param value="${param.idpaz}"/>
</sql:query>


  <tr valign="top">
        <td align="center" width="33%">

          <a href="MED_pazienti.jsp">
            <img src="undo.png" width="40" height="40" title="Indietro">
          </a>
        </td>
<td align="left" ></td>
<td align="left" ></td>
      </tr>


<tr colspan="3">
      <td align="center" colspan="3">
         <table valign="middle" align="center" border="0" width="50%" cellspacing="0" cellpadding="10" style="color:#468c7f" >
            <tr>
               <img src="personal.png" height="150" alt="Informazioni Paziente"/><br/>
               <h2 style="color:#25544E">Dati anagrafici e contatti<br/></h2>
            </tr>

            <tr bgcolor="#f2f2f2" height="60" width="15%">
               <td>Nome</td>
               <c:forEach items="${anagrafica.rows}" var="myanag">
                  <td align="center">${myanag.NOME}</td>
               </c:forEach>
            </tr>

            <tr height="60" width="15%">
               <td>Cognome</td>
               <c:forEach items="${anagrafica.rows}" var="myanag">
                  <td align="center">${myanag.COGNOME}</td>
               </c:forEach>
            </tr>

            <tr bgcolor="#f2f2f2" height="60" width="15%">
               <td>Sesso</td>
               <c:forEach items="${anagrafica.rows}" var="myanag">
                  <td align="center">${myanag.SESSO}</td>
               </c:forEach>
            </tr>

              <tr height="60" width="15%">
               <td>Codice Fiscale</td>
               <c:forEach items="${anagrafica.rows}" var="myanag">
                  <td align="center">${myanag.CODICE_FISC}</td>
               </c:forEach>
            </tr>

           <tr bgcolor="#f2f2f2" height="60" width="15%">
               <td>Data di Nascita</td>
               <c:forEach items="${anagrafica.rows}" var="myanag">
               <!-- Formattazione dell'output date -->
                <fmt:formatDate value="${myanag.DATA_NASCITA}" var="nascita"
                                type="date"
                                dateStyle="short"
                />
                  <td align="center">${nascita}</td>
               </c:forEach>
            </tr>

        <tr height="60" width="15%">
               <td>Cellulare</td>
               <c:forEach items="${anagrafica.rows}" var="myanag">
                  <td align="center">${myanag.TELEFONO}</td>
               </c:forEach>
            </tr>

            <tr bgcolor="#f2f2f2" height="60" width="15%">
               <td>E-mail</td>
               <c:forEach items="${anagrafica.rows}" var="myanag">
                  <td align="center">${myanag.EMAIL}</td>
               </c:forEach>
            </tr>

              <tr height="60" width="15%">
               <td>Domicilio</td>
               <c:forEach items="${anagrafica.rows}" var="myanag">
                  <td align="center">${myanag.INDIRIZZO}</td>
               </c:forEach>
            </tr>
            <tr height="60" width="15%" bgcolor="#f2f2f2" >
               <td>Professione</td>
               <c:forEach items="${anagrafica.rows}" var="myanag">
                  <td align="center">${myanag.PROFESSIONE}</td>
               </c:forEach>
            </tr>
<tr height="60" width="15%">
               <td>Stato Salute</td>
               <c:forEach items="${anagrafica.rows}" var="myanag">
                  <td align="center">${myanag.STATO_SALUTE}</td>
               </c:forEach>
            </tr>
<tr><td>&nbsp</td></tr>

<tr height="80" width="30%" >
               <td colspan="2" align="center"><form method="post" action="MED_visita.jsp"><input type="submit" value="Effettua visita" name="visita">
<input type="hidden" value="${anagrafica.rows[0].ID_PAZ}" name="paz">
<input type="hidden" value="${param.idstudio}" name="idstudio">
<input type="hidden" name="studio" value="${param.nomestudio}">
<input type="hidden" name="idvisita" value="${param.idvisita}">
</form> </td>
               
            </tr>

         </table>
      </td>
   </tr>
<table>

<tr><td>&nbsp</td></tr>
<tr><td>&nbsp</td></tr>
            
      
            </table>
<!-- =================================== TOP FINALE ================================== --> 
 
<%@ include file="LAYOUT_BOTTOM.jspf" %>ad" %>