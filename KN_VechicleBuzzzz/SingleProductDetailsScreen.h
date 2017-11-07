//
//  SingleProductDetailsScreen.h
//  KN_VechicleBuzzzz
//
//  Created by kunchal on 25/10/17.
//  Copyright © 2017 VNSoftech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFHTTPSessionManager.h"
#import "UIImageView+AFNetworking.h"
#import "singleTableCell.h"

@interface SingleProductDetailsScreen : UIViewController
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scorllHieght;

@property AFHTTPSessionManager * manager;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollVIEWobj;

@property NSMutableDictionary * singleDict;
@property NSString * vID,*Vcat;
@end
