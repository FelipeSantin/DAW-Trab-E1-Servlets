package br.edu.ifsul.servlet;

import br.edu.ifsul.dao.AluguelDao;
import br.edu.ifsul.dao.LocatarioDao;
import br.edu.ifsul.dao.UnidadeCondominialDao;
import br.edu.ifsul.modelo.Aluguel;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.TimeZone;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Felipe
 */
@WebServlet(name = "SevletAluguel", urlPatterns = {"/aluguel/ServletAluguel"})
public class ServletAluguel extends HttpServlet {

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
        AluguelDao dao = (AluguelDao) request.getSession().getAttribute("aluguelDao");
        if(dao == null){
            dao = new AluguelDao();
        }
        LocatarioDao daoLocatario = (LocatarioDao) request.getSession().getAttribute("locatarioDao");
        if (daoLocatario == null){
            daoLocatario = new LocatarioDao();
        }
        UnidadeCondominialDao daoUnidadeCondominial = (UnidadeCondominialDao) request.getSession().getAttribute("unicadeCondominialDao");
        if (daoUnidadeCondominial == null){
            daoUnidadeCondominial = new UnidadeCondominialDao();
        }
        String tela = "";
        String acao = request.getParameter("acao");
        if(acao == null){
            tela = "listar.jsp";
        }else if(acao.equals("incluir")){
            dao.setObjetoSelecionado(new Aluguel());
            tela = "formulario.jsp";
        }else if(acao.equals("alterar")){
            Integer id = Integer.parseInt(request.getParameter("id"));
            Aluguel obj = dao.localizar(id);
            if(obj != null){
                dao.setObjetoSelecionado(obj);
                dao.setMensagem("");
                tela = "formulario.jsp";
            }
        }else if(acao.equals("excluir")){
            Integer id = Integer.parseInt(request.getParameter("id"));
            Aluguel obj = dao.localizar(id);
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
            try {
                dao.getObjetoSelecionado().setValor(Double.parseDouble(request.getParameter("valor")));
            } catch (Exception e) {
                dao.getObjetoSelecionado().setValor(null);
            }
            
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            sdf.setTimeZone(TimeZone.getTimeZone("America/Sao_Paulo"));
       
            Calendar data = Calendar.getInstance();
            
            try{
                data.setTime(sdf.parse(request.getParameter("iniciocontrato")));
            }catch(Exception e){
                System.out.println("Erro ao converter data");
                e.printStackTrace();
            }
            dao.getObjetoSelecionado().setInicioContrato(data);
            
            data = Calendar.getInstance();
            try{
                data.setTime(sdf.parse(request.getParameter("fimcontrato")));
            }catch(Exception e){
                System.out.println("Erro ao converter data");
            }
            dao.getObjetoSelecionado().setFimContrato(data);
            
            try {
                dao.getObjetoSelecionado().setDiaVencimento(Integer.parseInt(request.getParameter("diavencimento")));
            } catch (Exception e) {
                System.out.println("Erro ao converter dia");
                dao.getObjetoSelecionado().setDiaVencimento(null);
            }
            
            Integer idLocatario = null;
            try {
                idLocatario = Integer.parseInt(request.getParameter("idLocatario"));
            } catch (Exception e){
                System.out.println("Erro ao converter o id do Locatario");
            }
            
            dao.getObjetoSelecionado().setLocatario(daoLocatario.localizar(idLocatario));
            
            Integer idUnidadeCond = null;
            try {
                idUnidadeCond = Integer.parseInt(request.getParameter("idUnidadeCond"));
            } catch (Exception e){
                System.out.println("Erro ao converter o id do UnidadeCond");
            }
            
            dao.getObjetoSelecionado().setUnidadeCond(daoUnidadeCondominial.localizar(idUnidadeCond));
            
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
        request.getSession().setAttribute("aluguelDao", dao);
        request.getSession().setAttribute("locatarioDao", daoLocatario);
        request.getSession().setAttribute("unidadeCondominialDao", daoUnidadeCondominial);
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
