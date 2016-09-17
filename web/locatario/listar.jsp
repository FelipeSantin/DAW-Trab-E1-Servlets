<%-- 
    Document   : listar
    Created on : 17/09/2016, 18:25:42
    Author     : Felipe
--%>

<%@page import="br.edu.ifsul.modelo.Locatario"%>
<%@page import="br.edu.ifsul.dao.LocatarioDao"%>
<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<jsp:useBean id="locatarioDao" scope="session" type="LocatarioDao"/>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>Listagem de locatarios</title>
    </head>
    <body>
        <a href="../index.html">inicio</a>
        <h2>Locatarios</h2>
        <h2><%=locatarioDao.getMensagem()%></h2>
        <a href="ServletLocatario?acao=incluir">Incluir</a>
        <table border="1">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Nome</th>
                    <th>CPF</th>
                    <th>Email</th>
                    <th>Telefone</th>
                    <th>LocalTrabalho</th>
                    <th>TelefoneTrabalho</th>
                    <th>Renda</th>
                    <th>Alterar</th>
                    <th>Excluir</th>
                </tr>
            </thead>
            <tbody>
                <% 
                for(Locatario e : locatarioDao.getLista()){
                %>
                <tr>
                    <td><%=e.getId()%></td>
                    <td><%=e.getNome() %></td>
                    <td><%=e.getCpf()%></td>
                    <td><%=e.getEmail()%></td>
                    <td><%=e.getTelefone()%></td>
                    <td><%=e.getLocaltrabalho()%></td>
                    <td><%=e.getTelefonetrabalho()%></td>
                    <td><%=e.getRenda()%></td>
                    <td><a href="ServletLocatario?acao=alterar&id=<%=e.getId()%>">Alterar</a></td>
                    <td><a href="ServletLocatario?acao=excluir&id=<%=e.getId()%>">Excluir</a></td>
                </tr>
                <%
                }
                %>
            </tbody>
        </table>
    </body>
</html>
