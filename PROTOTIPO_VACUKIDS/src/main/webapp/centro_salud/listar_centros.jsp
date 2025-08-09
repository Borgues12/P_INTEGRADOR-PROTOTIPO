<%@ page import="ModelDao.CentroSaludDao" %>
<%@ page import="Model.Centro_salud" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Iterator" %><%--
  Created by IntelliJ IDEA.
  User: LABEPDS01
  Date: 03/07/2025
  Time: 02:04 p. m.
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<h2>Listar Centros de Salud</h2>
<table>
    <tr>
        <th>ID</th>
        <th>Nombre del Centro de Salud</th>
        <th>Latitud</th>
        <th>Longitud</th>
    </tr>
    <%
        CentroSaludDao centrodao = new CentroSaludDao();
        List<Centro_salud> centros_sa = centrodao.listar();
        Iterator<Centro_salud> iterator = centros_sa.iterator();
        Centro_salud centro = null;
        while (iterator.hasNext()){
            centro = iterator.next();
    %>
    <tr>
        <td> <%= centro.getIdCentroSalud()%></td>
        <td> <%= centro.getNombreCentroSalud()%></td>
        <td> <%= centro.getLatitud()%></td>
        <td> <%= centro.getLongitud()%></td>
    </tr>
    <%
        }
    %>
</table>
</body>
</html>
