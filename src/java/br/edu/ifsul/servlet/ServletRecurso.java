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
@WebServlet(name = "SevletRecurso", urlPatterns = {"/recurso/ServletRecurso"})
public class ServletRecurso extends HttpServlet {

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
        RecursoDao dao = (RecursoDao) request.getSession().getAttribute("recursoDao");
        if(dao == null){
            dao = new RecursoDao();
        }
        CondominioDao daoCondominio = (CondominioDao) request.getSession().getAttribute("condominioDao");
        if(daoCondominio == null){
            daoCondominio = new CondominioDao();
        }
        String tela = "";
        String acao = request.getParameter("acao");
        if(acao == null){
            tela = "listar.jsp";
        }else if(acao.equals("incluir")){
            dao.setObjetoSelecionado(new Recurso());
            tela = "formulario.jsp";
        }else if(acao.equals("alterar")){
            Integer id = Integer.parseInt(request.getParameter("id"));
            Recurso obj = dao.localizar(id);
            if(obj != null){
                dao.setObjetoSelecionado(obj);
                dao.setMensagem("");
                tela = "formulario.jsp";
            }
        }else if(acao.equals("excluir")){
            Integer id = Integer.parseInt(request.getParameter("id"));
            Recurso obj = dao.localizar(id);
            if(obj != null){
                dao.remover(obj);
                tela = "listar.jsp";
            }
        }else if(acao.equals("salvar")){
            dao.setObjetoSelecionado(criaRecurso(dao.getObjetoSelecionado(),request));
            if(dao.validaObjeto(dao.getObjetoSelecionado())){
                dao.salvar(dao.getObjetoSelecionado());
                tela = "listar.jsp";
            }else{
                tela = "formulario.jsp";
            }
        }else if(acao.equals("salvarItem")){
            dao.setObjetoSelecionado(criaRecurso(dao.getObjetoSelecionado(),request));
            
            List<Condominio> listCond = dao.getObjetoSelecionado().getCond_Rec();
            try {
                Condominio cond = daoCondominio.localizar(Integer.parseInt(request.getParameter("idCond")));
                listCond.add(cond);
            } catch (Exception e) {
                System.out.println("Erro ao converter condominio");
            }

            dao.getObjetoSelecionado().setCond_Rec(listCond);
            
            if(dao.validaObjeto(dao.getObjetoSelecionado())){
                dao.salvar(dao.getObjetoSelecionado());
            }else{
                try {
                    Condominio cond = daoCondominio.localizar(Integer.parseInt(request.getParameter("idCond")));
                    listCond.remove(cond);
                } catch (Exception e) {
                    System.out.println("Erro ao converter condominio");
                }
            }
            tela = "formulario.jsp";
            
        }else if(acao.equals("excluirItem")){
            
            List<Condominio> listCond = dao.getObjetoSelecionado().getCond_Rec();
            try {
                Condominio cond = daoCondominio.localizar(Integer.parseInt(request.getParameter("idCond")));
                listCond.remove(cond);
            } catch (Exception e) {
                System.out.println("Erro ao converter condominio");
            }

            dao.getObjetoSelecionado().setCond_Rec(listCond);
            
            if(dao.validaObjeto(dao.getObjetoSelecionado())){
                dao.salvar(dao.getObjetoSelecionado());
            }
            tela = "formulario.jsp";
        }else if(acao.equals("cancelar")){
            tela = "listar.jsp";
            dao.setMensagem("");
        }
        request.getSession().setAttribute("recursoDao", dao);
        request.getSession().setAttribute("condominioDao", daoCondominio);
        response.sendRedirect(tela);
    }

    public Recurso criaRecurso(Recurso r, HttpServletRequest request){
        Integer id = null;
        try {
            id = Integer.parseInt(request.getParameter("id"));
        } catch (Exception e) {
            System.out.println("Erro ao converter");
        }
        Recurso obj;
        if(id == null){
            obj = new Recurso();
        }else{
            obj = r;
        }
        obj.setId(id);
        obj.setDescricao(request.getParameter("descricao"));
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
