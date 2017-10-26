//
//  ViewAllProductsScreen.h
//  KN_VechicleBuzzzz
//
//  Created by kunchal on 14/10/17.
//  Copyright © 2017 VNSoftech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "viewAllTableViewCell.h"

@interface ViewAllProductsScreen : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *headerTitle;


- (IBAction)backButton:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *headerLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableObj;
@property NSMutableArray * viewAllProductArray;
@end
