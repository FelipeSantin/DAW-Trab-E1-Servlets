<%@page import="br.edu.ifsul.modelo.Condominio"%>
<%@page import="br.edu.ifsul.dao.CondominioDao"%>
<%@page import="br.edu.ifsul.modelo.UnidadeCondominial"%>
<%@page import="br.edu.ifsul.modelo.Pessoa"%>
<%@page import="br.edu.ifsul.dao.UnidadeCondominialDao"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="br.edu.ifsul.modelo.UnidadeCondominial"%>
<%@page import="br.edu.ifsul.dao.UnidadeCondominialDao"%>
<%@page import="br.edu.ifsul.dao.PessoaDao"%>
<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<jsp:useBean id="unidadeCondominialDao" scope="session" type="UnidadeCondominialDao"/>
<jsp:useBean id="pessoaDao" scope="session" type="PessoaDao"/>
<jsp:useBean id="condominioDao" scope="session" type="CondominioDao"/>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>Edição de unidadeCondominial</title>
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
        <h2>Edição de UnidadeCondominial</h2>
        <h2><%=unidadeCondominialDao.getMensagem()%></h2>
        <form name="form" id="form" action="ServletUnidadeCondominial" method="POST">
            Código
            <input type="text" name="id" id="id" value="<%=unidadeCondominialDao.getObjetoSelecionado().getId() == null ? "" : unidadeCondominialDao.getObjetoSelecionado().getId()%>" size="6" readonly/><br/>
            Numero
            <input type="text" name="numero" id="numero" value="<%=unidadeCondominialDao.getObjetoSelecionado().getNumero()== null ? "" : unidadeCondominialDao.getObjetoSelecionado().getNumero()%>" size="50"/><br/>
            Descricao
            <input type="text" name="descricao" id="descricao" value="<%=unidadeCondominialDao.getObjetoSelecionado().getDescricao()== null ? "" : unidadeCondominialDao.getObjetoSelecionado().getDescricao()%>" size="50"/><br/>
            Area
            <input type="text" name="area" id="area" value="<%=unidadeCondominialDao.getObjetoSelecionado().getArea()== null ? "" :unidadeCondominialDao.getObjetoSelecionado().getArea()%>" size="50"/><br/>
            Numero Quarto
            <input type="text" name="numeroquarto" id="numeroquarto" value="<%=unidadeCondominialDao.getObjetoSelecionado().getNumeroquarto()== null ? "" : unidadeCondominialDao.getObjetoSelecionado().getNumeroquarto()%>" size="6"/><br/>
            <br/>Pessoa
            <select name="idPessoa" id="idPessoa">
                <%
                  for (Pessoa p : pessoaDao.getLista())  {
                      String selected = "";
                      if (unidadeCondominialDao.getObjetoSelecionado().getPessoa()!= null){
                        if(unidadeCondominialDao.getObjetoSelecionado().getPessoa().getId().equals(p.getId())){
                            selected = "selected";
                        }                  
                      }
                %>    
                    <option value="<%=p.getId()%>" <%=selected%> > <%=p.getId()%> </option>
                <%
                  }  
                %>                        
            </select>
            <br/>Condominio
            <select name="idCondominio" id="idCondominio">
                <%
                  for (Condominio c : condominioDao.getLista())  {
                      String selected = "";
                      if (unidadeCondominialDao.getObjetoSelecionado().getCondominio()!= null){
                        if(unidadeCondominialDao.getObjetoSelecionado().getCondominio().getId().equals(c.getId())){
                            selected = "selected";
                        }                  
                      }
                %>    
                    <option value="<%=c.getId()%>" <%=selected%> > <%=c.getId()%> </option>
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
