<%@ page session="true" 
language="java" 
contentType="text/html; charset=UTF-8" 
import="java.sql.*" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://it.unipv.bmilab.uploadtags"      prefix="upload" %>

<c:set var="ruolo_pagina" value="PAZ"/>
<%@ include file="autorizzazione.jspf" %>

<sql:query var="rset_select_domanda">
  SELECT COD_DOMANDA, DOMANDA
  FROM SICUREZZA
</sql:query>

<%@ include file="LAYOUT_TOP.jspf" %>
<%@ include file="LAYOUT_MENU_PAZ.jspf" %>


      <!-- ==================== Corpo Centrale ===================== -->
          
      <!-- --------------------- Pulsante indietro --------------------- --> 
      <tr valign="top">
        <td align="center" width="20%">
          <a href="anagrafica.jsp">
            <img src="undo.png" width="40" height="40" title="Indietro"/>
          </a>
        </td>
        <td align="center" width="20%"> &nbsp </td>
        <td align="center" width="20%"> &nbsp </td>
        <td align="center" width="20%"> &nbsp </td>
        <td align="center" width="20%"> &nbsp </td>
      </tr>

<!-- ================== Script per il menu a comparsa ================== -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<script>$(document).ready(function(){
    $("#menuButton").click(function(){
      $("#menu").slideToggle();
    });
  });</script>

<!--======================MENU A COMPARSA=================-->

