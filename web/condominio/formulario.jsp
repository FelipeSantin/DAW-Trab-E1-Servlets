<%@page import="br.edu.ifsul.modelo.Recurso"%>
<%@page import="br.edu.ifsul.dao.RecursoDao"%>
<%@page import="br.edu.ifsul.dao.CondominioDao"%>
<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<jsp:useBean id="condominioDao" scope="session" type="CondominioDao"/>
<jsp:useBean id="recursoDao" scope="session" type="RecursoDao"/>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>Edição de condominios</title>
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
        <h2>Edição de Condominios</h2>
        <h2><%=condominioDao.getMensagem()%></h2>
        <form name="form" id="form" action="ServletCondominio" method="POST">
            Código
            <input type="text" name="id" id="id" value="<%=condominioDao.getObjetoSelecionado().getId() == null ? "" : condominioDao.getObjetoSelecionado().getId()%>" size="6" readonly/><br/>
            Nome
            <input type="text" name="nome" id="nome" value="<%=condominioDao.getObjetoSelecionado().getNome()== null ? "" : condominioDao.getObjetoSelecionado().getNome()%>" size="50"/><br/>
            Numero
            <input type="text" name="numero" id="numero" value="<%=condominioDao.getObjetoSelecionado().getNumero()== null ? "" : condominioDao.getObjetoSelecionado().getNumero()%>" size="30"/><br/>
            Endereco
            <input type="text" name="endereco" id="endereco" value="<%=condominioDao.getObjetoSelecionado().getEndereco()== null ? "" : condominioDao.getObjetoSelecionado().getEndereco()%>" size="50"/><br/>
            CEP
            <input type="text" name="cep" id="cep" value="<%=condominioDao.getObjetoSelecionado().getCep()== null ? "" : condominioDao.getObjetoSelecionado().getCep()%>" size="50"/><br/>
            <br/>Recurso
            <select name="idRec" id="idRec">
            <%
                for (Recurso r : recursoDao.getLista())  {
                    if (!condominioDao.getObjetoSelecionado().getCond_Rec().isEmpty()){
                        if(!condominioDao.getObjetoSelecionado().getCond_Rec().contains(r)){
            %>                              
                                <option value="<%=r.getId() %>"> <%=r.getDescricao()%> </option>
            <%
                        }                
                    }else{
                        %>                              
                            <option value="<%=r.getId() %>"> <%=r.getDescricao()%> </option>
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
                        <th>Recurso</th>
                        <th>Excluir</th>
                    </tr>
                </thead>
                <tbody>
                    <% 
                    for(Recurso r : condominioDao.getObjetoSelecionado().getCond_Rec()){
                    %>
                    <tr>
                        <td><%=r.getId()%></td>
                        <td><%=r.getDescricao()%></td>
                        <td><a href="ServletCondominio?acao=excluirItem&id=<%=condominioDao.getObjetoSelecionado().getId()%>&idCond=<%=r.getId()%>">Excluir</a></td>
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
