<%@ page session="true" 
language="java" 
contentType="text/html; charset=UTF-8" 
import="java.sql.*" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://it.unipv.bmilab.uploadtags"      prefix="upload" %>

<!-- ==================== Top ===================== -->
<%@ include file="LAYOUT_TOP.jspf" %>
<c:if test="${ruolo_user == 'FARM'}">
  <%@ include file="LAYOUT_MENU_FARM.jspf" %>
</c:if>
<c:if test="${ruolo_user == 'PRES'}">
  <%@ include file="LAYOUT_MENU_PRES.jspf" %>
</c:if>
<c:if test="${ruolo_user == 'MED'}">
  <%@ include file="LAYOUT_MENU_MED.jspf" %>
</c:if>
<c:if test="${ruolo_user == 'PAZ'}">
  <%@ include file="LAYOUT_MENU_PAZ.jspf" %>
</c:if>
<c:if test="${ruolo_user == 'RESP'}">
  <%@ include file="LAYOUT_MENU_RESP.jspf" %>
</c:if>
<c:if test="${ruolo_user == 'FRANK'}">
  <%@ include file="LAYOUT_MENU_FARM.jspf" %>
</c:if>

      <!-- ==================== Corpo Centrale ===================== -->
      <tr valign="middle">
        <td colspan="2" align="center"><img src="exit.png" height="150" alt="Logout"></td>
      </tr>
      <tr>
        <td colspan="2" align="center">
          <h2>Si desidera effettuare il logout dall'area riservata?</h2>
        </td>
      </tr>
            <!-- --------------------- Pulsanti di logout/annulla --------------------- --> 
            <tr>
              <td align="right" width="50%">
                <form method="post" action="actlogout.jsp">
                  <input type="submit" name="logout" value="Logout" style="color:#2A5951"/>
                </form>
              </td>
              
              <td align="left"  width="50%">
                <c:if test="${not empty id_user && ruolo_user == 'PAZ'}">
                  <form method="post" action="PAZ_home.jsp">
                    <input type="submit" name="annulla_logout" value="Annulla" style="color:#2A5951"/>
                  </form>
                </c:if>
                <c:if test="${not empty id_user && ruolo_user == 'RESP'}">
                  <form method="post" action="RESP_home.jsp">
                    <input type="submit" name="annulla_logout" value="Annulla" style="color:#2A5951"/>
                  </form>
                </c:if>
                <c:if test="${not empty id_user && ruolo_user == 'PRES'}">
                  <form method="post" action="PRES_home.jsp">
                    <input type="submit" name="annulla_logout" value="Annulla" style="color:#2A5951"/>
                  </form>
                </c:if>
                <c:if test="${not empty id_user && ruolo_user == 'FRANK'}">
                  <form method="post" action="FRANK_home.jsp">
                    <input type="submit" name="annulla_logout" value="Annulla" style="color:#2A5951"/>
                  </form>
                </c:if>
                <c:if test="${not empty id_user && ruolo_user == 'FARM'}">
                  <form method="post" action="FARM_home.jsp">
                    <input type="submit" name="annulla_logout" value="Annulla" style="color:#2A5951"/>
                  </form>
                </c:if>
                <c:if test="${not empty id_user && ruolo_user == 'MED'}">
                  <form method="post" action="MED_home.jsp">
                    <input type="submit" name="annulla_logout" value="Annulla" style="color:#2A5951"/>
                  </form>
                </c:if>
              </td>
            </tr>

<%@ include file="LAYOUT_BOTTOM.jspf" %>