//
//  homeScreen_VC.m
//  
//
//  Created by kunchal on 25/09/17.
//
//

#import "homeScreen_VC.h"
#import "SRCarouselView.h"

@interface homeScreen_VC () <SRCarouselViewDelegate>



@property SRCarouselView *carouselView;
@end

@implementation homeScreen_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString * homeURL = @"http://www.vehiclebuzzzz.com/index.php/JsonController/homepage";
    
    self.manager = [AFHTTPSessionManager manager];
    self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    [self.manager GET:homeURL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         self.homeResponseDict = responseObject ;
         NSLog(@"%@",_homeResponseDict);
         [self carouselViewWithLocalImages];

         
    }
    failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];

    
}

- (void)clearCachedImages {
    
    [SRCarouselImageManager clearCachedImages];
}

- (void)carouselViewWithLocalImages {
    
    
    NSMutableArray * bannerImagesArray = [[NSMutableArray alloc]init];
    
    for (NSString * bannerURL in [[self.homeResponseDict valueForKey:@"server_banerresponse"]valueForKey:@"baner"])
    {
        [bannerImagesArray addObject:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:bannerURL]]]];
        
    }
    
    self.carouselView = [SRCarouselView sr_carouselViewWithImageArrary:bannerImagesArray describeArray:nil placeholderImage:nil delegate:self];
    
    _carouselView.frame = CGRectMake(0, 0, self.view.frame.size.width, 150);
    _carouselView.autoPagingInterval = 3.0;
    
    self.scrollViewObj.contentInset = UIEdgeInsetsMake(-20, 0, 0, 0);
    [self.scrollViewObj addSubview:_carouselView];

    
    
}
- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    
    _carouselView.frame = CGRectMake(0, 0, self.view.frame.size.width, 150);
   // NSInteger i = (NSInteger)size;
    self.scrollViewObj.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    [self.scrollViewObj addSubview:_carouselView];
    NSLog(@"%f",size);

}


@end
