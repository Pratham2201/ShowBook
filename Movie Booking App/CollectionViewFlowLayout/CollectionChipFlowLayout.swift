//
//  CollectionCarouselFlowLayout.swift
//  MARKETS
//
//  Created by Shailesh Prabhudesai on 25/09/20.
//

import UIKit

final class Row {
    var attributes = [UICollectionViewLayoutAttributes]()
    var spacing: CGFloat = 0

    init(spacing: CGFloat) {
        self.spacing = spacing
    }

    func add(attribute: UICollectionViewLayoutAttributes) {
        attributes.append(attribute)
    }

    func tagLayout(collectionViewWidth: CGFloat) {
        let padding = 15
        var offset = padding
        for attribute in attributes {
            attribute.frame.origin.x = CGFloat(offset)
            offset += Int(attribute.frame.width + spacing)
        }
    }
}

class CollectionChipFlowLayout: UICollectionViewFlowLayout {
    
    override var collectionViewContentSize: CGSize {
        get {
            return contentBounds.size
        }
    }
    
    var contentBounds: CGRect = .zero
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let attributes = super.layoutAttributesForElements(in: rect) else {
            return nil
        }
        contentBounds = CGRect(origin: .zero, size: collectionView?.bounds.size ?? .zero)
        var rows = [Row]()
        var currentRowY: CGFloat = -1

        for attribute in attributes {
            if currentRowY != attribute.frame.origin.y {
                currentRowY = attribute.frame.origin.y
                rows.append(Row(spacing: 10))
            }
            rows.last?.add(attribute: attribute)
            
        }

        rows.forEach { $0.tagLayout(collectionViewWidth: collectionView?.frame.width ?? 0) }
        
        rows.forEach {
            contentBounds = contentBounds.union($0.attributes.last?.frame ?? .zero) 
        }
        
        return rows.flatMap { $0.attributes }
    }
}
