import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class ModedRequest {
    public static List<String> getParameterValues(javax.servlet.http.HttpServletRequest request, String parameter){
        String fullParameterRequest = request.getParameter(parameter);
        if(fullParameterRequest == null)
            return null;
        String[] parameterValues = fullParameterRequest.split(",");
        return new ArrayList<>(Arrays.asList(parameterValues));


    }
}
