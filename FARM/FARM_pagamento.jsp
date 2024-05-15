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

<!-- ================================= QUERY ========================================= -->

<sql:query var="donazione">
   select s.ID_SSC, 
          ((s.COSTO_FISSO_STRUM+s.COSTO_FISSO_ANALISI+s.TOTPAZ*s.INCENTIVO)-s.IMPORTO_RAGGIUNTO) AS 
          IMP_NEC, 
          s.IMPORTO_RAGGIUNTO
   from SSC s
   where s.ID_SSC="${param.id_ssc}" 
</sql:query>

<!-- ============================= CORPO CENTRALE ==================================== -->
     
<form method="post" action="FARM_act_controlli.jsp">
  <input type="hidden" name="modpagam" value=${param.modpagam}>
  <input type="hidden" name="importo" value=${param.importo}>
  <input type="hidden" name="id_ssc" value=${param.id_ssc}>

  <!-- --------------------------- Intestazione --------------------------- -->
    <tr height="60%" width="100%"  valign="middle">
      <td align="center" bgcolor="white" colspan="7" cellpadding="10">
        <img src ="invoice.png" height="150" alt="Finanziamento"><br/><br/>
          <h2 style="color:#25544E">Finanziamento<br/></h2>
          <p style="color:#25544E">
      </td>
    </tr>
    
    <tr align="center" valign="middle">
      <td width="25%" bgcolor="#D7D9D9" style="color:#9CA5A6" align="center">
        <h2><b>01 - Importo</b></h2>
      </td>
      <td width="25%" bgcolor="#D7D9D9" style="color:#9CA5A6" align="center">
        <h2><b>02 - Modalita' di pagamento</b></h2>
      </td>
      <c:if test="${not empty param.errmsg}">
        <td width="25%" bgcolor="#FF4C40" style="color:white" align="center">
          <h2><b>03 - Dati</b></h2>
        </td>
      </c:if>
      <c:if test="${empty param.errmsg}">
        <td width="25%" bgcolor="#9AE082" style="color:white" align="center">
          <h2><b>03 - Dati</b></h2>
        </td>
      </c:if> 
      <td width="25%" bgcolor="#D7D9D9" style="color:#9CA5A6" align="center"> 
        <h2><b>04 - Riepilogo</b></h2>
      </td>
    </tr>

