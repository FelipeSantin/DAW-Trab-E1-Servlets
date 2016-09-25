<%@page import="br.edu.ifsul.dao.CondominioDao"%>
<%@page import="br.edu.ifsul.modelo.Condominio"%>
<%@page import="br.edu.ifsul.dao.RecursoDao"%>
<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<jsp:useBean id="recursoDao" scope="session" type="RecursoDao"/>
<jsp:useBean id="condominioDao" scope="session" type="CondominioDao"/>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>Edição de recursos</title>
        <script>
            function doSalvar(){
                document.getElementById("acao").value = 'salvar';
                document.getElementById("form").submit();
            }
            function doSalvarItem(){
                document.getElementById("acao").value = 'salvarItem';
                document.getElementById("form").submit();
            }
            function doCancelar(){
                document.getElementById("acao").value = 'cancelar';
                document.getElementById("form").submit();
            }
        </script>
    </head>
    <body>
        <h2>Edição de Recursos</h2>
        <h2><%=recursoDao.getMensagem()%></h2>
        <form name="form" id="form" action="ServletRecurso" method="POST">
            Código
            <input type="text" name="id" id="id" value="<%=recursoDao.getObjetoSelecionado().getId() == null ? "" : recursoDao.getObjetoSelecionado().getId()%>" size="6" readonly/><br/>
            Descrição
            <input type="text" name="descricao" id="descricao" value="<%=recursoDao.getObjetoSelecionado().getDescricao()== null ? "" : recursoDao.getObjetoSelecionado().getDescricao()%>" size="50"/><br/>
            <br/>Condominio
            <select name="idCond" id="idCond">
            <%
                for (Condominio c : condominioDao.getLista())  {
                    if (!recursoDao.getObjetoSelecionado().getCond_Rec().isEmpty()){
                        if(!recursoDao.getObjetoSelecionado().getCond_Rec().contains(c)){
            %>                              
                                <option value="<%=c.getId() %>"> <%=c.getNome()%> </option>
            <%
                        }                  
                    }else{
                        %>                              
                            <option value="<%=c.getId() %>"> <%=c.getNome()%> </option>
                        <%
                    }
                }  
            %>                        
            </select>
            <input type="button" value="Salvar Item" name="btnSalvarItem" onclick="doSalvarItem()"/>
             <table border="1">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Condominio</th>
                        <th>Excluir</th>
                    </tr>
                </thead>
                <tbody>
                    <% 
                    for(Condominio c : recursoDao.getObjetoSelecionado().getCond_Rec()){
                    %>
                    <tr>
                        <td><%=c.getId()%></td>
                        <td><%=c.getNome()%></td>
                        <td><a href="ServletRecurso?acao=excluirItem&id=<%=recursoDao.getObjetoSelecionado().getId()%>&idCond=<%=c.getId()%>">Excluir</a></td>
                    </tr>
                    <%
                    }
                    %>
                </tbody>
            </table>
            <br>
            <input type="button" value="Salvar" name="btnSalvar" onclick="doSalvar()"/>
            <input type="button" value="Cancelar" name="btnCancelar" onclick="doCancelar()"/>
            <input type="hidden" name="acao" id="acao" value=""/>
            
        </form>
    </body>
</html>
