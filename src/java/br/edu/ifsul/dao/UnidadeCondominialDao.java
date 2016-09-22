/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.edu.ifsul.dao;

import br.edu.ifsul.jpa.EntityManagerUtil;
import br.edu.ifsul.modelo.UnidadeCondominial;
import br.edu.ifsul.util.Util;
import java.io.Serializable;
import java.util.List;
import java.util.Set;
import javax.persistence.EntityManager;
import javax.validation.ConstraintViolation;
import javax.validation.Validation;
import javax.validation.Validator;

/**
 *
 * @author Felipe
 */
public class UnidadeCondominialDao implements Serializable{
    private UnidadeCondominial objetoSelecionado;
    private String mensagem = "";
    private EntityManager em;

    public UnidadeCondominialDao() {
        em = EntityManagerUtil.getEntityManager();
    }
    
    public boolean validaObjeto(UnidadeCondominial obj){
        Validator validador = Validation.buildDefaultValidatorFactory().getValidator();
        Set<ConstraintViolation<UnidadeCondominial>> erros = validador.validate(obj);
        if(erros.size() > 0){
            mensagem = "";
            mensagem += "Objeto com erros: <br/>";
            for (ConstraintViolation<UnidadeCondominial> erro : erros) {
                mensagem += "Erro: " + erro.getMessage() + "<br/>";
            }
            return false;
        }else{
            return true;
        }
    }
    
    public List<UnidadeCondominial> getLista(){
        return em.createQuery("from UnidadeCondominial order by descricao").getResultList();
    }
    
    public boolean salvar(UnidadeCondominial obj){
        try {
            em.getTransaction().begin();
            if(obj.getId() == null){
                em.persist(obj);
            }else{
                em.merge(obj);
            }
            em.getTransaction().commit();
            mensagem = "Objeto persistido com sucesso!";
            return true;
        } catch (Exception e) {
            if(em.getTransaction().isActive() == false){
                em.getTransaction().begin();
            }
            em.getTransaction().rollback();
            mensagem = "Erro ao persistir objeto: " + Util.getMensagemErro(e);
            return false;
        }
    }
    
    public boolean remover(UnidadeCondominial obj){
        try {
            em.getTransaction().begin();
            em.remove(obj);
            em.getTransaction().commit();
            mensagem = "Objeto excluido com sucesso!";
            return true;
        } catch (Exception e) {
            if(em.getTransaction().isActive() == false){
                em.getTransaction().begin();
            }
            em.getTransaction().rollback();
            mensagem = "Erro ao excluir objeto: " + Util.getMensagemErro(e);
            return false;
        }
    }
    
    public UnidadeCondominial localizar(Integer id){
        return em.find(UnidadeCondominial.class, id);
    }
    
    public UnidadeCondominial getObjetoSelecionado() {
        return objetoSelecionado;
    }

    public void setObjetoSelecionado(UnidadeCondominial objetoSelecionado) {
        this.objetoSelecionado = objetoSelecionado;
    }

    public String getMensagem() {
        return mensagem;
    }

    public void setMensagem(String mensagem) {
        this.mensagem = mensagem;
    }

    public EntityManager getEm() {
        return em;
    }

    public void setEm(EntityManager em) {
        this.em = em;
    }
    
}