<!-- ==================================== CARTA/RATE ================================= -->
  <c:if test="${param.modpagam=='Carta' || param.modpagam=='Rate'}">

    <c:if test="${param.modpagam=='Carta'}">
      <tr>
        <td colspan="4"  align="center" width="100%">
          <img src="visamastercardmaestro.jpg" alt="carta" height="90">
            <h1 style="color:#25544E"> <b> Paga con carta </b> </h1>
        </td>
      </tr>
    </c:if>

    <c:if test="${param.modpagam=='Rate'}">
      <tr>
        <td colspan="4"  align="center" width="100%">
          <img src="scalapay.png" alt="scalapay" width="200" height="150">
            <h1 style="color:#25544E"> <b> Paga con Scalapay </b> </h1>
        </td>
      </tr>
  
      <tr>
        <td align="center" colspan="4">           
          <table border="0" height="60%" width="60%" cellpadding="10" 
           cellspacing="0" bgcolor="FAFDADD" style="color:#25544E">
            <tr>
              <td width="100%" align="center" colspan="3"><h3>Rateizza in:</h3></td>
            </tr>
            <tr>
              <td width="33%" align="center">
                <input type="radio" name="numrata" value="2" 
                  <c:if test="${param.numrata=='2'}">checked="checked"</c:if>>
                  <b>2 rate</b></input>
              </td>
              <td width="33%" align="center">
                <input type="radio" name="numrata" value="4" 
                  <c:if test="${param.numrata=='4'}">checked="checked"</c:if>>
                  <b>4 rate</b></input>
              </td>
              <td width="33%" align="center">
                <input type="radio" name="numrata" value="6" 
                  <c:if test="${param.numrata=='6'}">checked="checked"</c:if>>
                  <b>6 rate</b></input>
              </td>
            </tr>
          </table>
        </td>
      </tr>
      
      <tr>
        <td colspan="4" style="color:red" align="center" width="100%">
          <b>ATTENZIONE!</br>
          La quota della prima rata verra' addebitata in data odierna. </br> 
          Le successive, invece, verranno addebitate automaticamente con cadenza regolare 
          di 30 giorni a partire dalla data odierna sulla carta inserita .</b>
        </td>
      </tr>

      <tr> 
        <td align="center" colspan="4" width="100%">
          <h3><b> Metodo di pagamento </b><br/></h3>
          <img src="metodo_pagamento.png" alt="metodo_pagamento" width="350" height="60">  
        </td>
      </tr>
    </c:if>
   
    <tr>
      <td align="center" colspan="4">
        <table align="center" width="100%" style="color:#25544E">
          <tr align="center">
            <td align="right" width="50%" 
              <c:if test="${errint}">style="color:red"</c:if>
               >Intestatario carta:&nbsp;&nbsp;</td>
            <td align="left" width="50%">
              <table width="50%" align="left">
                <tr>
                  <td width="20%" align="left">
                    <input type="text" name="intestatario" value="${param.intestatario}"/> 
                  </td>
                </tr>
              </table>
            </td>
          </tr>

          <tr align="center">
            <td align="right" width="50%"
              <c:if test="${errnum}">style="color:red"</c:if>
               >Numero carta:&nbsp;&nbsp;</td>
            <td align="left" width="50%">
              <table width="50%" align="left">
                <tr>
                  <td width="20%" align="left">
                    <input type="text" name="numcarta" value="${param.numcarta}" 
                     onkeypress="return soloNumeri(event);" maxlength="16" minlength="16" 
                    /></td>
                </tr>
              </table>
            </td>
          </tr>

          <tr align="center">
            <td align="right" width="50%"
              <c:if test="${errdata}">style="color:red"</c:if>
              >Data di scadenza:&nbsp;&nbsp;</td>
            <td align="left" width="50%">
              <table width="50%" align="left">
                <tr>
                  <td width="20%" align="left">
                    <input id="mese_0" type="number" name="mese" min="1" max="12"
                     value="${param.mese}"/></td>
                  <td align="left">
                   <input  type="number" name="anno" min="2023" max="2060"
                     value="${param.anno}"/></td>
                </tr>
              </table> 
            </td>
          </tr>

          <tr align="center">
            <td align="right" width="50%"
              <c:if test="${errcvv}">style="color:red"</c:if>
               >Codice di sicurezza CVV:&nbsp;&nbsp;</td>
            <td align="left" width="50%">
              <table width="50%" align="left">
                <tr>
                  <td width="20%" align="left">
                 <input type="text" name="cvv" value="${param.cvv}" 
                      onkeypress="return soloNumeri(event);" maxlength="3"/></td>
                </tr>
              </table>
            </td>
          </tr>
        </table>
      </td>
    </tr>
        
    <c:if test="${not empty param.errmsg}">
      <tr>
        <td align="center" colspan="4">
          <b><font color="red">${param.errmsg}</font></b>
        </td>
      </tr>
    </c:if>

  </c:if>

<!-- ==================================== PAYPAL ===================================== -->
  <c:if test="${param.modpagam=='PayPal'}">
    <tr>
      <td colspan="4"  align="center" width="100%">
        <img src="paypal.jpeg" alt="visa" width="150" height="150">
          <h1> <b> Paga con PayPal </b> </h1>
      </td>
    </tr>

    <tr>
      <td colspan="2"  align="right" width="50%"
        <c:if test="${erremail}">style="color:red"</c:if>
         >Immetti il tuo indirizzo email:&nbsp;&nbsp; 
      </td>
      <td align="left" colspan="2" width="50%">
        <input type="text" name="email" value="${param.email}"/>
      </td>
    </tr>
        
    <tr>
      <td colspan="2"  align="right" width="50%"
        <c:if test="${errpass}">style="color:red"</c:if>
         >Password:&nbsp;&nbsp; 
      </td>
      <td align="left" colspan="2" width="50%">
        <input type="password" name="password" value="${param.password}"/>
      </td>
    </tr>
            
    <c:if test="${not empty param.errmsg}">
      <tr>
        <td align="center" colspan="4"></td>
          <b><font color="red">${param.errmsg}</font></b>
        </td>
      </tr>
    </c:if>

  </c:if>

