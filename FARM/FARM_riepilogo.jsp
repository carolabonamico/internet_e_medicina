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

<!-- ================================== QUERY ======================================== -->

<sql:query var="donazione">
   select ID_SSC, 
          NOME_STUDIO,
          ((COSTO_FISSO_STRUM+COSTO_FISSO_ANALISI+TOTPAZ*INCENTIVO)-IMPORTO_RAGGIUNTO) AS 
          IMP_NEC, 
          IMPORTO_RAGGIUNTO 
   from SSC
   where ID_SSC="${param.id_ssc}"
</sql:query>
         
<!-- ============================= COPRO CENTRALE ==================================== -->

<tr height="60%" width="100%"  valign="middle">
  <td align="center" bgcolor="white" cellpadding="10" colspan="7">
    <img src ="invoice.png" height="150" alt="Finanziamento"><br/><br/>
    <h2 style="color:#25544E">Finanziamento<br/></h2>
  </td>
</tr>

<form method="post" action="FARM_updatefinanz.jsp">

  <tr align="center" valign="middle">
    <td width="25%" bgcolor="#D7D9D9" style="color:#9CA5A6" align="center">
      <h2><b>01 - Importo</b></h2>
    </td>
    <td width="25%" bgcolor="#D7D9D9" style="color:#9CA5A6" align="center">
      <h2><b>02 - Modalita' di pagamento</b></h2>
    </td>
    <td width="25%" bgcolor="#D7D9D9" style="color:#9CA5A6" align="center">
      <h2><b>03 - Dati</b></h2>
    </td>
    <td width="25%" bgcolor="#9AE082" style="color:white" align="center"> 
      <h2><b>04 - Riepilogo</b></h2>
    </td>
  </tr>

  <tr>
    <td colspan="4" align="center">
      <table cellpadding="5" border="0" width="50%">
      <h2 style="color:#25544E">Riepilogo finanziamento:<br></h2>
        <tr>
          <td width="50%" bgcolor="#2a5951" style="color:white" 
           align="right"><b>Esercente:</b></td> 
          <td width="50%" align="left"style="color:#468c7f">
           Centro Sperimentazioni Cliniche Frankenstain</td>
        </tr>

        <tr>
          <td width="50%" bgcolor="#2a5951" style="color:white" 
           align="right"><b>Importo:</b></td> 
          <td width="50%" align="left" style="color:#468c7f">
           ${param.importo} Euro</td></tr>

        <tr>
          <td width="50%" bgcolor="#2a5951" style="color:white" 
           align="right"><b>SSC finanziata:</b></td> 
          <c:forEach items="${donazione.rows}" var="riga">
            <td width="50%" align="left" style="color:#468c7f">${riga.NOME_STUDIO}</td> 
          </c:forEach>
        </tr>  

                    <tr>
          <td width="50%" bgcolor="#2a5951" style="color:white" 
           align="right"><b>Metodo di Pagamento:</b></td> 
          <td width="50%" align="left" style="color:#468c7f">${param.modpagam}</td>
        </tr>  

        <tr>
          <td width="50%" bgcolor="#2a5951" style="color:white" 
           align="right"><b>Numero rate:</b>
          </td> 
            <c:if test="${param.modpagam=='Rate'}">
              <td width="50%" align="left" style="color:#468c7f">${param.numrata}</td>
            </c:if>
            <c:if test="${param.modpagam!='Rate'}">
              <td width="50%" align="left" style="color:#468c7f">0</td>
            </c:if>
        </tr>

      </table>
    </td>
  </tr>

  <tr>
    <td colspan="4" style="color:#468c7f" align="center" width="100%">
      <i>Clicca su "Conferma" per confermare il pagamento.</i>
    </td>
  </tr> 
        
  <tr>
    <td colspan="4" align="center">
      <input type="submit" name="avanti" value="Conferma"/>
    </td>
  </tr>

  <input type="hidden" name="importo" value="${param.importo}"/>
  <input type="hidden" name="id_ssc" value=${param.id_ssc}>
  <input type="hidden" name="aggstato" value=${param.aggstato}>
  <input type="hidden" name="numrata" value=${param.numrata}>
  <input type="hidden" name="modpagam" value=${param.modpagam}>

</form>

<tr>
  <td colspan="4" align="center">
    <form method="post" action="FARM_pagamento.jsp">
      <input type="submit" name="indietro" value="Indietro"/>

      <input type="hidden" name="importo" value="${param.importo}"/>
      <input type="hidden" name="modpagam" value="${param.modpagam}"/>
      <input type="hidden" name="id_ssc" value=${param.id_ssc}>
      <input type="hidden" name="aggstato" value=${param.aggstato}>
      <c:if test="${param.modpagam=='Carta' || param.modpagam=='Rate'}">
        <input type="hidden" name="intestatario" value="${param.intestatario}">
        <input type="hidden" name="numcarta" value="${param.numcarta}">
        <input type="hidden" name="mese" value="${param.mese}">
        <input type="hidden" name="anno" value="${param.anno}">
        <input type="hidden" name="cvv" value="${param.cvv}">
        <input type="hidden" name="numrata" value=${param.numrata}>
      </c:if>
      <c:if test="${param.modpagam=='PayPal'}">
        <input type="hidden" name="email" value="${param.email}">
        <input type="hidden" name="password" value="${param.password}">
      </c:if>
      <c:if test="${param.modpagam=='Bonifico'}">
        <input type="hidden" name="intestatario" value="${param.intestatario}">
        <input type="hidden" name="conto" value="${param.conto}">
        <input type="hidden" name="causale" value="${param.causale}">
      </c:if>
    </form>
  </td>
</tr>

</td>
</tr>

<!-- ============================================================= --> 

<%@ include file="LAYOUT_BOTTOM.jspf" %>