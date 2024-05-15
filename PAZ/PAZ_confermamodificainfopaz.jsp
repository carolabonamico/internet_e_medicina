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
<c:set var="ruolo_pagina" value="PAZ"/>
<%@ include file="autorizzazione.jspf" %>

<!-- ==================================== TOP =================================== --> 

<%@ include file="LAYOUT_TOP.jspf" %>
<%@ include file="LAYOUT_MENU_PAZ.jspf" %>  

      <!-- ==================== Corpo Centrale ===================== -->
            <tr valign="middle">
              <td colspan="2" align="center"><img src="confirmation.png" height="200" alt="Conferma"></td>
            </tr>
            <tr>
              <td colspan="2" align="center">
                <h2 style="color:#25544E">Si desidera applicare le modifiche effettuate?</h2>
              </td>
            </tr>

            <!-- --------------------- Pulsanti di modifica/annulla --------------------- --> 
            <tr valign="middle">
              <td align="right" width="50%">
                <form method="post" action="PAZ_updateinfopaz.jsp">
                  <input type="submit" name="modifica_info" value="Conferma" style="color:#2A5951">

                  <input type="hidden" name="nome" value="${param.nome}"/>
                  <input type="hidden" name="cognome" value="${param.cognome}"/>
                  <input type="hidden" name="sesso" value="${param.sesso}"/>
                  <input type="hidden" name="cod_fiscale" value="${param.cod_fiscale}"/>
                  <input type="hidden" name="data_nascita" value="${param.data_nascita}"/>
                  <input type="hidden" name="telefono" value="${param.telefono}"/>
                  <input type="hidden" name="email" value="${param.email}"/>
                  <input type="hidden" name="indirizzo" value="${param.indirizzo}"/>
                  <input type="hidden" name="professione" value="${param.professione}"/>
                  <input type="hidden" name="stato_salute" value="${param.stato_salute}"/>
                  <input type="hidden" name="cod_domanda" value="${param.cod_domanda}"/>
                  <input type="hidden" name="risposta" value="${param.risposta}"/>
                  <c:set var="okmsg" scope="session">Le modifiche sono state apportate correttamente!</c:set>
                  
                </form>
              </td>
              <td align="left" width="50%">
                <form method="post" action="PAZ_modificainfopaz.jsp">
                  <input type="submit" name="annulla_modifica_info" value="Annulla" style="color:#2A5951"/>
                  
                  <input type="hidden" name="nome" value="${param.nome}"/>
                  <input type="hidden" name="cognome" value="${param.cognome}"/>
                  <input type="hidden" name="sesso" value="${param.sesso}"/>
                  <input type="hidden" name="cod_fiscale" value="${param.cod_fiscale}"/>
                  <input type="hidden" name="data_nascita" value="${param.data_nascita}"/>
                  <input type="hidden" name="telefono" value="${param.telefono}"/>
                  <input type="hidden" name="email" value="${param.email}"/>
                  <input type="hidden" name="indirizzo" value="${param.indirizzo}"/>
                  <input type="hidden" name="professione" value="${param.professione}"/>
                  <input type="hidden" name="stato_salute" value="${param.stato_salute}"/>
                  <input type="hidden" name="cod_domanda" value="${param.cod_domanda}"/>
                  <input type="hidden" name="risposta" value="${param.risposta}"/>
                </form>
              </td>
            </tr>

<%@ include file="LAYOUT_BOTTOM.jspf" %>