<!-- ==================================== BONIFICO =================================== -->
  <c:if test="${param.modpagam=='Bonifico'}">

    <tr>
      <td colspan="4"  align="center" width="100%" style="color:#25544E">
        <img src="bonifico2.jpeg" alt="bonifico" height="90">
        <h1><b> Paga con bonifico </b></h1>
      </td>
    </tr>

    <tr>
      <td align="center" colspan="4">
        <table align="center" width="100%" style="color:#25544E">
          <tr align="center">
            <td align="right" width="50%"
              <c:if test="${errint}">style="color:red"</c:if>
               >Intestatario conto corrente:&nbsp;&nbsp;
            </td>
            <td align="left" width="50%"><input type="text" name="intestatario" 
             value="${param.intestatario}"></td>
          </tr>
          <tr align="center">
            <td align="right" width="50%"
              <c:if test="${errconto}">style="color:red"</c:if>
               >Numero conto corrente:&nbsp;&nbsp;
            </td>
            <td align="left" width="50%"><input type="text" name="conto"
             value="${param.conto}" onkeypress="return soloNumeri(event);" 
             maxlength="27" minlength="27" /></td>
          </tr>
          <tr><td colspan="2">&nbsp</td></tr>
          <tr align="center">
            <td align="right" width="50%">Beneficiario:&nbsp;&nbsp;</td>
            <td align="left" width="50%">Centro Sperimentazioni Cliniche 
             Frankenstain</td>
          </tr>
          <tr align="center">
            <td align="right" width="50%">IBAN:&nbsp;&nbsp;</td>
            <td align="left" width="50%">IT09R12345678901CV000123456</td>
          </tr>
          <tr><td colspan="2">&nbsp</td></tr>
          <tr align="center">
            <td align="right" width="50%"
              <c:if test="${errcausale}">style="color:red"</c:if>
               >Causale:&nbsp;&nbsp;
            </td>
            <td align="left" width="50%"><input type="text" name="causale" 
             maxlength="140" value="${param.causale}"></td>
          </tr>
          <tr><td colspan="2">&nbsp</td></tr>
          <tr align="center">
            <td align="right" width="50%">Importo:&nbsp;&nbsp;</td>
            <td align="left" width="50%">${param.importo} Euro</td>
          </tr>
        </table>
      </td>
    </tr>


    <c:if test="${not empty param.errmsg}">
      <tr>
        <td align="center" colspan="4">
          <b><font color="red">${param.errmsg}</font></b>
        </td>
      </tr>
    </c:if>

  </c:if>

<!-- ======================== CONFERMA/INDIETRO ====================================== -->
  <tr>
    <td align="center" colspan="4" height="40"> 
      <input type="submit" name="conferma" value="Conferma"
        <c:if test="${param.modpagam=='Carta'}">style="background-color:orange; border- 
         color:orange; color:white"</c:if> 
        <c:if test="${param.modpagam=='PayPal'}">style="background-color:blue; border- 
         color:blue; color:white"</c:if>
        <c:if test="${param.modpagam=='Bonifico'}">style="background-color:green; border- 
         color:green; color:white"</c:if> 
        <c:if test="${param.modpagam=='Rate'}">style="background-color:#ffc0cb; border- 
         color:#ffc0cb; color:black"</c:if>  
      />
    </td>
  </tr>

  <input type="hidden" name="importo" value=${param.importo}>
  <input type="hidden" name="modpagam" value=${param.modpagam}>

</form>
    
<tr>
  <td width="100%" height=10 align="center" colspan="4">
    <form method="post" action="FARM_modpagam.jsp">
      <input type="submit" name="indietro" value="Indietro"
        <c:if test="${param.modpagam=='Carta'}">style="background-color:orange; border- 
         color:orange; color:white"</c:if> 
        <c:if test="${param.modpagam=='PayPal'}">style="background-color:blue; border- 
         color:blue; color:white"</c:if>
        <c:if test="${param.modpagam=='Bonifico'}">style="background-color:green; border- 
         color:green; color:white"</c:if> 
        <c:if test="${param.modpagam=='Rate'}">style="background-color:#ffc0cb; border- 
         color:#ffc0cb; color:black"</c:if>  
      />
      <input type="hidden" name="importo" value=${param.importo}>
      <input type="hidden" name="modpagam" value=${param.modpagam}>
      <input type="hidden" name="id_ssc" value=${param.id_ssc}>
      <input type="hidden" name="numrata" value=${param.numrata}>
    </form>
  </td>
</tr>
                
<!-- ================================= BOTTOM ======================================== -->

<%@ include file="LAYOUT_BOTTOM.jspf" %>

<!-- =====================FUNZIONE PER METTERE I NUMERI DA 01 A 12==================== -->
<script>
var input = document.getElementById("mese_0");
input.addEventListener("input", function(e) {
  e.target.value = e.target.value.padStart(2,'0');
});
</script>

 <!-- ===============FUNZIONE PER METTERE NELLA TEXT AREA SOLO NUMERI================= -->
<script type="text/javascript">
   function soloNumeri(evt) {
   var charCode = (evt.which) ? evt.which : event.keyCode
   if (charCode > 31 && (charCode < 48 || charCode > 57)) {
      return false;
   }
   return true;
}
</script>
<!-- ===============FUNZIONE PER METTERE NELLA TEXT AREA TUTTO MAIUSCOLO============ -->
<script>

  var forceInputUppercase = function(e) {
    let el = e.target;
    let start = el.selectionStart;
    let end = el.selectionEnd;
    el.value = el.value.toUpperCase();
    el.setSelectionRange(start, end);
  };

  document.querySelectorAll(".uppercase").forEach(function(current) {
    current.addEventListener("keyup", forceInputUppercase);
  });

</script>