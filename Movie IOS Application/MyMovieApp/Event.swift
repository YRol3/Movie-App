//
//  Event.swift
//  MyMovieApp
//
//  Created by Yan Rips on 10/04/2019.
//  Copyright © 2019 Yan Rips. All rights reserved.
//

import UIKit

struct Event {
    var id:String
    var TimeNDate:String
    init(id: String, time: String) {
        self.id = id
        self.TimeNDate = time
    }
    var Date:String{
        get{
            var date = TimeNDate
            date = String(date.suffix(8))
            date = String(date.prefix(5))
            return date
        }
    }
}
