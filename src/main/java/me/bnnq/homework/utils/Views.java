package me.bnnq.homework.utils;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

public class Views
{
    public static void get(ServletContext context, String path, HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException, ServletException, IOException
    {
        context.getRequestDispatcher("/" + path + ".jsp").forward(request, response);
    }
}
