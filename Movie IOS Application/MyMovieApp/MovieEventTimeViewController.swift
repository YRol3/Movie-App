//
//  MovieEventTimeViewController.swift
//  MyMovieApp
//
//  Created by Yan Rips on 10/04/2019.
//  Copyright © 2019 Yan Rips. All rights reserved.
//

import UIKit

class MovieEventTimeViewController: UIViewController {
    private var seatChoosing:SeatChoosingView!
    private var movie:Movie!
    private var event:Event!
    private var totalSeatChoosen = 0
    private var nextBtn:UIButton!
    var counter:UILabel!
    func setMovie(movie:Movie){
        self.movie = movie
    }
    func setEvent(event: Event){
        self.event = event
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black
        seatChoosing = SeatChoosingView(frame: CGRect(x: 20, y: 50, width: view.frame.width - 40, height: view.frame.height-250))
        seatChoosing.notifySeatClicked(function: seatClicked)
        counter = UILabel(frame: CGRect(x: 20, y: 20, width: view.frame.width-40, height: 30))
        counter.backgroundColor = UIColor.white
        counter.textColor = UIColor.black
        counter.font = UIFont.boldSystemFont(ofSize: 20)
        counter.text = "מחיר - 0   סה\"כ כיסאות - 0"
        counter.textAlignment = .center
        
        nextBtn = UIButton(type: .system)
        nextBtn.frame = CGRect(x: 20, y: view.frame.height-190, width: view.frame.width-40, height: 50)
        nextBtn.backgroundColor = UIColor.green
        nextBtn.setTitle("המשך לרכישה", for: .normal)
        nextBtn.setTitleColor(UIColor.white, for: .normal)
        nextBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        nextBtn.addTarget(self, action: #selector(onNextClicked), for: .touchUpInside)
        view.addSubview(nextBtn)
        
        view.addSubview(seatChoosing)
        view.addSubview(counter)
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        
    }
    override func viewWillAppear(_ animated: Bool) {
    
        self.navigationController?.navigationBar.isHidden = false
        self.title = event.Date
        
        
    }
    @objc func onNextClicked(){
        if(totalSeatChoosen == 0){
            let alert = UIAlertController(title: "לא נבחרו כיסאות", message: "לא ניתן לעבור למסך הבאה בלי בחירת כיסאות", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "חזור", style: .cancel, handler:nil))
            present(alert, animated: true)
            return;
        }
        let controller = PaymentViewController()
        
        controller.setEvent(event: event)
        controller.setMovie(movie: movie)
        controller.setTotalSeats(totalSeatChoosen)
        self.navigationController?.pushViewController(controller, animated: true)
    }
    func seatClicked(seatNumber: Int, choosen: Bool){
        print("[\(choosen)] seat number: \(seatNumber)")
        if choosen {
            totalSeatChoosen += 1
        }else{
            totalSeatChoosen -= 1
        }
        counter.text = "מחיר - \(totalSeatChoosen * 30)   סה\"כ כיסאות - \(totalSeatChoosen)"
    }
}
