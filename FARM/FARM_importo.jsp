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

<!-- ==================================== QUERY ====================================== -->
<sql:query var="donazione">
  select ID_SSC,
         NOME_STUDIO, 
         ((COSTO_FISSO_STRUM+COSTO_FISSO_ANALISI+TOTPAZ*INCENTIVO)-IMPORTO_RAGGIUNTO) AS 
         IMP_NEC, 
         (COSTO_FISSO_STRUM+COSTO_FISSO_ANALISI+TOTPAZ*INCENTIVO) AS 
         BUDGET_COMPLESSIVO,
         IMPORTO_RAGGIUNTO 
  from SSC
  where ID_SSC="${param.id_ssc}" 
</sql:query>

<!-- ============================= COPRO CENTRALE ==================================== -->

  <!-- --------------------- Pulsante indietro --------------------- --> 
    <tr>
        <td align="center" width="33%">
          <a href="FARM_studiclinici.jsp">
            <img src="undo.png" width="40" height="40" title="Indietro">
          </a>
        </td>
        <td>&nbsp</td>
        <td>&nbsp</td>
</tr>
 
  <!-- --------------------------- Intestazione --------------------------- -->
    <tr height="60%" width="100%"  valign="middle">
      <td align="center" bgcolor="white" colspan="7" cellpadding="10">
        <img src ="invoice.png" height="150" alt="Finanziamento"><br/><br/>
          <h2 style="color:#25544E">Finanziamento<br/></h2>
          <p style="color:#25544E">
            <i>Effettua il tuo finanziamento in pochi e semplici passi!</i>
          </p> 
      </td>
    </tr>

    <form method="post" action="FARM_act_importo.jsp">

      <tr align="center" valign="middle">
        <c:if test="${not empty errmsg}">
          <td width="25%" bgcolor="#FF4C40" style="color:white" align="center">
            <h2><b>01 - Importo</b></h2>
          </td>
        </c:if>
        <c:if test="${empty errmsg}">
          <td width="25%" bgcolor="#9AE082" style="color:white" align="center">
            <h2><b>01 - Importo</b></h2>
          </td>
        </c:if>
        <td width="25%" bgcolor="#D7D9D9" style="color:#9CA5A6" align="center">
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
        <td align="center" colspan="4">
          <table valign="middle" align="center" border="0" width="60%" cellspacing="0" 
           cellpadding="10" style="color:#25544E">
            <tr bgcolor="#f2f2f2" height="60" width="15%">
              <c:forEach items="${donazione.rows}" var="riga">
                <td align="center"><b>L'importo necessario per completare il finanziamento 
                 dello studio clinico "${riga.NOME_STUDIO}" ammonta a </br> 
                 ${riga.IMP_NEC} Euro. 
                 <br/>
                 Aiutaci a raggiungerlo! </b></td>
              </c:forEach>
            </tr>
          </table>
        </td>
      </tr>

      <tr valign="bottom">
        <c:forEach items="${donazione.rows}" var="riga">
          <td style="color:#468c7f" align="center" width="100%" colspan="4">
             Inserire l'importo desiderato per finanziare lo studio
          </td> 
        </c:forEach>
      </tr>
        
     <tr>
       <td align="center" colspan="4">
        <table valign="middle" align="center" border="0" width="60%" cellspacing="0" 
           cellpadding="10" style="color:#25544E">
          <tr bgcolor="#f2f2f2" height="60" width="15%">
            <td  width="50%"  align="right"  >
             <br/>
             <h2><b>Importo:</b></h2><br/>
            </td>
            <td width="50%" style="color:#468c7f"  align="left" >
             <input type="number" name="importo" value="${param.importo}" min="1"/>
           </td>
         </tr>
       </table>
     </td>
    </tr>
        
        
      <tr valign="top">
        <c:if test="${not empty errmsg}">
          <td colspan="4" style="color:red" align="center" width="100%">
            <b>${errmsg}</b>
          </td>
        </c:if>
        <c:if test="${empty errmsg}">
          <td colspan="4" align="center" width="100%">
            <i> Clicca su "Avanti" per procedere con il pagamento.</i>
          </td>
        </c:if>
      </tr>
        
      <tr>
        <td colspan="4" width="100%" align="center">
          <input type="submit" name="avanti" value="Avanti"/>
          <input type="hidden" name="id_ssc" value=${param.id_ssc}>
        </td>
      </tr>
    </form> 

<!-- ===================================== BOTTOM ==================================== -->

<%@ include file="LAYOUT_BOTTOM.jspf" %>