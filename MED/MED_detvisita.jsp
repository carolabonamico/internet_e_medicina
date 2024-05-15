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

<%@ include file="LAYOUT_TOP.jspf"%>
<%@ include file="LAYOUT_MENU_MED.jspf"%>

<!-- QUERY VISITA -->
<sql:query var="scheda">
SELECT P.NOME,P.COGNOME,S.NOME_STUDIO,S.ID_SSC,P.ID_PAZ,P.DATA_NASCITA, P.CODICE_FISC, P.STATO_SALUTE, E.ALTEZZA_CM,E.PESO_KG,E.COD_IDONEITA, E.COMPLICANZE,E.DATA_VISITA,E.PRESSIONE_MIN,E.PRESSIONE_MAX,E.FREQUENZA_CARDIACA,E.CERTIFICATO
FROM PAZ P, SSC S, ESITO_VISITA E,ISCRIZIONE I
WHERE E.ID_VISITA=I.ID_VISITA
AND I.ID_PAZ=P.ID_PAZ
AND I.ID_SSC=S.ID_SSC
AND E.ID_MED=?
<sql:param value="${id_user}"/>
AND I.ID_PAZ=?
<sql:param value="${param.idpaz}"/>
AND S.ID_SSC=?
<sql:param value="${param.idstudio}"/>
AND I.ID_VISITA=?
<sql:param value="${param.idvisita}"/>
</sql:query>

    <!-- ==================== Corpo Centrale ===================== -->

    <!-- --------------------- Pulsante indietro --------------------- --> 
    <tr valign="top">
      <td align="center" width="20%">
        <a href="MED_storicovisita.jsp">
          <img src="undo.png" width="40" height="40" title="Indietro">
        </a>
      </td>
      <td align="center" width="20%"> &nbsp </td>
      <td align="center" width="20%"> &nbsp </td>
    </tr>

      <tr valign="top">
        <td align="center" colspan="3">
          <img src="contract.png" height="150" alt="Visita">
        </td>
      </tr>

    <tr>
      <td colspan="3" align="center">
        <!-- -------------------- Intestazione -------------------- -->
        <h2 style="color:#25544E">Visita medica per lo studio "${param.nomestudio}"<br/></h2>
        <p style="color:#25544E">
          <i>In questa pagina e' possibile visualizzare tutti i dettagli relativi alla visita medica sostenuta per lo studio selezionato.<br/>La tabella e' di sola visualizzazione.</i>
        </p>
      </td>
    </tr>

    <tr>
      <td colspan="5" align="center">
        <p style="color:#25544E">
          <i><b>Per fare il download del certificato, premere qui:<br/><br/> <a onClick='window.open("certificato${param.idvisita}.pdf?pdf=${scheda.rows[0].CERTIFICATO}","certificato")'><img src="download.png" heigh="50" width="50"></a></b><br/><br/>
          Dal certificato si risulta:<br/></i>
        </p>
        <input type="checkbox" name="idoneita" style="color:#2a5951"
        <c:if test="${scheda.rows[0].COD_IDONEITA != 0}">checked="checked"</c:if> disabled="disabled"
        > Idoneo </checkbox></td>
      </td>
    </tr>

    <!-- Formattazione dell'output date -->
    <fmt:formatDate value="${scheda.rows[0].DATA_VISITA}" var="data"
                    type="date"
                    dateStyle="short"
    />

    <tr>
      <td colspan="5" align="center">
        <h4>La visita medica e' stata seguita dal medico ${scheda.rows[0].COGNOME} ${scheda.rows[0].NOME} in data ${data}.</h4>
      </td>
    </tr>

    <tr width="100%"> 
      <td valign="middle" bgcolor="white" align="center" colspan="5" height="100%" width="100%">

        <table cellpadding="5" border="0" width="50%">
          <h2 style="color:#25544E">Visita:<br></h2>

          <c:forEach items="${scheda.rows}" var="dati">
            <tr>
              <td width="50%" bgcolor="#2a5951" style="color:white" align="right">
                <b>Nome:</b>
              </td> 
              <td width="50%" align="left"style="color:#468c7f">
               ${dati.NOME}
              </td>
            </tr>

            <tr>
              <td width="50%" bgcolor="#2a5951" style="color:white" align="right">
                <b>Cognome:</b>
              </td> 
              <td width="50%" align="left"style="color:#468c7f">
               ${dati.COGNOME}
              </td>
            </tr>

            <tr>
              <td width="50%" bgcolor="#2a5951" style="color:white" align="right">
                <b>Altezza:</b>
              </td> 
              <td width="50%" align="left"style="color:#468c7f">
               ${dati.ALTEZZA_CM} cm
              </td>
            </tr>

            <fmt:formatDate value="${scheda.rows[0].DATA_NASCITA}" var="nascita"
                                type="date"
                                dateStyle="short"
            />

            <tr>
              <td width="50%" bgcolor="#2a5951" style="color:white" align="right">
                <b>Data nascita:</b>
              </td> 
              <td width="50%" align="left"style="color:#468c7f">
               ${nascita}
              </td>
            </tr>

            <tr>
              <td width="50%" bgcolor="#2a5951" style="color:white" align="right">
                <b>Codice fiscale:</b>
              </td> 
              <td width="50%" align="left"style="color:#468c7f">
               ${dati.CODICE_FISC}
              </td>
            </tr>

            <tr>
              <td width="50%" bgcolor="#2a5951" style="color:white" align="right">
                <b>Stato di salute:</b>
              </td> 
              <td width="50%" align="left"style="color:#468c7f">
               ${dati.STATO_SALUTE}
              </td>
            </tr>

            <tr>
              <td width="50%" bgcolor="#2a5951" style="color:white" align="right">
                <b>Nome studio:</b>
              </td> 
              <td width="50%" align="left"style="color:#468c7f">
               ${dati.NOME_STUDIO}
              </td>
            </tr>

            <tr>
              <td width="50%" bgcolor="#2a5951" style="color:white" align="right">
                <b>Altezza:</b>
              </td> 
              <td width="50%" align="left"style="color:#468c7f">
               ${dati.ALTEZZA_CM} cm
              </td>
            </tr>
    
            <tr>
              <td width="50%" bgcolor="#2a5951" style="color:white" align="right">
                <b>Peso:</b>
              </td> 
              <td width="50%" align="left"style="color:#468c7f">
               ${dati.PESO_KG} kg
              </td>
            </tr>

            <tr>
              <td width="50%" bgcolor="#2a5951" style="color:white" align="right">
                <b>Peso:</b>
              </td> 
              <td width="50%" align="left"style="color:#468c7f">
               ${dati.PESO_KG} kg
              </td>
            </tr>

            <tr>
              <td width="50%" bgcolor="#2a5951" style="color:white" align="right">
                <b>Frequenza cardiaca:</b>
              </td> 
              <td width="50%" align="left"style="color:#468c7f">
               ${dati.FREQUENZA_CARDIACA} bpm
              </td>
            </tr>

            <tr>
              <td width="50%" bgcolor="#2a5951" style="color:white" align="right">
                <b>Pressione minima:</b>
              </td> 
              <td width="50%" align="left"style="color:#468c7f">
               ${dati.PRESSIONE_MIN} mmHg
              </td>
            </tr>

            <tr>
              <td width="50%" bgcolor="#2a5951" style="color:white" align="right">
                <b>Pressione massima:</b>
              </td> 
              <td width="50%" align="left"style="color:#468c7f">
               ${dati.PRESSIONE_MAX} mmHg
              </td>
            </tr>

            <tr>
              <td width="50%" bgcolor="#2a5951" style="color:white" align="right">
                <b>Complicanze:</b>
              </td> 
              <td width="50%" align="left"style="color:#468c7f">
               ${dati.COMPLICANZE}
              </td>
            </tr>

           

          </c:forEach>
        </table>
      </td>
    </tr>

<%@ include file="LAYOUT_BOTTOM.jspf"%>
