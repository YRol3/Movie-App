//
//  SeatChoosingView.swift
//  MyMovieApp
//
//  Created by Yan Rips on 11/04/2019.
//  Copyright © 2019 Yan Rips. All rights reserved.
//

import UIKit

class SeatChoosingView: UIView {
    var btns: [Seat]!
    let rows = 20
    let colums = 10
    var outSideFunc:((Int, Bool) -> Void)!
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        btns = []
        var seatNumber: Int = 0
        for i in 0..<rows{
            for j in 0..<colums{
               
                let sizeX = frame.width/CGFloat(rows)
                let sizeY = frame.height/CGFloat(colums)
                let btn = Seat(frame: CGRect(x: CGFloat(i) * sizeX, y: CGFloat(j) *
                    sizeY, width: sizeX, height: sizeY))
                //btn.backgroundColor = UIColor.red
                btn.addGestureRecognizer(UITapGestureRecognizer(target: self, action:  #selector (onTouchSeat(sender:))))
                btn.tag = 0
                //random seat occupaid simulator
                if seatNumber%2 == 0{
                    let chance = Int.random(in: 0...1)
                    if chance == 1{
                        btn.tag = -1
                        btn.setSeatDisabled(seatNumber)
                    }
                }
                
                btn.setSeatNumber(number: seatNumber)
                seatNumber += 1
                btns.append(btn)
                addSubview(btn)
            }
            
        }
        let labelScreen = UILabel(frame: CGRect(x: 10, y: 0, width: frame.width-20, height: 20))
        labelScreen.textColor = UIColor.black
        labelScreen.font = UIFont.boldSystemFont(ofSize: 15)
        labelScreen.textAlignment = .center
        labelScreen.text = "מסך"
        labelScreen.backgroundColor = UIColor.lightGray
        addSubview(labelScreen)
    }
    
    
    
    @objc func onTouchSeat(sender: UITapGestureRecognizer){
        if let seat = sender.view as? Seat {
            if seat.tag == 0{
                seat.tag = 1
                seat.setSeatSelected(selected: true)
                outSideFunc(seat.seatNumber, true)
            }else if seat.tag == 1{
                seat.tag = 0
                seat.setSeatSelected(selected: false)
                outSideFunc(seat.seatNumber, false)
            }
            
        }
        //sender.chairBack.backgroundColor = UIColor.red
    }
    func notifySeatClicked(function:@escaping  (Int, Bool) -> Void){
        outSideFunc = function
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
