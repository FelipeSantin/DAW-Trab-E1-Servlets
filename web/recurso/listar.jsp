<%-- 
    Document   : listar
    Created on : 17/09/2016, 20:35:42
    Author     : Felipe
--%>

<%@page import="br.edu.ifsul.modelo.Recurso"%>
<%@page import="br.edu.ifsul.dao.RecursoDao"%>
<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<jsp:useBean id="recursoDao" scope="session" type="RecursoDao"/>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>Listagem de recursos</title>
    </head>
    <body>
        <a href="../index.html">inicio</a>
        <h2>Recursos</h2>
        <h2><%=recursoDao.getMensagem()%></h2>
        <a href="ServletRecurso?acao=incluir">Incluir</a>
        <table border="1">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Descricao</th>
                    <th>Alterar</th>
                    <th>Excluir</th>
                </tr>
            </thead>
            <tbody>
                <% 
                for(Recurso e : recursoDao.getLista()){
                %>
                <tr>
                    <td><%=e.getId()%></td>
                    <td><%=e.getDescricao()%></td>
                    <td><a href="ServletRecurso?acao=alterar&id=<%=e.getId()%>">Alterar</a></td>
                    <td><a href="ServletRecurso?acao=excluir&id=<%=e.getId()%>">Excluir</a></td>
                </tr>
                <%
                }
                %>
            </tbody>
        </table>
    </body>
</html>
