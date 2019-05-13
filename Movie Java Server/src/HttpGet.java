import org.json.JSONArray;
import org.json.JSONObject;

import java.io.*;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.*;

public class HttpGet {

    public static String get(String str) throws IOException {

        InputStream inputStream = null;
        HttpURLConnection connection = null;
        try{
            URL url = new URL(str);
            connection = (HttpURLConnection) url.openConnection();
            inputStream = connection.getInputStream();
            int actualyRead;
            byte[] buffer = new byte[4];
            ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
            while((actualyRead = inputStream.read(buffer)) != -1){
                byteArrayOutputStream.write(buffer, 0, actualyRead);
            }
            return  new String(byteArrayOutputStream.toByteArray());
        } catch (MalformedURLException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
        finally {
            if (inputStream != null) {
                try {
                    inputStream.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
            if (connection != null) {
                connection.disconnect();
            }
        }
        throw new IOException("Could not get string for the website: " + str);
    }
    public static String requestWithParams(String atDate, List<String> rFilters, List<String> oFilters, FilterResponse filterResponse){
        if (rFilters != null) {
            try {
                FileManager.checkIfOldFilesExistsAndRemove("json_by_date");
                String response = FileManager.pullAndCachefile(String.format("%s%s%s%s", FinalsClass.BASE_URL, FinalsClass.IN_CINEMA, atDate, FinalsClass.ATTRIBUTES) ,atDate, "json_by_date");
                JSONObject jsonObject = filterResponse.filter(new JSONObject(response));
                JSONObject newJsonObject = filterResponseJson(jsonObject, rFilters, oFilters);
                if(!newJsonObject.isEmpty())
                    return newJsonObject.toString();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        return null;
    }

    public static JSONObject filterResponseJson(JSONObject jsonObject, List<String> rFilters, List<String> oFilters){
        JSONObject newJsonObject = new JSONObject();
        if(rFilters == null && oFilters != null){
            for (int i = 0; i < oFilters.size(); i++) {
                if(jsonObject.has(oFilters.get(i))){
                    newJsonObject.put(oFilters.get(i), jsonObject.get(oFilters.get(i)));
                }
            }
        }else {
            for (int i = 0; i < rFilters.size(); i++) {
                if (jsonObject.has(rFilters.get(i))) {
                    JSONArray filterObject = new JSONArray();
                    if (oFilters != null) {
                        for (int j = 0; j < jsonObject.getJSONArray(rFilters.get(i)).length(); j++) {
                            JSONObject jsonFilter = new JSONObject();
                            boolean objectBuilt = false;
                            for (String objectFilterString : oFilters) {
                                if (jsonObject.getJSONArray(rFilters.get(i)).getJSONObject(j).has(objectFilterString)) {
                                    objectBuilt = true;
                                    jsonFilter.put(objectFilterString, jsonObject.getJSONArray(rFilters.get(i)).getJSONObject(j).get(objectFilterString));
                                }
                            }
                            if (objectBuilt)
                                filterObject.put(jsonFilter);
                        }
                        if (!filterObject.isEmpty())
                            newJsonObject.put(rFilters.get(i), filterObject);
                    } else {
                        if (jsonObject.has(rFilters.get(i)) && !jsonObject.getJSONArray(rFilters.get(i)).isEmpty())
                            newJsonObject.put(rFilters.get(i), jsonObject.getJSONArray(rFilters.get(i)));
                    }
                }
            }
        }
        return newJsonObject;
    }
    /**
     * pulls whole html from http://yesplanet.co.il
     * breaks down the url to the point where
     * <script>
     *     var filmDetails = {jsonObject}
     * </script>
     * and returns the jsonObject
     * @param url Movie full link
     * @return filmDetails json object
     */
    public static String getJsonFromHTMLFile(String url, String searchBy){

        try {
            StringBuilder stringB = new StringBuilder(HttpGet.get(url));
            int startAt = stringB.indexOf(searchBy) + searchBy.length()-1;
            stringB.replace(0, startAt, "");
            startAt = stringB.indexOf("};")+1;
            int endAt = stringB.length();
            stringB.replace(startAt, endAt, "");
            return stringB.toString();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return null;

    }

    interface FilterResponse{
        JSONObject filter(JSONObject jsonObject);
    }


}

