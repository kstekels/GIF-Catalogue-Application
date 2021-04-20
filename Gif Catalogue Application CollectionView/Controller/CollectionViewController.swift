//
//  CollectionViewController.swift
//  Gif Catalogue Application CollectionView
//
//  Created by karlis.stekels on 19/04/2021.
//

import UIKit
import Kingfisher
import ViewAnimator

class CollectionViewController: UICollectionViewController, UISearchBarDelegate {
    
    var gifs = [Gif]()
    var urlString: String = ""
    let searchController = UISearchController(searchResultsController: nil)
    
    let scale = UIScreen.main.scale
        
    var widthPerItem: CGFloat = 0.0
    private let itemsPerRow: CGFloat = 2
    private let sectionInsets = UIEdgeInsets(
        top: 50.0,
        left: 20.0,
        bottom: 50.0,
        right: 20.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleAnimation()
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        widthPerItem = availableWidth / itemsPerRow
        
        searchBarSetUp()
        navigationBarSetUp()
        reloadData()

        
    }
    
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if gifs.count > 0 {
            collectionView.backgroundView = nil
            return gifs.count
        }
        
        let rect = CGRect(x: 0,
                          y: 0,
                          width: collectionView.bounds.size.width,
                          height: collectionView.bounds.size.height)
        let noDataLabel: UILabel = UILabel(frame: rect)
        noDataLabel.text = "There are no GIF image to display"
        noDataLabel.textAlignment = .center
        noDataLabel.textColor = UIColor.gray
        noDataLabel.sizeToFit()
        
        collectionView.backgroundView = noDataLabel
        
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var cell = UICollectionViewCell()
        
        if let gifCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? CollectionViewCell {
            
            //MARK: - Image parameters
            let gifLink = gifs[indexPath.row].images.preview_gif.url
            let gifURL = URL(string: gifLink)
            
            
            
            //MARK: - Image size downsampling
            gifCell.gifImageView.kf.indicatorType = .activity
            gifCell.gifImageView.kf.setImage(with: gifURL, placeholder: nil, options: [
                                                .scaleFactor(scale),
                                                .transition(.fade(0.7))], progressBlock: nil)
            
            
            gifCell.layer.cornerRadius = 15
            gifCell.layer.masksToBounds = true
            gifCell.layer.borderWidth = 2
            gifCell.layer.borderColor = getBorderColor()
            cell = gifCell
        }
        cell.animate(animations: [AnimationType.zoom(scale: 0.1)], delay: 0.1, duration: 0.4)
        return cell
    }
    
}


extension CollectionViewController: UICollectionViewDelegateFlowLayout {
    
    
    // 1
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        // 2
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    // 3
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        return sectionInsets
    }
    
    // 4
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        return sectionInsets.left
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("Search")
        navigationItem.searchController?.dismiss(animated: true, completion: nil)
    }
    
    
    
    
    
}
