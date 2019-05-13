//
//  MovieCell.swift
//  MyMovieApp
//
//  Created by Yan Rips on 31/03/2019.
//  Copyright © 2019 Yan Rips. All rights reserved.
//

import UIKit

class MovieCell: UICollectionViewCell {
    var movieLabel: UILabel!
    var tempImage: UIView!
    var movieImage: UIImageView!
    var movie: Movie!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        tempImage = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height-50))
        tempImage.backgroundColor = UIColor.gray
        movieLabel = UILabel(frame: CGRect(x: 0, y: self.frame.height-50, width: self.frame.width, height: 50))
        movieImage = UIImageView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height-50))
        
        movieImage.contentMode = .scaleAspectFit
        movieLabel.textColor = UIColor.white
        
        movieLabel.backgroundColor = UIColor.black
        movieLabel.textAlignment = .center
        movieLabel.font = UIFont.boldSystemFont(ofSize: 20)
        self.addSubview(movieImage)
        self.addSubview(tempImage)
        self.addSubview(movieLabel)
        self.backgroundColor = UIColor.black
        
    }
    func initCell(){
        
        movieLabel.text = movie.name
        tempImage.isHidden = false
        movieImage.image = nil
        movieImage.loadImageFromUrl(url: movie.bUrl, onComplete:{(Bool) in
            print(self.movie.name)
            self.tempImage.isHidden = true
        })
        
        
    }
    
    func setMovie(movie:Movie){
        self.movie = movie
        initCell()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
