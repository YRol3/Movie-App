//
//  ViewController.swift
//  MyMovieApp
//
//  Created by Yan Rips on 24/03/2019.
//  Copyright © 2019 Yan Rips. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate,    UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIPickerViewDelegate, UIPickerViewDataSource{
    
    
    var movies:[Movie]!
    var dates:[String]!
    var selected:Bool = false
    var collectionView: UICollectionView!
    var loadingCircle:Loader!
    let cellID = "CellIdentifier"
    var picker:UIPickerView!
    var dateSelector:UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "סרטים"
        view.backgroundColor = UIColor.black
        movies = []
        dates = []
        initCollectionView()
        initDataSelector()
        loadingCircle = Loader(frame: CGRect(x: view.frame.width/2-75, y: view.frame.height/2-75, width: 150, height: 150))
        view.addSubview(loadingCircle)
        loadingCircle.beginAnimate()
        pullJsonFromServer(date: dates[0])
       
    }
    func initDataSelector(){
        for i in 0..<3{
            let date = Date(timeIntervalSinceNow: TimeInterval(86400 * i))
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            let result = formatter.string(from: date)
            dates.append(result)
            print(dates[i])
        }
        dateSelector = UIButton(type: .system)
        dateSelector.frame = CGRect(x: 0, y: 30, width: view.frame.width, height: 50)
        dateSelector.setTitle("היום \(dates[0])", for: .normal)
        dateSelector.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        dateSelector.addTarget(self, action: #selector(onDatePickerClick), for: .touchUpInside)
        dateSelector.setTitleColor(UIColor.white, for: .normal)
        picker = UIPickerView(frame: CGRect(x: 0, y: view.frame.height/1.25, width: view.frame.width, height: view.frame.height/5))
        picker.delegate = self
        picker.dataSource = self
        picker.isHidden = true
        picker.backgroundColor = UIColor.white
        
        view.addSubview(picker)
        view.addSubview(dateSelector)
    }
    @objc func onDatePickerClick(sender: UIButton){
        sender.isEnabled = false
        picker.isHidden = false
        picker.frame.origin.y = view.frame.height
        UIView.animate(withDuration: 0.2, animations: {
            self.picker.frame.origin.y = self.view.frame.height/1.25
        })
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
       
        dateSelector.setTitle(getDateHebrew(row: row) + dates[row] , for: .normal)
        dateSelector.isEnabled = true
        movies.removeAll()
        collectionView.reloadData()
        pullJsonFromServer(date: dates[row])
        UIView.animate(withDuration: 0.2, animations: {
             self.picker.frame.origin.y = self.view.frame.height
        }, completion: { (_) in
             self.picker.isHidden = true
        })
        
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dates.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let finalString = getDateHebrew(row: row)
        return finalString + dates[row]
    }
    func getDateHebrew(row:Int) ->String{
        switch(row){
        case 0: return "היום "
        case 1: return "מחר "
        default: return "מחרותיים "
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width/2-5, height: view.frame.height/2.1)
    }
    func pullJsonFromServer(date:String){
        var session:URLSession
        session = URLSession(configuration: URLSessionConfiguration.default)
        let url = URL(string: "http://localhost:8080/globalSearch?request=films,events&atDate=\(date)&filter=posterLink,name,id,eventDateTime,filmId")!
        let task = session.dataTask(with: url) { (data: Data?, urlResponse: URLResponse?, error: Error?) in
            if error == nil{
                if let theData = data{
                    do{
                        let json = try JSONSerialization.jsonObject(with: theData, options: [])
                        guard let jsonArray = json as? [String: Any] else {
                            return
                        }
                        guard let js = jsonArray["films"] as? [[String: Any]] else {
                            return
                        }
                        for i in 0..<js.count{
                            let name = js[i]["name"] as! String
                            let photo = js[i]["posterLink"] as! String
                            let id = js[i]["id"] as! String
                            let m = Movie(name: name, url: photo)
                            m.id = id
                            self.movies.append(m)
                            
                        }
                        guard let events = jsonArray["events"] as? [[String: Any]] else {
                            return
                        }
                        for i in 0..<events.count{
                            let id = events[i]["filmId"] as? String
                            let time = events[i]["eventDateTime"] as? String
                            let e = Event(id: id!, time: time!)
                            for movie in self.movies{
                                if(movie.id == e.id){
                                    movie.events?.append(e)
                                }
                            }
                        }
                    }catch{
                        print(error)
                    }
                }
            }
            DispatchQueue.main.async {
                self.loadingCircle.stopAnimate()
                self.loadingCircle.isHidden = true
                self.collectionView.reloadData()
                //self.initTableView()
            }
            
        }
        task.resume()
    }
    
    func initCollectionView(){
         let layout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 75, width: view.frame.width, height: view.frame.height-75), collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(MovieCell.self, forCellWithReuseIdentifier: cellID)
        collectionView.backgroundColor = UIColor.black
    
        view.addSubview(collectionView)
        collectionView.reloadData()
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if selected{
            return
        }
        selected = true
        print(movies[indexPath.row].name)
        let controller = MovieViewController()
        loadingCircle.isHidden = false
        loadingCircle.beginAnimate()
        let id:String = movies[indexPath.row].id ?? ""
        
        controller.pullJsonFromServer(events: movies[indexPath.row].events!, id: id, onComplete: {
            controller.initViews { (Bool) in
            self.navigationController?.pushViewController(controller, animated: true)
                self.selected = false
                self.loadingCircle.isHidden = true
                self.loadingCircle.stopAnimate()
            }
        })
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        

    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! MovieCell
        cell.setMovie(movie: movies[indexPath.row])
        return cell
    }
}
extension UIImageView{
    func loadImageFromUrl(url: String,  onComplete: @escaping (Bool)->Void){
        self.image = nil
        let url = URL(string: url)!
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let task = session.dataTask(with: url) { (data, response, error) in
            if error == nil{
                if let data = data{
                    DispatchQueue.main.async{
                        self.image = UIImage(data: data)
                        onComplete(true)
                    }
                }
            }else{
                onComplete(false)
            }
        }
        task.resume()
    }
}
extension UIImageView{
    func loadFromUrl(url: String){
        if(self.tag != 0){
            self.tag = 1
            let url = URL(string: url)!
            let session = URLSession(configuration: URLSessionConfiguration.default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error == nil{
                    if let data = data{
                        DispatchQueue.main.async{
                            if(self.tag == 1){
                                 self.image = UIImage(data: data)
                            }
                             self.tag = 0
                            
                        }
                    }
                }
            }
            task.resume()
        }
       
    }
}

