//
//  customCollectionCell.h
//  KN_VechicleBuzzzz
//
//  Created by kunchal on 04/10/17.
//  Copyright © 2017 VNSoftech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface customCollectionCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *productFuelType;
@property (weak, nonatomic) IBOutlet UILabel *productPrice;
@property (weak, nonatomic) IBOutlet UIImageView *collectionImage;
@property (weak, nonatomic) IBOutlet UILabel *productName;

@end