<tr height="60">
            <td align="center" colspan="5">
                <button id="menuButton"><font color="#25544">Note correzione</font></button>
            </td>
        </tr>
        <tr>
            <td colspan="5" align="center">
                <div id="menu" style="display:none;" align="left">
                  <table cellpadding="10">
                  <tr>
                  <td>
                  <p>In questa pagina sono presenti i seguenti controlli:</p>
                  <ul>
                  <li>Se il form viene compilato senza aver modificato i dati gia' presenti, apparira' un apposito messaggio;</li>
                  <li>Se almeno un campo viene modificato apparira' un apposito messaggio.</li>
                  </ul>
                </td>
                </tr>
                </table>
               </div>
            </td>
        </tr>
            
      <!-- --------------------- Tabella di modifica --------------------- --> 
      <form action="PAZ_cntrlmodificainfopaz.jsp" method="post">
        <tr valign="middle">
          <td align="center" colspan="5">
              <table valign="middle" align="center" border="0" width="50%" cellspacing="0" cellpadding="10" style="color:#468c7f">

              <!-- --------------------- Intestazione + messaggio errore --------------------- -->  
              <tr>
                <td align="center" colspan="2">
                  <c:if test="${not empty msg}">
                    <img src="error.png" height="100" alt="Errore">
                  </c:if>
                  <h2 style="color:#25544E"><br/>Dati anagrafici e contatti<br/></h2>
                  <p align="center" style="color:#468c7f"><i>* I campi contrassegnati sono obbligatori.<br/></i></p> 
                  <c:if test="${not empty msg}">
                    <b><font color="#CC0000"><br/>${msg}</font></b>
                  </c:if>
                </td>
              </tr>

                <tr bgcolor="#f2f2f2" height="60">
                  <td> 
                    <c:if test="${not empty errnome}"><b><font color="#CC0000">Nome *</font></b></c:if>
                    <c:if test="${empty errnome}"><font color="#468c7f">Nome *</font></c:if>
                  </td>
                  <td><input type="text" name="nome" value="${param.nome}"/></td>
                </tr>

                <tr height="60">
                  <td> 
                    <c:if test="${not empty errcognome}"><b><font color="#CC0000">Cognome *</font></b></c:if>
                    <c:if test="${empty errcognome}"><font color="#468c7f">Cognome *</font></c:if>
                  </td>
                  <td><input type="text" name="cognome" value="${param.cognome}"/></td>
                </tr>

                <tr bgcolor="#f2f2f2" height="60">
                  <td> 
                    <c:if test="${not empty errsesso}"><b><font color="#CC0000">Sesso *</font></b></c:if>
                    <c:if test="${empty errsesso}"><font color="#468c7f">Sesso *</font></c:if>
                  </td>
	                <td>
		                <input type="radio" name="sesso" value="M" 
                    <c:if test="${param.sesso == 'M'}">checked="checked"</c:if>
                    />&nbsp;Maschio
		                <input type="radio" name="sesso" value="F" 
                    <c:if test="${param.sesso == 'F'}">checked="checked"</c:if>
                    />&nbsp;Femmina	
	                </td>
                </tr>

                <tr height="60">
                  <td> 
                    <c:if test="${not empty errcod_fiscale}"><b><font color="#CC0000">Codice fiscale *</font></b></c:if>
                    <c:if test="${empty errcod_fiscale}"><font color="#468c7f">Codice fiscale *</font></c:if>
                  </td>
                  <td><input type="text" name="cod_fiscale" value="${param.cod_fiscale}"/></td>
                </tr>

                <tr bgcolor="#f2f2f2" height="60">
                  <td> 
                    <c:if test="${not empty errdata_nascita}"><b><font color="#CC0000">Data di nascita *</font></b></c:if>
                    <c:if test="${empty errdata_nascita}"><font color="#468c7f">Data di nascita *</font></c:if>
                  </td>
                  <td><input type="date" name="data_nascita" value="${param.data_nascita}"/></td>
                </tr>

                <tr height="60">
                  <td>Cellulare</td>
                  <td>
                    <input type="tel" name="telefono" value="${param.telefono}"  
                    placeholder="123 456 7890" pattern="[0-9]{3} [0-9]{3} [0-9]{4}"/>
                  </td>
                </tr>

                <tr bgcolor="#f2f2f2" height="60" width="15%">
                  <td> 
                    <c:if test="${not empty erremail}"><b><font color="#CC0000">E-mail *</font></b></c:if>
                    <c:if test="${empty erremail}"><font color="#468c7f">E-mail *</font></c:if>
                  </td>
                  <td><input type="email" name="email" value="${param.email}" pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$"/></td>
                </tr>

                <tr height="60" width="15%">
                  <td> 
                    <c:if test="${not empty errindirizzo}"><b><font color="#CC0000">Indirizzo *</font></b></c:if>
                    <c:if test="${empty errindirizzo}"><font color="#468c7f">Indirizzo *</font></c:if>
                  </td>
                  <td><input type="text" name="indirizzo" placeholder="Strda Nuova 25, Pavia, PV" value="${param.indirizzo}"/></td>
                </tr>

                <tr bgcolor="#f2f2f2" height="60" width="15%">
                  <td>Professione</td>
                  <td>
                    <input type="text" name="professione" value="${param.professione}"/>
                  </td>
                </tr>

                <tr height="60" width="15%">
                  <td> 
                    <c:if test="${not empty errstato_salute}"><b><font color="#CC0000">Stato di salute *</font></b></c:if>
                    <c:if test="${empty errstato_salute}"><font color="#468c7f">Stato di salute *</font></c:if>
                  </td>
                  <td>
                    <textarea name="stato_salute" cols="40" rows="5">${param.stato_salute}</textarea>
                  </td>
                </tr>

                <tr height="60" width="15%"  bgcolor="#f2f2f2">
                  <td> 
                    <c:if test="${not empty errdom}"><b><font color="#CC0000">Domanda di sicurezza *</font></b></c:if>
                    <c:if test="${empty errdom}"><font color="#468c7f">Domanda di sicurezza *</font></c:if>
                  </td>
                  <td align="left">
                    <select name="cod_domanda">
                      <option value="" align="center">-- Domanda --</option>
                      <c:forEach items="${rset_select_domanda.rows}" var="dom">
                        <option value="${dom.COD_DOMANDA}" align="center"
                          <c:if test="${param.cod_domanda == dom.COD_DOMANDA}">selected="selected"</c:if>
                        >${dom.DOMANDA}</option>
                      </c:forEach>
                    </select>
                  </td>
                </tr>

                <tr height="60" width="15%">
                  <td> 
                    <c:if test="${not empty errrisp}"><b><font color="#CC0000">Risposta di sicurezza *</font></b></c:if>
                    <c:if test="${empty errrisp}"><font color="#468c7f">Risposta di sicurezza *</font></c:if>
                  </td>
                  <td><input type="text" name="risposta" value="${param.risposta}"/></td>
                </tr>

              </table>
          </td>
        </tr>
            
        <tr height="60" width="15%">
          <td align="center" colspan="5">
            <input type="submit" name="conferma_anagrafica" value="Conferma" style="color:#468c7f"/>
          </td>
        </tr>

      </form>

<%@ include file="LAYOUT_BOTTOM.jspf" %>