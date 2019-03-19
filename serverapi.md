# Movie Server REST API


## GET 
### `/globalSearch` 

will return all information about the movies and the events of the movies for the choose date

|Parameter|Value|Optional
|:--------:|:----:|:-------:
|atDate|date formated: yyyy-mm-dd|false
|request|search key: films, events|false
|filter|any key name as many as needed|true

`Response 200`
```json 
{
    "films": 
    [
        {
            "attributeIds": 
            [
                "attribute"
            ],
            "name": "name",
            "length": minutes,
            "link": "limk",
            "weight": 0,
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
            "attributeIds": 
            [
                "attribute"
            ],
            "cinemaId": "cinemaid",
            "filmId": "filmid",
            "id": "eventid",
            "businessDay": "yyyy-mm-dd",
            "soldOut": true
        }
    ]
}
```


