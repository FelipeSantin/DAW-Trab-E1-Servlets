package br.edu.ifsul.servlet;

import br.edu.ifsul.dao.LocatarioDao;
import br.edu.ifsul.modelo.Locatario;
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
@WebServlet(name = "SevletLocatario", urlPatterns = {"/locatario/ServletLocatario"})
public class ServletLocatario extends HttpServlet {

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
        LocatarioDao dao = (LocatarioDao) request.getSession().getAttribute("locatarioDao");
        if(dao == null){
            dao = new LocatarioDao();
        }
        String tela = "";
        String acao = request.getParameter("acao");
        if(acao == null){
            tela = "listar.jsp";
        }else if(acao.equals("incluir")){
            dao.setObjetoSelecionado(new Locatario());
            tela = "formulario.jsp";
        }else if(acao.equals("alterar")){
            Integer id = Integer.parseInt(request.getParameter("id"));
            Locatario obj = dao.localizar(id);
            if(obj != null){
                dao.setObjetoSelecionado(obj);
                dao.setMensagem("");
                tela = "formulario.jsp";
            }
        }else if(acao.equals("excluir")){
            Integer id = Integer.parseInt(request.getParameter("id"));
            Locatario obj = dao.localizar(id);
            if(obj != null){
                dao.remover(obj);
                tela = "listar.jsp";
            }
        }else if(acao.equals("salvar")){
            Integer id = null;
            try {
                id = Integer.parseInt(request.getParameter("id"));
            } catch (Exception e) {
                System.out.println("Erro ao converter");
            }
            Locatario obj = new Locatario();
            obj.setId(id);
            obj.setNome(request.getParameter("nome"));
            obj.setCpf(request.getParameter("cpf"));
            obj.setEmail(request.getParameter("email"));
            obj.setTelefone(request.getParameter("telefone"));
            obj.setLocaltrabalho(request.getParameter("localtrabalho"));
            obj.setTelefonetrabalho(request.getParameter("telefonetrabalho"));
            obj.setTelefone(request.getParameter("telefone"));
            obj.setRenda(Double.parseDouble(request.getParameter("renda")));
            dao.setObjetoSelecionado(obj);
            if(dao.validaObjeto(obj)){
                dao.salvar(obj);
                tela = "listar.jsp";
            }else{
                tela = "formulario.jsp";
            }
        }else if(acao.equals("cancelar")){
            tela = "listar.jsp";
            dao.setMensagem("");
        }
        request.getSession().setAttribute("locatarioDao", dao);
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
