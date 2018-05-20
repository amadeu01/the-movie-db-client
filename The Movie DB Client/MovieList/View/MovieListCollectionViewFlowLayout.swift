//
//  MovieList.swift
//  The Movie DB Client
//
//  Created by Amadeu Cavalcante on 19/05/2018.
//  Copyright © 2018 Amadeu Cavalcante Filho. All rights reserved.
//

import UIKit

class MovieListCollectionViewFlowLayout: UICollectionViewFlowLayout {
	@IBInspectable var placeEqualSpaceAroundAllCells: Bool = true
	
	override func prepare() {
		super.prepare()
		if self.placeEqualSpaceAroundAllCells {
			
			var contentByItems: ldiv_t
			
			let contentSize: CGSize = self.collectionViewContentSize
			let itemSize = self.itemSize
			
			if self.scrollDirection == .vertical {
				contentByItems = ldiv(Int(contentSize.width), Int(itemSize.width))
			} else {
				contentByItems = ldiv(Int(contentSize.height), Int(itemSize.height))
			}
			
			let layoutSpacingValue: CGFloat =
				CGFloat(NSInteger(CGFloat(contentByItems.rem) / CGFloat(contentByItems.quot + 1)))
			
			let originalMinimumLineSpacing = self.minimumLineSpacing
			let originalMinimumInteritemSpacing = self.minimumInteritemSpacing
			let originalSectionInset = self.sectionInset
			
			if layoutSpacingValue != originalMinimumLineSpacing ||
				layoutSpacingValue != originalMinimumInteritemSpacing ||
				layoutSpacingValue != originalSectionInset.left ||
				layoutSpacingValue != originalSectionInset.right ||
				layoutSpacingValue != originalSectionInset.top ||
				layoutSpacingValue != originalSectionInset.bottom {
				
				let insetsForItem = UIEdgeInsets.init(
					top: layoutSpacingValue,
					left: layoutSpacingValue,
					bottom: layoutSpacingValue,
					right: layoutSpacingValue
				)
				
				self.minimumLineSpacing = layoutSpacingValue
				self.minimumInteritemSpacing = layoutSpacingValue
				self.sectionInset = insetsForItem
			}
			
		}
	}
		
}
