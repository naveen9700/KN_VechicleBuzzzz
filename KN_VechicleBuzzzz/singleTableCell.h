//
//  singleTableCell.h
//  KN_VechicleBuzzzz
//
//  Created by kunchal on 07/11/17.
//  Copyright © 2017 VNSoftech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface singleTableCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *enginelabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionlabel;
@property (weak, nonatomic) IBOutlet UILabel *originalpriceLabel;
@property (weak, nonatomic) IBOutlet UIButton *sellerDetailsButton;
@property (weak, nonatomic) IBOutlet UILabel *lastPriceLabel;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollViewObj;
@property (weak, nonatomic) IBOutlet UILabel *modelLabel;
- (IBAction)getEmibutton:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *benefitsButton;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@end
