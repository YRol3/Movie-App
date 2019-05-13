//
//  Seat.swift
//  MyMovieApp
//
//  Created by Yan Rips on 11/04/2019.
//  Copyright © 2019 Yan Rips. All rights reserved.
//

import UIKit

class Seat: UIView {
    var chairBack:UIView!
    var chairRight: UIView!
    var chairLeft: UIView!
    var seatNumber: Int!
    override init(frame: CGRect) {
        super.init(frame: frame)
        chairBack = UIView(frame: CGRect(x: frame.width/4, y: frame.height - frame.height/8, width: frame.width - frame.width/2, height: frame.height/8))
        chairBack.backgroundColor = UIColor.blue
        
        chairLeft = UIView(frame: CGRect(x: frame.width/5, y: frame.height - frame.height/4, width: frame.width/5, height: frame.height/4))
        chairLeft.backgroundColor = UIColor.blue
        
        chairRight = UIView(frame: CGRect(x: frame.width - frame.width/4, y: frame.height - frame.height/4, width: frame.width/5, height: frame.height/4))
        chairRight.backgroundColor = UIColor.blue
        addSubview(chairLeft)
        addSubview(chairRight)
        addSubview(chairBack)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setSeatNumber(number: Int){
        seatNumber = number
    }
    func setSeatSelected(selected: Bool){
        if selected{
            chairRight.backgroundColor = UIColor.green
            chairLeft.backgroundColor = UIColor.green
            chairBack.backgroundColor = UIColor.green
        }else{
            chairRight.backgroundColor = UIColor.blue
            chairLeft.backgroundColor = UIColor.blue
            chairBack.backgroundColor = UIColor.blue
        }
    }
    func setSeatDisabled(_ seatNumber: Int){
        chairRight.backgroundColor = UIColor.gray
        chairLeft.backgroundColor = UIColor.gray
        chairBack.backgroundColor = UIColor.gray
    }
    
}
