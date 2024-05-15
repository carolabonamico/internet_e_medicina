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

<%@ include file="LAYOUT_TOP.jspf"%>
<%@ include file="LAYOUT_MENU_FARM.jspf"%>

<!-- ================================= QUERY ========================================= -->

<sql:query var="donazione">
   select ID_SSC, 
          ((COSTO_FISSO_STRUM+COSTO_FISSO_ANALISI+TOTPAZ*INCENTIVO)-IMPORTO_RAGGIUNTO) AS 
          IMP_NEC, 
          IMPORTO_RAGGIUNTO 
  from SSC
  where ID_SSC="${param.id_ssc}" 
</sql:query>    

<!-- ============================= CORPO CENTRALE ==================================== -->

  <!-- --------------------------- Intestazione --------------------------- -->
    <tr height="60%" width="100%"  valign="middle">
      <td align="center" bgcolor="white" colspan="7" cellpadding="10">
        <img src ="invoice.png" height="150" alt="Finanziamento"><br/><br/>
          <h2 style="color:#25544E">Finanziamento<br/></h2>
          <p style="color:#25544E">
      </td>
    </tr>
      <form method="post" action="FARM_pagamento.jsp">

        <tr align="center" valign="middle">
          <td width="25%" bgcolor="#D7D9D9" style="color:#9CA5A6" align="center">
            <h2><b>01 - Importo</b></h2>
          </td>
          <td width="25%" bgcolor="#9AE082" style="color:white" align="center">
            <h2><b>02 - Modalita' di pagamento</b></h2>
          </td>
          <td width="25%" bgcolor="#D7D9D9" style="color:#9CA5A6" align="center">
            <h2><b>03 - Dati</b></h2>
          </td>
          <td width="25%" bgcolor="#D7D9D9" style="color:#9CA5A6" align="center"> 
            <h2><b>04 - Riepilogo</b></h2>
          </td>
        </tr>

        <tr>
          <td colspan="4" style="color:#468c7f" align="center" width="100%">          
            <font style="color:#25544E">Seleziona la modalita' di pagamento<br/></font>
          </td>
        </tr>

        <tr>
          <td colspan="4">
            <table width="100%" align="center">
              <tr>
                <td style="color:#2a5951" align="left" width="50%">
                  <input type="radio" name="modpagam" value="Carta" 
                    <c:if test="${param.modpagam=='Carta'}">checked="checked"</c:if>>
                      <b>Carta di credito/debito</b></input> 
                </td>
                <td width="50%">
                  <table width="100%">
                    <tr>
                      <td><img src="vis.jpeg" alt="visa" height="70"></td>
                      <td><img src="mastercard.jpeg" alt="mastercard" height="50"></td>
                      <td><img src="maestro.jpeg" alt="meastro" height="70"></td>
                    </tr>
                  </table>
                </td>
              </tr>
              <tr>
                <td style="color:#468c7f" align="left" width="50%">
                 Sono accettate solo le carte di credito Visa, Mastercard, Maestro.</td>
                <td width="50%">&nbsp</td>
              </tr>

              <tr>
                <td style="color:#2a5951" align="left" width="50%">
                  <input type="radio" name="modpagam" value="PayPal" 
                    <c:if test="${param.modpagam=='PayPal'}">checked="checked"</c:if>>
                      <b>PayPal</b></input>
                </td>
                <td width="50%"><img src="paypal.jpeg" alt="visa" width="70" height="70">
                </td>
              </tr>
              <tr>
                <td style="color:#468c7f" align="left" width="50%">
                 Paga via PayPal, verrai reindirizzato al sito.
                </td>
                <td width="50%">&nbsp</td>
              </tr>
                        
              <tr>
                <td style="color:#2a5951" align="left" width="50%">
                  <input type="radio" name="modpagam" value="Bonifico" 
                    <c:if test="${param.modpagam=='Bonifico'}">checked="checked"</c:if>>
                      <b>Bonifico bancario</b> 
                  </input>
                </td>
                <td width="50%"><img src="bonifico2.jpeg" alt="bonifico" height="70"></td>
              </tr>
              <tr>
                <td style="color:#468c7f" align="left" width="50%">
                 Effettua il pagamento tramite bonifico bancario.
                </td>
                <td width="50%">&nbsp</td>
              </tr>
                 
              <tr>
                <td style="color:#2a5951" align="left" width="50%">
                  <input type="radio" name="modpagam" value="Rate"  
                    <c:if test="${param.modpagam=='Rate'}">checked="checked"</c:if>>
                      <b>A rate</b>
                    </input>
                 </td>
                 <td width="50%"><img src="scalapay.png" alt="scalapay" width="150" 
                  height="100"></td>
              </tr>
              <tr>
                <td style="color:#468c7f" align="left" width="50%">
                 Paga a rate senza interessi con il finanziamento Scalapay. 
                </td>
                <td width="50%">&nbsp</td>
              </tr>
            </table>
          </td>
        </tr>

        <tr>
          <td colspan="4" style="color:#468c7f" align="center" width="100%">
            <i>Clicca su "Conferma" per confermare la modalita' di pagamento.</i>
          </td>
        </tr>
        <tr>
          <td colspan="4" align="center">
            <input type="submit" name="conferma" value="Conferma"/>
          </td>
        </tr>

        <input type="hidden" name="importo" value=${param.importo}>
        <input type="hidden" name="id_ssc" value=${param.id_ssc}>
        <input type="hidden" name="aggstato" value=${param.aggstato}>
        <input type="hidden" name="modpagam" value=${param.modpagam}>
      </form>

      <tr>
        <td align="center" colspan="4">
          <form method="post" action="FARM_importo.jsp">
            <input type="submit" name="indietro" value="Indietro"/>
            <input type="hidden" name="importo" value=${param.importo}>
            <input type="hidden" name="id_ssc" value=${param.id_ssc}>
          </form>
        </td>
      </tr>

<!-- ===================================== BOTTOM ==================================== -->
<%@ include file="LAYOUT_BOTTOM.jspf" %>