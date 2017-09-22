//
//  Afnetwork_VC.h
//  KN_VechicleBuzzzz
//
//  Created by VNSoftech on 14/09/17.
//  Copyright © 2017 VNSoftech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"

@interface Afnetwork_VC : UIViewController

@property AFHTTPSessionManager *manager;


-(NSDictionary *)postMethodURl:(NSString *)url
                    parameters:(NSDictionary *)params;

-(NSDictionary *)getMethodURl:(NSString *)url;




@end
