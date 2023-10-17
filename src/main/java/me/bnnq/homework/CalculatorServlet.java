package me.bnnq.homework;

import java.io.*;
import java.text.DecimalFormat;
import java.text.DecimalFormatSymbols;
import java.util.Locale;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import me.bnnq.homework.utils.Views;
import org.mariuszgromada.math.mxparser.Expression;
import org.mariuszgromada.math.mxparser.License;

import javax.script.ScriptEngine;
import javax.script.ScriptEngineManager;
import javax.script.ScriptException;

@WebServlet(name = "calculatorServlet", value = "/calculator")
public class CalculatorServlet extends HttpServlet
{
    @Override
    public void init()
    {

    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException
    {
        Views.get(getServletContext(), "calculator", request, response);
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException
    {
        if (!License.checkIfUseTypeConfirmed())
            License.iConfirmNonCommercialUse("@bnnq");

        Expression expression = new Expression(request.getParameter("expression"));
        double result = expression.calculate();
        var symbolFormatStyle = new DecimalFormatSymbols(Locale.US);
        var formatter = new DecimalFormat("0.############", symbolFormatStyle);
        request.setAttribute("result", formatter.format(result));

        Views.get(getServletContext(), "calculator", request, response);
    }

    public void destroy()
    {

    }
}