<%@page import="br.edu.ifsul.dao.UnidadeCondominialDao"%>
<%@page import="br.edu.ifsul.dao.LocatarioDao"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="br.edu.ifsul.modelo.Aluguel"%>
<%@page import="br.edu.ifsul.dao.AluguelDao"%>
<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<jsp:useBean id="aluguelDao" scope="session" type="AluguelDao"/>
<jsp:useBean id="locatarioDao" scope="session" type="LocatarioDao"/>
<jsp:useBean id="unidadeCondominialDao" scope="session" type="UnidadeCondominialDao"/>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>Listagem de aluguel</title>
    </head>
    <body>
        <a href="../index.html">inicio</a>
        <h2>Aluguel</h2>
        <h2><%=aluguelDao.getMensagem()%></h2>
        <a href="ServletAluguel?acao=incluir">Incluir</a>
        <table border="1">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Valor</th>
                    <th>Inicio do Contrato</th>
                    <th>Fim  do Contrato</th>
                    <th>Dia do Vencimento</th>
                    <th>Locatario</th>
                    <th>Unidade Condominial</th>
                    <th>Alterar</th>
                    <th>Excluir</th>
                </tr>
            </thead>
            <tbody>
                <% 
                for(Aluguel a : aluguelDao.getLista()){
                %>
                <tr>
                    <td><%=a.getId()%></td>
                    <td><%=a.getValor()%></td>
                    <td><%=new SimpleDateFormat("dd/MM/yyyy").format(a.getInicioContrato().getTime())%></td>
                    <td><%=new SimpleDateFormat("dd/MM/yyyy").format(a.getFimContrato().getTime())%></td>
                    <td><%=a.getDiaVencimento()%></td>
                    <td><%=a.getLocatario().getNome()%></td>
                    <td><%=a.getUnidadeCond().getDescricao()%></td>
                    <td><a href="ServletAluguel?acao=alterar&id=<%=a.getId()%>">Alterar</a></td>
                    <td><a href="ServletAluguel?acao=excluir&id=<%=a.getId()%>">Excluir</a></td>
                </tr>
                <%
                }
                %>
            </tbody>
        </table>
    </body>
</html>
