//
//  CollectionVIewExtension.swift
//  Gif Catalogue Application CollectionView/Users/karlis.stekels/Desktop/Gif Catalogue Application CollectionView/Gif Catalogue Application CollectionView/Model
//
//  Created by karlis.stekels on 19/04/2021.
//

import Foundation
import UIKit
extension CollectionViewController {
    //MARK: - SetUp
    func searchBarSetUp() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = true
        self.definesPresentationContext = true
    }
    
    func navigationBarSetUp() {
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Browse GIF images"

    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("Text Change")
        reloadData(for: searchText)
    }
    
    
    //MARK: - Data
    func reloadData(for searchText: String = "") {
        
        urlString = "https://api.giphy.com/v1/gifs/search?q=\(searchText)&api_key=jfm68wbEKZVLAAcD0Yh7k6Zqq1LcNfr9"
        
        if let url = URL(string: urlString) {
            print(url)
            if let data = try? Data(contentsOf: url) {
                parse(json: data)
                return
            }
        }
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func parse(json: Data) {
        let decoder = JSONDecoder()
        if let jsonGifs = try? decoder.decode(Gifs.self, from: json) {
            gifs = jsonGifs.data
            collectionView.reloadData()
        } else {
            print("Parsing Error")
        }
    }
    
    func getBorderColor() -> CGColor {
        
        let redNum = CGFloat(Double(Int.random(in: 0...9))/10)
        let greenNum = CGFloat(Double(Int.random(in: 0...9))/10)
        let blueNum = CGFloat(Double(Int.random(in: 0...9))/10)
        let alphaNum = CGFloat(Double(Int.random(in: 7...10))/10)
        
        let myColor = CGColor(red: redNum, green: greenNum, blue: blueNum, alpha: alphaNum)
        
        return myColor
    }
    
    func titleAnimation() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { (timer) in
            self.title = ""
            var charIndex = 0.0
            for letter in "GIF Catalogue App" {
                Timer.scheduledTimer(withTimeInterval: 0.02 * charIndex, repeats: false) { (timer) in
                    self.title?.append(letter)
                }
                charIndex += 1
            }
            
        }
    }
}

