//
//  DetailView.swift
//  hero-app
//
//  Created by Daniel Orellana on 28/06/21.
//

import Foundation
import UIKit

class DetailView: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblAlias: UILabel!
    @IBOutlet weak var lblGender: UILabel!
    @IBOutlet weak var lblRace: UILabel!
    @IBOutlet weak var lblHeight: UILabel!
    @IBOutlet weak var lblWeight: UILabel!
    @IBOutlet weak var lblEyeColor: UILabel!
    @IBOutlet weak var lblHairColor: UILabel!
    @IBOutlet weak var lblFullName: UILabel!
    @IBOutlet weak var btnFavorite: UIButton!
    @IBOutlet weak var lblAlterEgo: UILabel!
    @IBOutlet weak var lblBase: UILabel!
    @IBOutlet weak var lblRelatives: UILabel!
    
    var hero: HeroDb?
    var heroVM = HeroViewModel()
    private var list: [ItemModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initialize()
    }
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func favorite(_ sender: Any) {
        if self.hero!.isFavorite {
            self.heroVM.remove(self.hero!)
            self.hero?.isFavorite.toggle()
        } else {
            self.heroVM.save(self.hero!)
            self.hero?.isFavorite.toggle()
        }
        
        self.btnFavorite.setImage(UIImage(systemName: self.hero!.isFavorite ? "star.fill" : "star"), for: .normal)
    }
    
    private func initialize() {
        self.createList()
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        self.lblAlias.text = self.hero?.name
        self.lblGender.text = self.hero?.appearance?.gender
        self.lblRace.text = self.hero?.appearance?.race
        self.lblEyeColor.text = self.hero?.appearance?.eye_color
        self.lblHairColor.text = self.hero?.appearance?.hair_color
        
        self.lblFullName.text = self.hero?.biography?.full_name
        self.lblAlterEgo.text = self.hero?.biography?.alter_egos
        
        self.lblBase.text = self.hero?.work?.base
        self.lblRelatives.text = self.hero?.connection?.relatives
        
        ImageLoader.image(for: URL(string: self.hero?.image ?? "http://placehold.it/150x350")!) { image in
            self.imgProfile.image = image
        }
        
        self.showUnits()
        
        self.btnFavorite.setImage(UIImage(systemName: self.hero!.isFavorite ? "star.fill" : "star"), for: .normal)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ItemView
        let entity = self.list[indexPath.row]
        
        cell.imgIcon.image = UIImage(systemName: entity.icon)
        cell.lblValue.text = "\(entity.value)"
        
        if entity.value >= 90 {
            cell.lblValue.textColor = UIColor.green
        } else if entity.value >= 50 && entity.value < 90 {
            cell.lblValue.textColor = UIColor.orange
        }  else {
            cell.lblValue.textColor = UIColor.red
        }
        
        return cell
    }
    
    func collectionView(_ colectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
       {
        return CGSize(width: (collectionView.bounds.width - 50) / CGFloat(self.list.count), height: 100.0)
       }
    
    private func createList() {
        self.list.append(ItemModel(self.hero?.intelligence ?? 0, "lightbulb"))
        self.list.append(ItemModel(self.hero?.strength ?? 0, "bolt"))
        self.list.append(ItemModel(self.hero?.speed ?? 0, "speedometer"))
        self.list.append(ItemModel(self.hero?.durability ?? 0, "clock.arrow.2.circlepath"))
        self.list.append(ItemModel(self.hero?.power ?? 0, "bolt.circle"))
        self.list.append(ItemModel(self.hero?.combat ?? 0, "figure.wave"))
    }
    
    private func showUnits() {
        let height = self.hero?.appearance?.height.components(separatedBy: ",")
        let weight = self.hero?.appearance?.weight.components(separatedBy: ",")
        
        self.lblHeight.text = Preferences.getParamBool("imperial") ? height?[0] : height?[1]
        self.lblWeight.text = Preferences.getParamBool("imperial") ? weight?[0] : weight?[1]
    }
    
}
