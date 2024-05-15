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

<!-------------------------------query------------------------>
<sql:query var="paziente">
select P.ID_PAZ,P.NOME, P.COGNOME,P.DATA_NASCITA, P.CODICE_FISC,P.STATO_SALUTE,I.ID_VISITA,
I.ID_SSC FROM PAZ P, ISCRIZIONE I
WHERE P.ID_PAZ=?
AND I.ID_SSC=?
AND
I.ID_VISITA=?
<sql:param value="${param.paz}"/>
<sql:param value="${param.idstudio}"/>
<sql:param value="${param.idvisita}"/>
</sql:query>

              <!-- --------------------- Intestazione + messaggio errore --------------------- -->  
  
   
              <tr>
                <td align="center" colspan="2">
                  <c:if test="${not empty msg}">
                    <img src="error.png" height="100" alt="Errore"/>
                  </c:if>
                  <c:if test="${empty msg}">
                    <img src="visita.jpg" height="150" alt="Visita medica"/>
                  </c:if>
                  <h2 style="color:#25544E"><br/>Visita medica<br/></h2>
                  <p align="center" style="color:#468c7f"><i>* I campi contrassegnati sono obbligatori.<br/></i></p> 
                  <c:if test="${not empty msg}">
                    <b><font color="#CC0000"><br/>${msg}</font></b>
                  </c:if>
                </td>
              </tr>
             
<tr>
  <td align="center" colspan="2">
    <table valign="middle" align="center" border="0" width="65%" cellspacing="0" cellpadding="15" style="color:#468c7f">
    <tr width="100%"/>
    <tr width="100%">
    <td align="center" width="50%"> Nome: </td>
    <td  align="center" width="50%"> ${paziente.rows[0].NOME} </td>
    </tr>
    <tr width="100%">
    <td align="center" width="50%"> Cognome: </td>
    <td   align="center" width="50%"> ${paziente.rows[0].COGNOME}  </td>
    </tr>
    <tr width="100%">
    <td align="center" width="50%"> Codice Fiscale: </td>
    <td  align="center" width="50%"> ${paziente.rows[0].CODICE_FISC}  </td>
    </tr>
    <tr width="100%">
    <td align="center" width="50%"> Stato Salute: </td>
    <td  align="center" width="50%"> ${paziente.rows[0].STATO_SALUTE} </td>
    </tr>
    <tr width="100%">
    <td align="center" width="50%"> Nome Studio: </td>
    <td   align="center" width="50%"> ${param.studio}  </td>
    </tr>
 <!-- Formattazione dell'output date -->
                <fmt:formatDate value="${paziente.rows[0].DATA_NASCITA}" var="nascita"
                                type="date"
                                dateStyle="short"
                />
    <tr width="100%">
    <td align="center" width="50%"> Data di Nascita: </td>
    <td  align="center" width="50%"> ${nascita} </td>
    </tr>

    <form action="MED_salvavisita.jsp" method="post" enctype="multipart/form-data">
    <tr height="60">
      <td align="center" width="50%">
        <c:if test="${not empty erralt}"><b><font color="#CC0000">Altezza (cm) *: </font></b></c:if>
        <c:if test="${empty erralt}"><font color="#468c7f">Altezza (cm) *: </font></c:if>
      </td>
      <td  align="center"><input type="number" min="0" name="altezza" value="${param.altezza}"></td>
    </tr>

    <tr height="60">
      <td align="center" width="50%">
        <c:if test="${not empty errpeso}"><b><font color="#CC0000">Peso (Kg) *: </font></b></c:if>
        <c:if test="${empty errpeso}"><font color="#468c7f">Peso (Kg) *: </font></c:if>
      </td>
      <td  align="center"><input type="number" min="0" name="peso" value="${param.peso}"></td>
    </tr>

    <tr height="60">
        <td align="center" width="50%">
          <c:if test="${not empty errpres}"><b><font color="#CC0000">Pressione Minima (mmHg) *: </font></b></c:if>
          <c:if test="${empty errpres}"><font color="#468c7f">Pressione Minima (mmHg) *: </font></c:if>
        </td>
        <td  align="center"><input type="number" min="0" name="pressionemin" value="${param.pressionemin}"></td>
      </tr>
  
      <tr height="60">
        <td align="center" width="50%">
          <c:if test="${not empty errpres1}"><b><font color="#CC0000">Pressione Massima (mmHg) *: </font></b></c:if>
          <c:if test="${empty errpres1}"><font color="#468c7f">Pressione Massima (mmHg) *: </font></c:if>
        </td>
        <td  align="center"><input type="number" min="0" name="pressionemax" value="${param.pressionemax}"></td>
      </tr>

      <tr height="60">
        <td align="center" width="50%">
          <c:if test="${not empty errbatt}"><b><font color="#CC0000">Frequenza Cardiaca (b/min) *: </font></b></c:if>
          <c:if test="${empty errbatt}"><font color="#468c7f">Frequenza Cardiaca (b/min) *: </font></c:if>
        </td>
        <td  align="center"><input type="number" min="0" name="battiti" value="${param.battiti}"></td>
      </tr>

      <tr height="60">
        <td align="center"  colspan="2">
          <textarea cols="60" rows="10" name="complicazioni" placeholder="Specificare eventulali patologie, intolleranze, interventi e farmaci che si stanno assumendo. Specificare 'Niente' se non ci sono complicanze.">${param.complicazioni}</textarea>
        </td>
      </tr>

      <tr><td>&nbsp</td></tr>

      <tr width="100%">
        <td align="center" colspan="2">
            <input type="checkbox" name="idoneita" value="Idoneo" 
            <c:if test="${param.idoneita=='Idoneo'}">checked="checked"</c:if>
            > Idoneo
        </td>
      </tr>

 <tr><td>&nbsp</td></tr>

<tr>
<td width="50%" align="right"> Inserire il Certificato*:(formato pdf)</td>
<td  align="left" width="50%">
       	
	<input type="file" name="form_certificato" accept=".pdf" required/>
	
</td>
</tr> <tr><td>&nbsp</td></tr>


  <tr width="100%">
    <td align="center" colspan="2">
        <input type="submit" name="salva" value="Salva visita">
    </td>
   </tr>

<input type="hidden" name="nome" value="${paziente.rows[0].NOME}">
<input type="hidden" name="idpaz" value="${paziente.rows[0].ID_PAZ}">
<input type="hidden" name="cognome" value="${paziente.rows[0].COGNOME}">
<input type="hidden" name="nascita" value="${paziente.rows[0].DATA_NASCITA}">
<input type="hidden" name="cf" value="${paziente.rows[0].CODICE_FISC}">
<input type="hidden" name="salute" value="${paziente.rows[0].STATO_SALUTE}">
<input type="hidden" name="idstudio" value="${paziente.rows[0].ID_SSC}">
<input type="hidden" name="idvisita" value="${paziente.rows[0].ID_VISITA}">
<input type="hidden" name="studio" value="${param.studio}">
    </form>

    </table>
  </td>
</tr>

<%@ include file="LAYOUT_BOTTOM.jspf" %>  