<%@page import="br.edu.ifsul.dao.CondominioDao"%>
<%@page import="br.edu.ifsul.dao.PessoaDao"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="br.edu.ifsul.modelo.UnidadeCondominial"%>
<%@page import="br.edu.ifsul.dao.UnidadeCondominialDao"%>
<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<jsp:useBean id="unidadeCondominialDao" scope="session" type="UnidadeCondominialDao"/>
<jsp:useBean id="pessoaDao" scope="session" type="PessoaDao"/>
<jsp:useBean id="condominioDao" scope="session" type="CondominioDao"/>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>Listagem de unidadeCondominial</title>
    </head>
    <body>
        <a href="../index.html">inicio</a>
        <h2>UnidadeCondominial</h2>
        <h2><%=unidadeCondominialDao.getMensagem()%></h2>
        <a href="ServletUnidadeCondominial?acao=incluir">Incluir</a>
        <table border="1">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Número</th>
                    <th>Descrição</th>
                    <th>Área</th>
                    <th>Número Quarto</th>
                    <th>Pessoa</th>
                    <th>Condominio</th>
                    <th>Alterar</th>
                    <th>Excluir</th>
                </tr>
            </thead>
            <tbody>
                <% 
                for(UnidadeCondominial uc : unidadeCondominialDao.getLista()){
                %>
                <tr>
                    <td><%=uc.getId()%></td>
                    <td><%=uc.getNumero()%></td>
                    <td><%=uc.getDescricao()%></td>
                    <td><%=uc.getArea()%></td>
                    <td><%=uc.getNumeroquarto()%></td>
                    <td><%=uc.getPessoa().getNome()%></td>
                    <td><%=uc.getCondominio().getNome()%></td>
                    <td><a href="ServletUnidadeCondominial?acao=alterar&id=<%=uc.getId()%>">Alterar</a></td>
                    <td><a href="ServletUnidadeCondominial?acao=excluir&id=<%=uc.getId()%>">Excluir</a></td>
                </tr>
                <%
                }
                %>
            </tbody>
        </table>
    </body>
</html>
