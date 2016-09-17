<%-- 
    Document   : listar
    Created on : 17/09/2016, 20:45:22
    Author     : Felipe
--%>

<%@page import="br.edu.ifsul.modelo.Condominio"%>
<%@page import="br.edu.ifsul.dao.CondominioDao"%>
<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<jsp:useBean id="condominioDao" scope="session" type="CondominioDao"/>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>Listagem de condominios</title>
    </head>
    <body>
        <a href="../index.html">inicio</a>
        <h2>Condominios</h2>
        <h2><%=condominioDao.getMensagem()%></h2>
        <a href="ServletCondominio?acao=incluir">Incluir</a>
        <table border="1">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Nome</th>
                    <th>Numero</th>
                    <th>Endereco</th>
                    <th>CEP</th>
                    <th>Alterar</th>
                    <th>Excluir</th>
                </tr>
            </thead>
            <tbody>
                <% 
                for(Condominio e : condominioDao.getLista()){
                %>
                <tr>
                    <td><%=e.getId()%></td>
                    <td><%=e.getNome()%></td>
                    <td><%=e.getNumero()%></td>
                    <td><%=e.getEndereco()%></td>
                    <td><%=e.getCep()%></td>
                    <td><a href="ServletCondominio?acao=alterar&id=<%=e.getId()%>">Alterar</a></td>
                    <td><a href="ServletCondominio?acao=excluir&id=<%=e.getId()%>">Excluir</a></td>
                </tr>
                <%
                }
                %>
            </tbody>
        </table>
    </body>
</html>
