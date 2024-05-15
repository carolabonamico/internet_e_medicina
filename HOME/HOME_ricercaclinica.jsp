<%@ page session="true"
         language="java"
         contentType="text/html; charset=UTF-8"
         import="java.sql.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://it.unipv.bmilab.uploadtags"      prefix="upload" %>

<%@ include file="LAYOUT_TOP.jspf" %>
<%@ include file="LAYOUT_MENU_HOME.jspf" %>

<!-- ==================== Inizio pagina ===================== -->

      <tr valign="middle">
        <td align="justify" width="50%">
          <h2><font style="color:#25544E"><b>Cos'e' uno studio clinico<br/><br/><br/></b></font></h2>
          <p style="color:#468c7f">Gli <b>studi clinici</b></a> sono condotti nell'uomo, paziente o volontario sano,
          allo <b>scopo</b> di fornire nuove conoscenze su farmaci e trattamenti, verificandone
          efficacia e rischi, per decidere se le nuove terapie offrono vantaggi rispetto a quelle esistenti.</br>
          L'<b>aggettivo clinico</b> indica che la sperimentazione e' compiuta sull'uomo, malato o sano.</br>
          La <b>ricerca clinica</b> e' preceduta da una fase detta pre-clinica, che studia i
          nuovi farmaci utilizzando modelli in vitro (su colture di cellule) o in vivo (su animali da laboratorio).</br>
          </p>
        </td>
        <td width="50%" align="center" valign="middle">          
          <img src="ricerca2.jpg" alt="ricerca clinica" height="325" valing="middle">
        </td>
      </tr>

      <tr>
        <td align="justify" width="55%" valign="middle">
          <h2><font style="color:#25544E"><b>Tipi di sperimentazione<br/><br/><br/></b></font></h2>
          <p style="color:#468c7f">Gli <b>obiettivi</b> di una sperimentazione clinica possono essere molteplici.</br></p>
          <ul style="color:#468c7f">
          <li>Negli <b>studi di screening</b> si valuta la capacita' di un esame di determinare una malattia prima che essa provochi sintomi.</li>
          <li>Nelle <b>sperimentazioni sulla qualita' di vita</b> e' valutato l'impatto della malattia sulla vita quotidiana
          del malato e sulla sua sfera psichica.</li>
          <li>Gli <b>studi di bioequivalenza</b> hanno l'obiettivo di dimostrare che due farmaci hanno la stessa
          biodisponibilita'. La biodisponibilita' e' la velocita' e la quantita' con cui un principio
          attivo e' assorbito e diventa disponibile al sito d'azione. </li>
          <li>Negli <b>studi clinici con nuovi farmaci</b> si indaga l'efficacia di una nuova terapia.
          Nel corso del processo di sviluppo di un farmaco devono essere condotti tutti gli studi necessari
          per valutarne la tollerabilita'/sicurezza , la farmacocinetica , la farmacodinamica e l'efficacia.</li>
          </ul>
          <p style="color:#468c7f">
          I risultati favorevoli cosi' ottenuti consentono di ottenere dalle autorita' competenti (le Agenzie
          Regolatorie, responsabili a livello nazionale o sovranazionale) il permesso di registrare e
          commercializzare il nuovo farmaco.</br>
          Tuttavia, la ricerca non si esaurisce con la commercializzazione del prodotto, ma continua con altri
          studi clinici condotti in seguito con l'intento di approfondire e consolidare le conoscenze sul farmaco,
          di ottenere altri dati a supporto della sua validita' terapeutica nella condizione patologica registrata
          (indicazione) e di studiarne eventualmente altre applicazioni.</br>
          </p>
        </td>
        <td width="50%" valign="middle" align="center">
          <img src="ricerca3.jpg" height="400" alt="Ricerca clinica"></td>
      </tr>

<%@ include file="LAYOUT_BOTTOM.jspf" %>