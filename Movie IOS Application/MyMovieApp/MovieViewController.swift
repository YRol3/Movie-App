//
//  MovieViewController.swift
//  MyMovieApp
//
//  Created by Yan Rips on 31/03/2019.
//  Copyright © 2019 Yan Rips. All rights reserved.
//

import UIKit
import YouTubePlayer_Swift

class MovieViewController: UIViewController {
    var youtubeTrailer:YouTubePlayerView!
    var forgroundView: UIView!
    var playPauseImage: UIImageView!
    var movieDescription:UILabel!
    var movieCast:UILabel!
    var movieLength:UILabel!
    var movieDirectors:UILabel!
    var movieReleaseCountry:UILabel!
    var scrollView:UIScrollView!
    var orderButtons:[UIButton]!
    var forgroundTopView: UIView!

    var movie:Movie!
    func setMovie(movie:Movie) {
        self.movie = movie
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    func initViews(onComplete: @escaping (Bool) -> Void){
        initAllViews()
        orderButtons = []
        let description = movie.description ?? ""
            let descriptionHeight = heightForView(text: description, font: UIFont.boldSystemFont(ofSize: 18), width: view.frame.width-40)
            /*movieImage = UIImageView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.width * 9/16 ))
            movieImage.loadImageFromUrl(url: movie.bUrl, onComplete:{_ in onComplete(true)})
            movieImage.contentMode = .scaleAspectFill
            movieImage.backgroundColor = UIColor.white
         scrollView.addSubview(movieImage)
 */
            view.addSubview(scrollView)
        
        
            youtubeTrailer = YouTubePlayerView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.width * 9/16 ))
        youtubeTrailer.playerVars = ["playsinline" : 1 as AnyObject,
                                     "rel" : 0 as AnyObject]
            if let video = movie.video{
                youtubeTrailer.loadVideoURL(URL(string: video)!)
            }
            onComplete(true)
            scrollView.addSubview(youtubeTrailer)
            scrollView.addSubview(forgroundTopView)
            scrollView.addSubview(forgroundView)
            scrollView.addSubview(movieDescription)
            //scrollView.addSubview(playPauseImage)
            for event in movie.events!{
                let btn = UIButton(type: .system)
                btn.setTitle("הזמנה לשעה - \(event.Date)", for: .normal)
                btn.layer.cornerRadius = 25;
                btn.setTitleColor(UIColor.white, for: .normal)
                btn.clipsToBounds = true;
                btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
                let halfY = (view.frame.width * 9/16 + 145 + descriptionHeight)
                let yPosition =  CGFloat(halfY + 25) + CGFloat(100 * orderButtons.count)
                btn.backgroundColor = UIColor.init(red: 0, green:0.568, blue: 0, alpha: 1)
                btn.tag = orderButtons.count
                btn.frame = CGRect(x: view.frame.width/8, y: yPosition, width: view.frame.width - view.frame.width/4, height: 80)
                btn.addTarget(self, action: #selector(onOrderClick), for: .touchUpInside)
                orderButtons.append(btn)
                scrollView.addSubview(btn)
            
            scrollView.addSubview(movieCast)
            scrollView.addSubview(movieLength)
            scrollView.addSubview(movieDirectors)
            scrollView.addSubview(movieReleaseCountry)
            //scrollView.addSubview(orderButton)
            
            //orderButton.addTarget(self, action: #selector(onOrderClick), for: .touchUpInside)
            scrollView.contentSize = CGSize(width: view.frame.width, height: movieDescription.frame.height + youtubeTrailer.frame.height + CGFloat(100 * orderButtons.count) + 250)
               
        }
        
        /*
        orderButton = UIButton(type: .system)
        orderButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 45)
        orderButton.layer.cornerRadius = 25;
        orderButton.setTitleColor(UIColor.white, for: .normal)
        
        orderButton.clipsToBounds = true;
        orderButton.setTitle("הזמן כרטיסים", for: .normal)
        //0,128,0)
        orderButton.backgroundColor = UIColor.init(red: 0, green:0.568, blue: 0, alpha: 1)
        orderButton.frame = CGRect(x: view.frame.width/8, y: view.frame.width * 9/16 + 145 + descriptionHeight + 25, width: view.frame.width - view.frame.width/4, height: 80)
        */
        
        
    }
    func initAllViews(){
        scrollView = UIScrollView(frame: view.frame)
        forgroundView = UIView(frame: CGRect(x: 0, y: view.frame.width * 9/16, width: view.frame.width, height: view.frame.height - view.frame.width * 9/16 ))
        forgroundTopView = UIView(frame: CGRect(x: 0, y: -500, width: view.frame.width, height: 500))
        forgroundTopView.backgroundColor = UIColor.black
        view.backgroundColor = UIColor.black
       
        //movieImage.addBlur()
        forgroundView.backgroundColor = UIColor.black
        let description:String = movie.description ?? ""
            let descriptionHeight = heightForView(text: description, font: UIFont.boldSystemFont(ofSize: 18), width: view.frame.width-40)
            /* var movieCast:UILabel!
             var movieLength:UILabel!
             var movieDirectors:UILabel!
             var movieReleaseCountry:UILabel!*/
            let cast:String = movie.cast ?? ""
            let length:Int = movie.length ?? 0
            let directors:String = movie.directors ?? ""
            let releaseCoutry:String = movie.releaseCountry ?? ""
            let castHeight = heightForView(text: "שחקים: \(cast)", font: UIFont.boldSystemFont(ofSize: 18), width: view.frame.width-40)
            movieCast = UILabel(frame: CGRect(x: 20, y: view.frame.width * 9/16 + 10, width: view.frame.width - 40, height: castHeight
            ))
            movieCast.numberOfLines = 0
            movieCast.text = "שחקים: \(cast)"
            movieLength = UILabel(frame: CGRect(x: 20, y: view.frame.width * 9/16 + castHeight + 20, width: view.frame.width - 40, height: 25))
            movieLength.text = "אורך: \(length) דקות"
            movieDirectors = UILabel(frame: CGRect(x: 20, y: view.frame.width * 9/16 + 55 + castHeight, width: view.frame.width - 40, height: 25))
            movieDirectors.text = "במאי/ם: \(directors)"
            movieReleaseCountry = UILabel(frame: CGRect(x: 20, y: view.frame.width * 9/16 + 80 + castHeight, width: view.frame.width - 40, height: 25))
            movieReleaseCountry.text = "מדינה: \(releaseCoutry)"
            
            movieDescription = UILabel(frame: CGRect(x: 20, y: 115 + castHeight + view.frame.width * 9/16, width: view.frame.width - 40, height: descriptionHeight))
            movieDescription.numberOfLines = 0
            movieDescription.text = "תקציר: \(description)"
            scrollView.contentSize = CGSize(width: view.frame.width, height: view.frame.width * 9/16 + 115 + 200 + descriptionHeight)
            
            initTextLabel(label: movieDescription)
            initTextLabel(label: movieCast)
            initTextLabel(label: movieLength)
            initTextLabel(label: movieDirectors)
            initTextLabel(label: movieReleaseCountry)
            self.navigationItem.title = movie.name;
           /*
            playPauseImage = UIImageView(frame: CGRect(x: view.frame.width/2-50, y: (view.frame.width * 9/16)/2 - 50, width: 100, height: 100))
            
         
            playPauseImage.image = UIImage(named: "play")
            */
        
        
    }
    @objc func onOrderClick(sender: UIButton){
        let EventTime = MovieEventTimeViewController()
        EventTime.setMovie(movie: movie)
        EventTime.setEvent(event: movie.events![sender.tag])
        print(movie.events![sender.tag].TimeNDate)
        self.navigationController?.pushViewController(EventTime, animated: true)
    }
    func initTextLabel(label: UILabel){
        label.textAlignment = .right
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = UIColor.white
    }
    func heightForView(text:String, font:UIFont, width:CGFloat) -> CGFloat{
        let label:UILabel = UILabel(frame: CGRect(x:0, y:0,width:width, height:CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        
        label.sizeToFit()
        return label.frame.height
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true

    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController!.navigationBar.isHidden = false
    }
    
    func pullJsonFromServer(events: [Event], id:String, onComplete: @escaping ()->Void){
        self.movie = Movie(name: "", url:
            "")
        self.movie.events = events
        var session:URLSession
        session = URLSession(configuration: URLSessionConfiguration.default)
        let url = URL(string: "http://localhost:8080/movieSearch?filmID=\(id)&filter=synopsis,videoLink,posterLink,name,id,releaseCountry,length,directors,cast")!
        let task = session.dataTask(with: url) { (data: Data?, urlResponse: URLResponse?, error: Error?) in
            if error == nil{
                if let theData = data{
                    do{
                        let json = try JSONSerialization.jsonObject(with: theData, options: [])
                        guard let js = json as? [String: Any] else {
                            return
                        }
                        let name = js["name"] as! String
                        let photo = js["posterLink"] as! String
                        
                        self.movie.name = name
                        self.movie.URL = photo
                        self.movie.id = js["id"] as? String
                        self.movie.video = js["videoLink"] as? String
                        self.movie.description = js["synopsis"] as? String
                        self.movie.releaseCountry = js["releaseCountry"] as? String
                        self.movie.cast = js["cast"] as? String
                        self.movie.directors = js["directors"] as? String
                        self.movie.length = js["length"] as? Int


                            
                        
                        
                    }catch{
                        print(error)
                    }
                }
            }
            DispatchQueue.main.async {
                onComplete()
            }
            
        }
        task.resume()
    }
}
