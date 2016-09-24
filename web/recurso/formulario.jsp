<%@page import="br.edu.ifsul.dao.RecursoDao"%>
<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<jsp:useBean id="recursoDao" scope="session" type="RecursoDao"/>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>Edi��o de recursos</title>
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
        <h2>Edi��o de Recursos</h2>
        <h2><%=recursoDao.getMensagem()%></h2>
        <form name="form" id="form" action="ServletRecurso" method="POST">
            C�digo
            <input type="text" name="id" id="id" value="<%=recursoDao.getObjetoSelecionado().getId() == null ? "" : recursoDao.getObjetoSelecionado().getId()%>" size="6" readonly/><br/>
            Descri��o
            <input type="text" name="descricao" id="descricao" value="<%=recursoDao.getObjetoSelecionado().getDescricao()== null ? "" : recursoDao.getObjetoSelecionado().getDescricao()%>" size="50"/><br/>
            <input type="button" value="Salvar" name="btnSalvar" onclick="doSalvar()"/>
            <input type="button" value="Cancelar" name="btnCancelar" onclick="doCancelar()"/>
            <input type="hidden" name="acao" id="acao" value=""/>
            
        </form>
    </body>
</html>
