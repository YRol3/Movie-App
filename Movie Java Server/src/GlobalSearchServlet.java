
import org.json.JSONObject;


import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;


public class GlobalSearchServlet extends javax.servlet.http.HttpServlet {


    @Override
    public void init() throws ServletException {
        super.init();

    }

    protected void doPost(javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response) throws javax.servlet.ServletException, IOException {

    }


    protected void doGet(javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response) throws javax.servlet.ServletException, IOException {
        response.setHeader("Content-Type", "text/html; charset=utf-8");
        response.setCharacterEncoding("UTF-8");
        List<String> clientRequest = ModedRequest.getParameterValues(request, "request");
        String atDate;
        String errorReason = null;
        boolean error = false;
        if ((clientRequest != null && (atDate = request.getParameter("atDate")) != null)) {
            try {
                Date limitDay = new Date(System.currentTimeMillis() + FinalsClass.ONE_DAY_IN_MILLIS * FinalsClass.MAX_DAYS);
                Date requestDate = new SimpleDateFormat("yyyy-MM-dd").parse(atDate);
                if(requestDate.getTime() > limitDay.getTime()) {
                    errorReason = "Invalid date, <p> try format yyyy-mm-dd</p> <p>you can search up to 3 days from the current day</p>";
                    error = true;
                }
            } catch (ParseException e) {
                e.printStackTrace();
            }
            if(!error) {
                List<String> filterRequest = ModedRequest.getParameterValues(request, "filter");
                String responseGet = HttpGet.requestWithParams(atDate, clientRequest, filterRequest, jsonObject -> jsonObject.getJSONObject("body"));
                if (responseGet != null) {
                    JSONObject fullJsonOjbect = new JSONObject(responseGet);
                    response.getOutputStream().write(fullJsonOjbect.toString().getBytes());
                } else {
                    error = true;
                    errorReason = "Invalid parameters";
                }
            }
        }
        if(error) {
            RequestDispatcher view = request.getRequestDispatcher("Error/error.html");
            response.setHeader("error", errorReason);
            view.forward(request, response);
        }

    }

}