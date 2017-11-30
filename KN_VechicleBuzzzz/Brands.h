//
//  Brands.h
//  KN_VechicleBuzzzz
//
//  Created by kunchal on 23/11/17.
//  Copyright © 2017 VNSoftech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BrandsCollectionViewCell.h"

@interface Brands : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionOBJ;
@property (weak, nonatomic) IBOutlet UITableView *brandsTable;


@end
