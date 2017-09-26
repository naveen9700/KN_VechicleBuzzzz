//
//  homeScreen_VC.h
//  
//
//  Created by kunchal on 25/09/17.
//
//

#import <UIKit/UIKit.h>
#import <AFNetworking/AFNetworking.h>


@interface homeScreen_VC : UIViewController
@property (weak, nonatomic) IBOutlet UIScrollView *scrollViewObj;

@property AFHTTPSessionManager * manager;
@property NSMutableDictionary * homeResponseDict;

@end
