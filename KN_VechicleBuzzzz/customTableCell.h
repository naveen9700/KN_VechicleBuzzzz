//
//  customTableCell.h
//  KN_VechicleBuzzzz
//
//  Created by kunchal on 04/10/17.
//  Copyright © 2017 VNSoftech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "customCollectionCell.h"
#import <QuartzCore/QuartzCore.h>
#import "myProtocol.h"


@interface customTableCell : UITableViewCell<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *homeCollectionObj;

@property NSMutableArray * productDtlsCollectionArray;
@property NSMutableArray * singleProductArray;
@property NSInteger tableSection;
@property NSInteger segmentCount;
@property id<myProtocol>delegate;
@end
