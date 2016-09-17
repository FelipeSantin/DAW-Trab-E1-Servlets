<%-- 
    Document   : formulario
    Created on : 17/09/2016, 18:22:16
    Author     : Felipe
--%>

<%@page import="br.edu.ifsul.dao.LocatarioDao"%>
<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<jsp:useBean id="locatarioDao" scope="session" type="LocatarioDao"/>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>Edição de locatarios</title>
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
        <h2>Edição de Locatarios</h2>
        <h2><%=locatarioDao.getMensagem()%></h2>
        <form name="form" id="form" action="ServletLocatario" method="POST">
            Código
            <input type="text" name="id" id="id" value="<%=locatarioDao.getObjetoSelecionado().getId() == null ? "" : locatarioDao.getObjetoSelecionado().getId()%>" size="6" readonly/><br/>
            Nome
            <input type="text" name="nome" id="nome" value="<%=locatarioDao.getObjetoSelecionado().getNome()== null ? "" : locatarioDao.getObjetoSelecionado().getNome()%>" size="50"/><br/>
            CPF
            <input type="text" name="cpf" id="cpf" value="<%=locatarioDao.getObjetoSelecionado().getCpf()== null ? "" : locatarioDao.getObjetoSelecionado().getCpf()%>" size="14"/><br/>
            Email
            <input type="email" name="email" id="email" value="<%=locatarioDao.getObjetoSelecionado().getEmail()== null ? "" : locatarioDao.getObjetoSelecionado().getEmail()%>" size="50"/><br/>
            Telefone
            <input type="tel" name="telefone" id="telefone" value="<%=locatarioDao.getObjetoSelecionado().getTelefone()== null ? "" : locatarioDao.getObjetoSelecionado().getTelefone()%>" size="50"/><br/>
            Local Trabalho
            <input type="text" name="localtrabalho" id="localtrabalho" value="<%=locatarioDao.getObjetoSelecionado().getLocaltrabalho()== null ? "" : locatarioDao.getObjetoSelecionado().getLocaltrabalho()%>" size="50"/><br/>
            Telefone Trabalho
            <input type="text" name="telefonetrabalho" id="telefonetrabalho" value="<%=locatarioDao.getObjetoSelecionado().getTelefonetrabalho()== null ? "" : locatarioDao.getObjetoSelecionado().getTelefonetrabalho()%>" size="50"/><br/>
            Renda
            <input type="text" name="renda" id="renda" value="<%=locatarioDao.getObjetoSelecionado().getRenda()== null ? "" : locatarioDao.getObjetoSelecionado().getRenda()%>" size="50"/><br/>
            <input type="button" value="Salvar" name="btnSalvar" onclick="doSalvar()"/>
            <input type="button" value="Cancelar" name="btnCancelar" onclick="doCancelar()"/>
            <input type="hidden" name="acao" id="acao" value=""/>
            
        </form>
    </body>
</html>
