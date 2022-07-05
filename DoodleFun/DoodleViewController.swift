//
//  DoodleViewController.swift
//  DoodleFun
//
//  Created by Simon Ng on 15/1/2021.
//

import UIKit

class DoodleViewController: UIViewController {
    
    private var doodleImages = (1...20).map {"DoodleIcons-\($0)"}
    lazy var dataSource = configureDataSource()
    
    enum Section{
        case all
    }
    
    @IBOutlet var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = dataSource
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout{
            layout.itemSize = CGSize(width: 128, height: 128)
            layout.estimatedItemSize = .zero
        }
        updateSnapshot()
        // Do any additional setup after loading the view.
    }


}

extension DoodleViewController{
    func configureDataSource()-> UICollectionViewDiffableDataSource<Section, String>{
        let dataSource = UICollectionViewDiffableDataSource<Section,String>(collectionView: collectionView){(collectionView, indexPath, imageName) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! DoodleCollectionViewCell
            cell.imageView.image = UIImage(named: imageName)
            
            return cell
        }
        
        return dataSource
    }
    
    func updateSnapshot(animatingChange:Bool = false){
        // create a snapShot and populate data
        var snapShot = NSDiffableDataSourceSnapshot<Section,String>()
        snapShot.appendSections([.all])
        snapShot.appendItems(doodleImages, toSection: .all)
        dataSource.apply(snapShot, animatingDifferences: false)
    }
}

