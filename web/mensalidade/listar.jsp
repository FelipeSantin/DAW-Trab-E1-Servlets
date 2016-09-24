<%@page import="java.text.SimpleDateFormat"%>
<%@page import="br.edu.ifsul.modelo.Mensalidade"%>
<%@page import="br.edu.ifsul.dao.MensalidadeDao"%>
<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<jsp:useBean id="mensalidadeDao" scope="session" type="MensalidadeDao"/>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>Listagem de mensalidades</title>
    </head>
    <body>
        <a href="../index.html">inicio</a>
        <h2>Mensalidades</h2>
        <h2><%=mensalidadeDao.getMensagem()%></h2>
        <a href="ServletMensalidade?acao=incluir">Incluir</a>
        <table border="1">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Valor</th>
                    <th>Valor Pagamento</th>
                    <th>Vencimento</th>
                    <th>Vencimento Pagamento</th>
                    <th>Aluguel</th>
                    <th>Alterar</th>
                    <th>Excluir</th>
                </tr>
            </thead>
            <tbody>
                <% 
                for(Mensalidade m : mensalidadeDao.getLista()){
                %>
                <tr>
                    <td><%=m.getId()%></td>
                    <td><%=m.getValor()%></td>
                    <td><%=m.getValorPagamento()%></td>
                    <td><%=new SimpleDateFormat("dd/MM/yyyy").format(m.getVencimento().getTime())%></td>
                    <td><%=new SimpleDateFormat("dd/MM/yyyy").format(m.getVencimentoPagamento().getTime())%></td>
                    <td><%=" Aluguel de " + new SimpleDateFormat("dd-MM-yyyy").format(m.getAluguel().getInicioContrato().getTime()) + " até " + new SimpleDateFormat("dd-MM-yyyy").format(m.getAluguel().getFimContrato().getTime())%></td>
                    <td><a href="ServletMensalidade?acao=alterar&id=<%=m.getId()%>">Alterar</a></td>
                    <td><a href="ServletMensalidade?acao=excluir&id=<%=m.getId()%>">Excluir</a></td>
                </tr>
                <%
                }
                %>
            </tbody>
        </table>
    </body>
</html>
