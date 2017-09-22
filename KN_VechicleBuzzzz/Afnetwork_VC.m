


#import "Afnetwork_VC.h"

@interface Afnetwork_VC ()

@property NSDictionary * serverResponse;
@end

@implementation Afnetwork_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    

    self.manager=[[AFHTTPSessionManager alloc]init];
    
    self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    

}

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
         //NSLog(@"%@",_serverResponse);
         
         
         
        
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
    
    __block NSDictionary * serverResponse;
    
    self.manager=[[AFHTTPSessionManager alloc]init];
    
    self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    
    [self.manager GET:url parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject)
     {
         
         serverResponse = (NSDictionary *)responseObject;
         //NSLog(@"%@",serverResponse);
     }
     
    failure:^(NSURLSessionTask* operation, NSError* error)
     
     {
         NSLog(@"Error: %@", error);
     }];
    
    return serverResponse;
    
}




@end
