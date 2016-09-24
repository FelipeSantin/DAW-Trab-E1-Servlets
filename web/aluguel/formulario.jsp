<%@page import="br.edu.ifsul.modelo.UnidadeCondominial"%>
<%@page import="br.edu.ifsul.modelo.Locatario"%>
<%@page import="br.edu.ifsul.dao.UnidadeCondominialDao"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="br.edu.ifsul.modelo.Aluguel"%>
<%@page import="br.edu.ifsul.dao.AluguelDao"%>
<%@page import="br.edu.ifsul.dao.LocatarioDao"%>
<%@page contentType="text/html" pageEncoding="ISO-8859-1"%>
<jsp:useBean id="aluguelDao" scope="session" type="AluguelDao"/>
<jsp:useBean id="locatarioDao" scope="session" type="LocatarioDao"/>
<jsp:useBean id="unidadeCondominialDao" scope="session" type="UnidadeCondominialDao"/>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <title>Edição de aluguel</title>
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
        <h2>Edição de Aluguel</h2>
        <h2><%=aluguelDao.getMensagem()%></h2>
        <form name="form" id="form" action="ServletAluguel" method="POST">
            Código
            <input type="text" name="id" id="id" value="<%=aluguelDao.getObjetoSelecionado().getId() == null ? "" : aluguelDao.getObjetoSelecionado().getId()%>" size="6" readonly/><br/>
            Valor
            <input type="text" name="valor" id="valor" value="<%=aluguelDao.getObjetoSelecionado().getValor()== null ? "" : aluguelDao.getObjetoSelecionado().getValor()%>" size="50"/><br/>
            Inicio Contrato
            <input type="date" name="iniciocontrato" id="iniciocontrato" value="<%=aluguelDao.getObjetoSelecionado().getInicioContrato()== null ? "" : new SimpleDateFormat("yyyy-MM-dd").format(aluguelDao.getObjetoSelecionado().getInicioContrato().getTime())%>" size="50"/><br/>
            Fim Contrato
            <input type="date" name="fimcontrato" id="fimcontrato" value="<%=aluguelDao.getObjetoSelecionado().getFimContrato()== null ? "" : new SimpleDateFormat("yyyy-MM-dd").format(aluguelDao.getObjetoSelecionado().getFimContrato().getTime())%>" size="50"/><br/>
            Dia Vencimento
            <input type="text" name="diavencimento" id="diavencimento" value="<%=aluguelDao.getObjetoSelecionado().getDiaVencimento()== null ? "" : aluguelDao.getObjetoSelecionado().getDiaVencimento()%>" size="6"/><br/>
            <br/>Locatario
            <select name="idLocatario" id="idLocatario">
                <%
                  for (Locatario l : locatarioDao.getLista())  {
                      String selected = "";
                      if (aluguelDao.getObjetoSelecionado().getLocatario()!= null){
                        if(aluguelDao.getObjetoSelecionado().getLocatario().getId().equals(l.getId())){
                            selected = "selected";
                        }                  
                      }
                %>    
                    <option value="<%=l.getId()%>" <%=selected%> > <%=l.getId()%> </option>
                <%
                  }  
                %>                        
            </select>
            <br/>Unidade Condominial
            <select name="idUnidadeCond" id="idUnidadeCond">
                <%
                  for (UnidadeCondominial uc : unidadeCondominialDao.getLista())  {
                      String selected = "";
                      if (aluguelDao.getObjetoSelecionado().getUnidadeCond()!= null){
                        if(aluguelDao.getObjetoSelecionado().getUnidadeCond().getId().equals(uc.getId())){
                            selected = "selected";
                        }                  
                      }
                %>    
                    <option value="<%=uc.getId()%>" <%=selected%> > <%=uc.getId()%> </option>
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
