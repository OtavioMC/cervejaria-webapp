package br.cefetrj.servlet;

import java.io.IOException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/PostmanServlet")
public class PostmanServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        response.setContentType("application/json");
        response.getWriter().write("{\"message\": \"Entrou no doGet do PostmanServlet!\"}");

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        response.setContentType("application/json");
        response.getWriter().write("{\"message\": \"Entrou no doPost do PostmanServlet!\"}");
        System.out.println("Entrou no doPost do PostmanServlet");
    }

    @Override
    protected void doPut(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        response.setContentType("application/json");
        response.getWriter().write("{\"message\": \"Entrou no doPut do PostmanServlet!\"}");
        System.out.println("Entrou no doPut do PostmanServlet");
    }

    @Override
    protected void doDelete(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        response.setContentType("application/json");
        response.getWriter().write("{\"message\": \"Entrou no doDelete do PostmanServlet!\"}");
        System.out.println("Entrou no doDelete do PostmanServlet");
    }
}
