# Movie Server REST API


## GET 
* `/globalSearch` 

 `/globalSearch?[request={search request}]&[filter={search filter}]&atDate={yyyy-mm-dd}`

will return all information about the movies and the events of the movies for the choose date

|Parameteer|Values|Optional
|:--------:|:----:|:-------:
|atDate|yyyy-mm-dd|false
|request|films or events or both|false
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
            "length": minutes length,
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


