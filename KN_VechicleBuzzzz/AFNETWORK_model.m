//
//  AFNETWORK_model.m
//  KN_VechicleBuzzzz
//
//  Created by kunchal on 21/09/17.
//  Copyright © 2017 VNSoftech. All rights reserved.
//

#import "AFNETWORK_model.h"

@implementation AFNETWORK_model



// Post Method

-(NSDictionary *)postMethodURl:(NSString *)url
                    parameters:(NSDictionary *)params
{
    
    //__block NSDictionary * serverResponse;
    
    
    self.manager=[[AFHTTPSessionManager alloc]init];
    
    self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    
    [self.manager POST:url parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject)
             {
                 
                 self.serverResponse = (NSDictionary *)responseObject;
                 NSLog(@"%@",self.serverResponse);
                 
             }
             
            failure:^(NSURLSessionTask* operation, NSError* error)
             
             {
                 NSLog(@"Error: %@", error);
             }];
    
    return self.serverResponse;
    
}


// GET method URL

-(NSDictionary *)getMethodURl:(NSString *)url

{
    
    
    
    self.manager=[[AFHTTPSessionManager alloc]init];
    
    self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    
    [self.manager GET:url parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         
         self.serverResponse = (NSDictionary *)responseObject;
        // NSLog(@"%@",self.serverResponse);
         
         
     }
     
    failure:^(NSURLSessionTask* operation, NSError* error)
     
     {
         NSLog(@"Error: %@", error);
     }];
    
    return self.serverResponse;
    
}







@end
