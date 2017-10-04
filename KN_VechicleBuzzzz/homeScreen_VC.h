//
//  homeScreen_VC.h
//  
//
//  Created by kunchal on 25/09/17.
//
//

#import <UIKit/UIKit.h>
#import <AFNetworking/AFNetworking.h>
#import "customTableCell.h"


@interface homeScreen_VC : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollViewObj;

@property AFHTTPSessionManager * manager;
@property NSMutableDictionary * homeResponseDict;
@property NSMutableDictionary * serverResponse;
@property (weak, nonatomic) IBOutlet UITableView *homeScreenTableObj;
@property NSMutableArray * productDtlsArray;
@property NSMutableArray * headersArray;
@end
