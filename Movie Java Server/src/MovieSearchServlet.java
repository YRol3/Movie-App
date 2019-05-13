import org.json.JSONObject;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;


public class MovieSearchServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setHeader("Content-Type", "text/html; charset=utf-8");

        response.setCharacterEncoding("UTF-8");
        String filmID = null;
        boolean error = true;
        if((filmID = request.getParameter("filmID")) != null) {
            String fullJson =  HttpGet.getJsonFromHTMLFile(String.format("%s%s%s", FinalsClass.BASE_URL , FinalsClass.FILMS_PATH, filmID), "var filmDetails = ");
            System.out.println(fullJson);
            JSONObject jsonObject;
            if(ModedRequest.getParameterValues(request, "filter") != null){
                jsonObject = HttpGet.filterResponseJson(new JSONObject(fullJson),null, ModedRequest.getParameterValues(request, "filter"));
            }else{
                jsonObject = new JSONObject(fullJson);
            }
            if(!jsonObject.isEmpty()) {
                response.getWriter().write(jsonObject.toString());
                error = false;

            }
        }
        if(error){
            RequestDispatcher view = request.getRequestDispatcher("Error/error.html");
            response.setHeader("error", "Invalid request parameters");
            view.forward(request, response);
        }
    }
}
