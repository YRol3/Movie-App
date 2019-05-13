//
//  Movie.swift
//  MyMovieApp
//
//  Created by Yan Rips on 24/03/2019.
//  Copyright © 2019 Yan Rips. All rights reserved.
//

import UIKit

class Movie {
    private var _name:String
    private var _url:String
    private var _id:String?
    private var _description:String?
    private var _videoLink:String?
    private var _cast:String?
    private var _releaseCountry:String?
    private var _directors:String?
    private var _length:Int?
    var events:[Event]?
    init(name:String, url:String) {
        self._name = name
        self._url = url
        self.URL = _url
        events = []
    }
    func print() -> String{
        return _name
    }

    var URL: String{
        get{
            return _url + "-md.jpg"
        }
        set{
            _url = newValue.replacingOccurrences(of: "-md.jpg", with: "")
        }
    }
    var sUrl: String{
        get{
            return _url + "-sm.jpg"
        }
    }
    var bUrl: String{
        get{
            return _url + ".jpg"
        }
    }
    
    var name: String{
        get{
            return _name
        }
        set{
            _name = newValue
        }
    }
    var description:String?{
        get{
            return _description
        }
        set{
            _description = newValue
        }
    }
    var id:String?{
        get{
            return _id
        }
        set{
            _id = newValue
        }
    }
    var video:String?{
        get{
            return _videoLink
        }
        set{
            _videoLink = newValue
        }
    }
    var cast:String?{
        get{
            
            return _cast
        }
        set{
            let castNames:String = newValue ?? ""
            let allNames = castNames.split(separator: ",")
            var names = ""
            for i in 0..<allNames.count{
                names += allNames[i]
                if(i < allNames.count-1){
                    names += ", "
                }
            }
            _cast = names
        }
    }
    var directors:String?{
        get{
            return _directors
        }
        set{
            _directors = newValue
        }
    }
    var releaseCountry:String?{
        get{
            return _releaseCountry
        }
        set{
            _releaseCountry = newValue
        }
    }
    var length:Int?{
        get{
            return _length
        }
        set{
            _length = newValue
        }
    }
}
