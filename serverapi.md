# Movie Server REST API


## GET 
### `/globalSearch` 


will return all information about the movies and the events of the movies for the choose date

|Parameteer|Values|Optional
|:--------:|:----:|:-------:
|atDate|date formated: yyyy-mm-dd|false
|request|films,events or both|false
|filter|any key name as many as needed|true

`Response 200`
```json 
{
    "films": 
    [
        {
            "attributeIds": [],
            "name": "name",
            "length": minutes,
            "link": "limk",
            "videoLink": "video link",
            "id": "id",
            "posterLink": "poster link",
            "releaseYear": "release year"
        }
    ]
    "events": 
    [
        {
            "eventDateTime": "yyyy-mm-ddThh: mm: ss",
            "bookingLink": "bookinglink",
            "attributeIds": [],
            "cinemaId": "cinemaid",
            "filmId": "filmid",
            "id": "eventid",
            "businessDay": "yyyy-mm-dd",
            "soldOut": boolean
        }
    ]
}
```

### `/movieSearch` 

 

Will return full movie details with specific id

|Parameteer|Values|Optional
|:--------:|:----:|:-------:
|filmID|full film id|false
|filter|any key name as many as needed|true

`Response 200`
```json 
{
    "firstSubbedLanguage": []
    "directors": "directors",
    "link": "link",
    "eventCount": eventCount,
    "originalName": "originalName",
    "cast": "cast",
    "releaseCountry": "releaseCountry",
    "dateStarted": "yyyy-mm-ddThh:mm:ss",
    "secondSubbedLanguage": []
    "id": "filmID",
    "dubbedLanguage": []
    "releaseYear": "releaseYear",
    "ageRestrictionId": ageRestrictionId,
    "ageRestrictionDescription": ageRestrictionDescription,
    "length": minutes,
    "ageRestrictionLink": "ageRestrictionLink",
    "ageRestrictionName": "ageRestrictionName",
    "posterLinkLarge": "posterLinkLarge",
    "synopsis": "synopsis",
    "posterLink": "posterLink",
    "originalLanguage": []
    "categoryIds": []
    "screeningAttributes": []
    "name": "name",
    "categoriesAttributes": []
    "videoLink": "videoLink",
    "showingType": "showingType"
}
```




