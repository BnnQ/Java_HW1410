package me.bnnq.homework;

import java.io.*;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import me.bnnq.homework.utils.Views;

@WebServlet(name = "textAnalyser", value = "/text-analyser")
public class TextAnalyserServlet extends HttpServlet
{
    @Override
    public void init()
    {

    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException
    {
        Views.get(getServletContext(), "textAnalyser", request, response);
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException
    {
        String text = request.getParameter("text");
        String vowelsLower = "aeiouy";
        String vowels = vowelsLower + vowelsLower.toUpperCase();

        String consonantsLower = "bcdfghjklmnpqrstvwxz";
        String consonants = consonantsLower + consonantsLower.toUpperCase();

        Character[] listOfVowelsInText = text.chars().filter(c -> vowels.indexOf(c) != -1).mapToObj(c -> (char) c).toArray(Character[]::new);
        Character[] listOfConsonantsInText = text.chars().filter(c -> consonants.indexOf(c) != -1).mapToObj(c -> (char) c).toArray(Character[]::new);
        Character[] listOfPunctuationMarksInText = text.chars().filter(c -> ",.!?:;".indexOf(c) != -1).mapToObj(c -> (char) c).toArray(Character[]::new);

        request.setAttribute("text", text);
        request.setAttribute("listOfVowels", listOfVowelsInText);
        request.setAttribute("listOfConsonants", listOfConsonantsInText);
        request.setAttribute("listOfPunctuationMarks", listOfPunctuationMarksInText);

        Views.get(getServletContext(), "textAnalyser", request, response);
    }

    public void destroy()
    {

    }
}