import org.json.JSONArray;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.List;

public class Movie {
    String id;
    String name;
    int length;
    String posterLink;
    String videoLinkl;
    String link;
    String releaseYear;
    List<String> attributeIds;
    String description;

    /**
     * @param movieJsonObject json object must have next params:
     *                        {
     *                        "id":String,
     *                        "name":String,
     *                        "length": int,
     *                        "posterLink": String,
     *                        "videoLink": String,
     *                        "link": String,
     *                        "releaseYear": String,
     *                        "attributeIds": String[]
     *                        }
     */
    public Movie(JSONObject movieJsonObject) {
        if(movieJsonObject != null){
            id = movieJsonObject.getString("id");
            name = movieJsonObject.getString("name");
            length = movieJsonObject.getInt("length");
            posterLink = String.format("%s%s", FinalsClass.BASE_URL,movieJsonObject.getString("posterLink"));
            videoLinkl = movieJsonObject.getString("videoLink");
            link = String.format("%s%s", FinalsClass.BASE_URL,movieJsonObject.getString("Link"));
            releaseYear = movieJsonObject.getString("releaseYear");
            attributeIds = new ArrayList<String>();
            JSONArray tempArrayObject = movieJsonObject.getJSONArray("attributeIds");
            for (int i = 0; i < tempArrayObject.length(); i++) {
                attributeIds.add(tempArrayObject.getString(i));
            }
        }
    }

    public String getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public int getLength() {
        return length;
    }

    public String getPosterLink() {
        return posterLink;
    }

    public String getVideoLinkl() {
        return videoLinkl;
    }

    public String getLink() {
        return link;
    }

    public String getReleaseYear() {
        return releaseYear;
    }

    public List<String> getAttributeIds() {
        return new ArrayList<String>(attributeIds);
    }
}
