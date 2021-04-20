//
//  CollectionViewController.swift
//  Gif Catalogue Application CollectionView
//
//  Created by karlis.stekels on 19/04/2021.
//

import UIKit
import Kingfisher

class CollectionViewController: UICollectionViewController, UISearchBarDelegate {
    
    var gifs = [Gif]()
    var urlString: String = ""
    let searchController = UISearchController(searchResultsController: nil)
    
    let scale = UIScreen.main.scale
//    let resizingProcessor = ResizingImageProcessor(referenceSize: CGSize(width: size.width * scale, height: size.height * scale))
    
    var widthPerItem: CGFloat = 0.0
    private let itemsPerRow: CGFloat = 2
    private let sectionInsets = UIEdgeInsets(
      top: 50.0,
      left: 20.0,
      bottom: 50.0,
      right: 20.0)

    override func viewDidLoad() {
        super.viewDidLoad()
        print(scale)
        
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
                let availableWidth = view.frame.width - paddingSpace
                widthPerItem = availableWidth / itemsPerRow
        
        searchBarSetUp()
        navigationBarSetUp()
        reloadData()

    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(gifs.count)
        return gifs.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var cell = UICollectionViewCell()
                
        if let gifCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? CollectionViewCell {
            
            //MARK: - Image parameters
            let gifLink = gifs[indexPath.row].images.preview_gif.url
//            let gifLink = "https://media.giphy.com/media/UZ2dBB8zEtcX9j2ulo/giphy.gif"
            let gifURL = URL(string: gifLink)
            

                        
            //MARK: - Image size downsampling
//            let processor = DownsamplingImageProcessor(size: gifCell.gifImageView.bounds.size) |> RoundCornerImageProcessor(cornerRadius: 10)
//            let processor = ResizingImageProcessor(referenceSize: gifCell.gifImageView.bounds.size) |> RoundCornerImageProcessor(cornerRadius: 10)
            gifCell.gifImageView.kf.indicatorType = .activity
            gifCell.gifImageView.kf.setImage(with: gifURL, placeholder: nil, options: [
//                                .processor(processor),
                                .scaleFactor(scale),
                                .transition(.fade(0.7))], progressBlock: nil)
//            gifCell.gifImageView.kf.setImage(with: gifURL)
            
//            if gifCell.imageViewWidth.constant != widthPerItem {
//                gifCell.imageViewHeight.constant = widthPerItem
//                gifCell.imageViewWidth.constant = widthPerItem
//            }
            
            cell = gifCell
            
        }
        
        return cell
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("Text Change")
        reloadData(for: searchText)
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
      print("Available width: \(availableWidth), Width per item: \(widthPerItem)")

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
}

extension UIImage {
    func resized(to size: CGSize) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { _ in
            draw(in: CGRect(origin: .zero, size: .zero))
        }
    }
}
