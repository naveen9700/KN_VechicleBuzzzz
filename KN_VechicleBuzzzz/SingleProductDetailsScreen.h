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
- (IBAction)getEMIButton:(UIButton *)sender;

- (IBAction)benefitsButton:(UIButton *)sender;
- (IBAction)sellerDetailsButton:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UILabel *modelLabel;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *originalPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *engineLabel;
@property (weak, nonatomic) IBOutlet UILabel *featuresLabel;
@property (strong, nonatomic) IBOutlet UIView *getEmiView;
@property (strong, nonatomic) IBOutlet UIView *getSellerView;

@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIView *popViewobj;
@property (strong, nonatomic) IBOutlet UIView *benifitsView;
- (IBAction)popUpCancelbtn:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *benenifitsBtn;
- (IBAction)benenifitsbtn:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *realdescriptionLabel;
- (IBAction)getSellerBtn:(UIButton *)sender;
@property UIView * popUpView;
@end
