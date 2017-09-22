//
//  AFNETWORK_model.h
//  KN_VechicleBuzzzz
//
//  Created by kunchal on 21/09/17.
//  Copyright © 2017 VNSoftech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface AFNETWORK_model : NSObject







@property AFHTTPSessionManager *manager;
@property NSDictionary * serverResponse;


-(NSDictionary *)postMethodURl:(NSString *)url
                    parameters:(NSDictionary *)params;

-(NSDictionary *)getMethodURl:(NSString *)url;


@end
