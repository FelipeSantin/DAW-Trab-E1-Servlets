<%@page import="br.edu.ifsul.dao.PessoaDao"%>
<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<jsp:useBean id="pessoaDao" scope="session" type="PessoaDao"/>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>Edição de pessoas</title>
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
        <h2>Edição de Pessoas</h2>
        <h2><%=pessoaDao.getMensagem()%></h2>
        <form name="form" id="form" action="ServletPessoa" method="POST">
            Código
            <input type="text" name="id" id="id" value="<%=pessoaDao.getObjetoSelecionado().getId() == null ? "" : pessoaDao.getObjetoSelecionado().getId()%>" size="6" readonly/><br/>
            Nome
            <input type="text" name="nome" id="nome" value="<%=pessoaDao.getObjetoSelecionado().getNome()== null ? "" : pessoaDao.getObjetoSelecionado().getNome()%>" size="50"/><br/>
            CPF
            <input type="text" name="cpf" id="cpf" value="<%=pessoaDao.getObjetoSelecionado().getCpf()== null ? "" : pessoaDao.getObjetoSelecionado().getCpf()%>" size="14"/><br/>
            Email
            <input type="email" name="email" id="email" value="<%=pessoaDao.getObjetoSelecionado().getEmail()== null ? "" : pessoaDao.getObjetoSelecionado().getEmail()%>" size="50"/><br/>
            Telefone
            <input type="tel" name="telefone" id="telefone" value="<%=pessoaDao.getObjetoSelecionado().getTelefone()== null ? "" : pessoaDao.getObjetoSelecionado().getTelefone()%>" size="50"/><br/>
            <input type="button" value="Salvar" name="btnSalvar" onclick="doSalvar()"/>
            <input type="button" value="Cancelar" name="btnCancelar" onclick="doCancelar()"/>
            <input type="hidden" name="acao" id="acao" value=""/>
            
        </form>
    </body>
</html>
