package br.edu.ifsul.servlet;

import br.edu.ifsul.dao.AluguelDao;
import br.edu.ifsul.dao.MensalidadeDao;
import br.edu.ifsul.modelo.Mensalidade;
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
@WebServlet(name = "SevletMensalidade", urlPatterns = {"/mensalidade/ServletMensalidade"})
public class ServletMensalidade extends HttpServlet {

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
        MensalidadeDao dao = (MensalidadeDao) request.getSession().getAttribute("mensalidadeDao");
        if(dao == null){
            dao = new MensalidadeDao();
        }
        AluguelDao daoAluguel = (AluguelDao) request.getSession().getAttribute("aluguelDao");
        if (daoAluguel == null){
            daoAluguel = new AluguelDao();
        }
        String tela = "";
        String acao = request.getParameter("acao");
        if(acao == null){
            tela = "listar.jsp";
        }else if(acao.equals("incluir")){
            dao.setObjetoSelecionado(new Mensalidade());
            tela = "formulario.jsp";
        }else if(acao.equals("alterar")){
            Integer id = Integer.parseInt(request.getParameter("id"));
            Mensalidade obj = dao.localizar(id);
            if(obj != null){
                dao.setObjetoSelecionado(obj);
                dao.setMensagem("");
                tela = "formulario.jsp";
            }
        }else if(acao.equals("excluir")){
            Integer id = Integer.parseInt(request.getParameter("id"));
            Mensalidade obj = dao.localizar(id);
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
            
            dao.getObjetoSelecionado().setId(id);
            dao.getObjetoSelecionado().setValor(Double.parseDouble(request.getParameter("valor")));
            dao.getObjetoSelecionado().setValorPagamento(Double.parseDouble(request.getParameter("valorpagamento")));
            
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            sdf.setTimeZone(TimeZone.getTimeZone("America/Sao_Paulo"));
       
            Calendar data = Calendar.getInstance();
            
            try{
                data.setTime(sdf.parse(request.getParameter("vencimento")));
            }catch(Exception e){
                System.out.println("Erro ao converter data");
                e.printStackTrace();
            }
            dao.getObjetoSelecionado().setVencimento(data);
            
            data = Calendar.getInstance();
            try{
                data.setTime(sdf.parse(request.getParameter("vencimentopagamento")));
            }catch(Exception e){
                System.out.println("Erro ao converter data");
            }
            dao.getObjetoSelecionado().setVencimentoPagamento(data);
            
            Integer idAluguel = null;
            try {
                idAluguel = Integer.parseInt(request.getParameter("idAluguel"));
            } catch (Exception e){
                System.out.println("Erro ao converter o id do Aluguel");
            }
            
            dao.getObjetoSelecionado().setAluguel(daoAluguel.localizar(idAluguel));
            
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
        request.getSession().setAttribute("mensalidadeDao", dao);
        request.getSession().setAttribute("aluguelDao", daoAluguel);
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
