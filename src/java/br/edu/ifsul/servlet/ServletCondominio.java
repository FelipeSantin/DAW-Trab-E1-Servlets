package br.edu.ifsul.servlet;

import br.edu.ifsul.dao.CondominioDao;
import br.edu.ifsul.dao.RecursoDao;
import br.edu.ifsul.modelo.Condominio;
import br.edu.ifsul.modelo.Recurso;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Felipe
 */
@WebServlet(name = "SevletCondominio", urlPatterns = {"/condominio/ServletCondominio"})
public class ServletCondominio extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        CondominioDao dao = (CondominioDao) request.getSession().getAttribute("condominioDao");
        if(dao == null){
            dao = new CondominioDao();
        }
        RecursoDao daoRecurso = (RecursoDao) request.getSession().getAttribute("recursoDao");
        if(daoRecurso == null){
            daoRecurso = new RecursoDao();
        }
        String tela = "";
        String acao = request.getParameter("acao");
        if(acao == null){
            tela = "listar.jsp";
        }else if(acao.equals("incluir")){
            dao.setObjetoSelecionado(new Condominio());
            tela = "formulario.jsp";
        }else if(acao.equals("alterar")){
            Integer id = Integer.parseInt(request.getParameter("id"));
            Condominio obj = dao.localizar(id);
            if(obj != null){
                dao.setObjetoSelecionado(obj);
                dao.setMensagem("");
                tela = "formulario.jsp";
            }
        }else if(acao.equals("excluir")){
            Integer id = Integer.parseInt(request.getParameter("id"));
            Condominio obj = dao.localizar(id);
            if(obj != null){
                dao.remover(obj);
                tela = "listar.jsp";
            }
        }else if(acao.equals("salvar")){
            dao.setObjetoSelecionado(criaCondominio(request));
            if(dao.validaObjeto(dao.getObjetoSelecionado())){
                dao.salvar(dao.getObjetoSelecionado());
                tela = "listar.jsp";
            }else{
                tela = "formulario.jsp";
            }
        }else if(acao.equals("salvarItem")){
            if(dao.getObjetoSelecionado().getId() == 0){
                dao.setObjetoSelecionado(criaCondominio(request));
            }
            List<Recurso> listRec = dao.getObjetoSelecionado().getCond_Rec();
            try {
                Recurso r = daoRecurso.localizar(Integer.parseInt(request.getParameter("idRec")));
                listRec.add(r);
            } catch (Exception e) {
                System.out.println("Erro ao converter condominio");
            }

            dao.getObjetoSelecionado().setCond_Rec(listRec);
            
            if(dao.validaObjeto(dao.getObjetoSelecionado())){
                dao.salvar(dao.getObjetoSelecionado());
            }
            tela = "formulario.jsp";
            
        }else if(acao.equals("excluirItem")){
            
            List<Recurso> listRec = dao.getObjetoSelecionado().getCond_Rec();
            try {
                Recurso rec = daoRecurso.localizar(Integer.parseInt(request.getParameter("idCond")));
                listRec.remove(rec);
            } catch (Exception e) {
                System.out.println("Erro ao converter condominio");
            }

            dao.getObjetoSelecionado().setCond_Rec(listRec);
            
            if(dao.validaObjeto(dao.getObjetoSelecionado())){
                dao.salvar(dao.getObjetoSelecionado());
            }
            tela = "formulario.jsp";
        }else if(acao.equals("cancelar")){
            tela = "listar.jsp";
            dao.setMensagem("");
        }
        request.getSession().setAttribute("condominioDao", dao);
        request.getSession().setAttribute("recursoDao", daoRecurso);
        response.sendRedirect(tela);
    }
    private Condominio criaCondominio(HttpServletRequest request){
        Integer id = null;
        try {
            id = Integer.parseInt(request.getParameter("id"));
        } catch (Exception e) {
            System.out.println("Erro ao converter");
        }
        Condominio obj = new Condominio();
        obj.setId(id);
        obj.setNome(request.getParameter("nome"));
        obj.setNumero(request.getParameter("numero"));
        obj.setEndereco(request.getParameter("endereco"));
        obj.setCep(request.getParameter("cep"));
        
        return obj;
    }
    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
