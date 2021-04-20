//
//  Gif.swift
//  Gif Catalogue Application CollectionView
//
//  Created by karlis.stekels on 19/04/2021.
//

import Foundation
import Foundation
struct Gif: Codable {
    struct Image: Codable {
        struct Preview: Codable {
            var url: String
        }
        var preview_gif: Preview
    }
    var title: String
    var images: Image
}
