<%-- 
    Document   : formulario
    Created on : 17/09/2016, 18:22:16
    Author     : Felipe
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="br.edu.ifsul.modelo.Aluguel"%>
<%@page import="br.edu.ifsul.dao.AluguelDao"%>
<%@page import="br.edu.ifsul.dao.MensalidadeDao"%>
<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<jsp:useBean id="mensalidadeDao" scope="session" type="MensalidadeDao"/>
<jsp:useBean id="aluguelDao" scope="session" type="AluguelDao"/>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>Edição de mensalidades</title>
        <script>
            function doSalvar(){
                document.getElementById("acao").value = 'salvar';
                document.getElementById("form").submit();
            }
            
            function doCancelar(){
                document.getElementById("acao").value = 'cancelar';
                document.getElementById("form").submit();
            }
        </script>
    </head>
    <body>
        <h2>Edição de Mensalidades</h2>
        <h2><%=mensalidadeDao.getMensagem()%></h2>
        <form name="form" id="form" action="ServletMensalidade" method="POST">
            Código
            <input type="text" name="id" id="id" value="<%=mensalidadeDao.getObjetoSelecionado().getId() == null ? "" : mensalidadeDao.getObjetoSelecionado().getId()%>" size="6" readonly/><br/>
            Valor
            <input type="text" name="valor" id="valor" value="<%=mensalidadeDao.getObjetoSelecionado().getValor()== null ? "" : mensalidadeDao.getObjetoSelecionado().getValor()%>" size="50"/><br/>
            Valor Pagamento
            <input type="text" name="valorpagamento" id="valorpagamento" value="<%=mensalidadeDao.getObjetoSelecionado().getValorPagamento()== null ? "" : mensalidadeDao.getObjetoSelecionado().getValorPagamento()%>" size="14"/><br/>
            Vencimento
            <input type="date" name="vencimento" id="vencimento" value="<%=mensalidadeDao.getObjetoSelecionado().getVencimento()== null ? "" : new SimpleDateFormat("yyyy-MM-dd").format(mensalidadeDao.getObjetoSelecionado().getVencimento().getTime())%>" size="50"/><br/>
            Vencimento Pagamento
            <input type="date" name="vencimentopagamento" id="vencimentopagamento" value="<%=mensalidadeDao.getObjetoSelecionado().getVencimentoPagamento()== null ? "" : new SimpleDateFormat("yyyy-MM-dd").format(mensalidadeDao.getObjetoSelecionado().getVencimentoPagamento().getTime())%>" size="50"/><br/>
            <br/>Aluguel: 
            <select name="idAluguel" id="idAluguel">
                <%
                  for (Aluguel a : aluguelDao.getLista())  {
                      String selected = "";
                      if (mensalidadeDao.getObjetoSelecionado().getAluguel()!= null){
                        if(mensalidadeDao.getObjetoSelecionado().getAluguel().getId().equals(a.getId())){
                            selected = "selected";
                        }                  
                      }
                %>    
                    <option value="<%=a.getId()%>" <%=selected%> > <%=a.getId()%> </option>
                <%
                  }  
                %>                        
            </select>
            <br/>
            <input type="button" value="Salvar" name="btnSalvar" onclick="doSalvar()"/>
            <input type="button" value="Cancelar" name="btnCancelar" onclick="doCancelar()"/>
            <input type="hidden" name="acao" id="acao" value=""/>
            
        </form>
    </body>
</html>
