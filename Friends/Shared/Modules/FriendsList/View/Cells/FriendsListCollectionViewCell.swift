//
//  FriendsListCollectionViewCell.swift
//  Friends
//
//  Created by Md Faizul karim on 28/3/23.
//

import UIKit

class FriendsListCollectionViewCell: BaseCollectionViewCell {
    @IBOutlet weak var baseView : UIView!
    @IBOutlet weak var name : UILabel!
    @IBOutlet weak var country : UILabel!
    @IBOutlet weak var age : UILabel!
    @IBOutlet weak var profileImage : UIImageView!
    
    var cellViewModel : FriendsListResponseData?
 
    override func layoutSubviews() {
        super.layoutSubviews()
        setupTheme()
    }
    
    func configureCell(name: String, country: String, age: String, image: String){
        setupView()
        self.name.text = name
        self.country.text = country
        self.age.text = age
        self.profileImage.loadImage(fromURL: image)
    }

}

extension  FriendsListCollectionViewCell {
    func setupView(){
    }
    func setupTheme(){
        self.baseView.backgroundColor = theme?.colorTheme.colorPrimaryWhite
        self.baseView.addShadow(color: UIColor.gray, opacity: 1.0, sizeX: 1.0, sizeY: 1.0, shadowRadius: 2)
    }
}
