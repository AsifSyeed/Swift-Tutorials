//
//  DynamicHeightViewModel.swift
//  DynamicCollectionView
//
//  Created by BS901 on 6/22/22.
//

import UIKit

class DynamicHeightViewModel: NSObject {
    
    private(set) var dataModel: [DynamicCollectionViewCellViewModel]!
    
    override init() {
        super.init()
    }
    
    convenience init(dataModel: [DynamicCollectionViewCellViewModel]) {
        self.init()
        self.dataModel = dataModel
    }
}

struct DynamicCollectionViewCellViewModel {
    var title: String
    var message: String
    var imageName: String
    
    init(title: String, message: String, imageName: String) {
        self.title = title
        self.message = message
        self.imageName = imageName
    }
    
    var image: UIImage? {
        return UIImage(named: imageName)
    }
}
