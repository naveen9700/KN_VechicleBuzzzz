//
//  viewAllTableViewCell.h
//  KN_VechicleBuzzzz
//
//  Created by kunchal on 25/10/17.
//  Copyright © 2017 VNSoftech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface viewAllTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageObj;
- (IBAction)getSellerDetailsButton:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *fuelType;
@property (weak, nonatomic) IBOutlet UILabel *discount;

@property (weak, nonatomic) IBOutlet UILabel *vechicleName;
@end
