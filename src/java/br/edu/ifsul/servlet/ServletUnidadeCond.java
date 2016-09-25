package br.edu.ifsul.servlet;

import br.edu.ifsul.dao.CondominioDao;
import br.edu.ifsul.dao.PessoaDao;
import br.edu.ifsul.dao.UnidadeCondominialDao;
import br.edu.ifsul.modelo.UnidadeCondominial;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Felipe
 */
@WebServlet(name = "SevletUnidadeCondominial", urlPatterns = {"/unidadeCondominial/ServletUnidadeCondominial"})
public class ServletUnidadeCond extends HttpServlet {

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
        UnidadeCondominialDao dao = (UnidadeCondominialDao) request.getSession().getAttribute("unidadeCondominialDao");
        if(dao == null){
            dao = new UnidadeCondominialDao();
        }
        PessoaDao daoPessoa = (PessoaDao) request.getSession().getAttribute("pessoaDao");
        if (daoPessoa == null){
            daoPessoa = new PessoaDao();
        }
        CondominioDao daoCondominio = (CondominioDao) request.getSession().getAttribute("condominioDao");
        if (daoCondominio == null){
            daoCondominio = new CondominioDao();
        }
        String tela = "";
        String acao = request.getParameter("acao");
        if(acao == null){
            tela = "listar.jsp";
        }else if(acao.equals("incluir")){
            dao.setObjetoSelecionado(new UnidadeCondominial());
            tela = "formulario.jsp";
        }else if(acao.equals("alterar")){
            Integer id = Integer.parseInt(request.getParameter("id"));
            UnidadeCondominial obj = dao.localizar(id);
            if(obj != null){
                dao.setObjetoSelecionado(obj);
                dao.setMensagem("");
                tela = "formulario.jsp";
            }
        }else if(acao.equals("excluir")){
            Integer id = Integer.parseInt(request.getParameter("id"));
            UnidadeCondominial obj = dao.localizar(id);
            if(obj != null){
                dao.remover(obj);
                tela = "listar.jsp";
            }
        }else if(acao.equals("salvar")){
            Integer id = null;
            try {
                id = Integer.parseInt(request.getParameter("id"));
            } catch (Exception e) {
                System.out.println("Erro ao converter id");
            }
            
            dao.getObjetoSelecionado().setId(id);
            dao.getObjetoSelecionado().setNumero(request.getParameter("numero"));
            
            dao.getObjetoSelecionado().setDescricao(request.getParameter("descricao"));
            try {
                dao.getObjetoSelecionado().setArea(Double.parseDouble(request.getParameter("area")));
            } catch (Exception e) {
                dao.getObjetoSelecionado().setArea(null);
            }
            
            
            try {
                dao.getObjetoSelecionado().setNumeroquarto(Integer.parseInt(request.getParameter("numeroquarto")));
            } catch (Exception e) {
                System.out.println("Erro ao converter numero quarto");
                dao.getObjetoSelecionado().setNumeroquarto(null);
            }
            
            Integer idPessoa = null;
            try {
                idPessoa = Integer.parseInt(request.getParameter("idPessoa"));
            } catch (Exception e){
                System.out.println("Erro ao converter o id do Pessoa");
            }
            
            dao.getObjetoSelecionado().setPessoa(daoPessoa.localizar(idPessoa));
            
            Integer idCondominio = null;
            try {
                idCondominio = Integer.parseInt(request.getParameter("idCondominio"));
            } catch (Exception e){
                System.out.println("Erro ao converter o id do UnidadeCond");
            }
            
            dao.getObjetoSelecionado().setCondominio(daoCondominio.localizar(idCondominio));
            
            if(dao.validaObjeto(dao.getObjetoSelecionado())){
                dao.salvar(dao.getObjetoSelecionado());
                tela = "listar.jsp";
            }else{
                tela = "formulario.jsp";
            }
        }else if(acao.equals("cancelar")){
            tela = "listar.jsp";
            dao.setMensagem("");
        }
        request.getSession().setAttribute("unidadeCondominialDao", dao);
        request.getSession().setAttribute("pessoaDao", daoPessoa);
        request.getSession().setAttribute("condominioDao", daoCondominio);
        response.sendRedirect(tela);
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
