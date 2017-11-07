//
//  SingleProductDetailsScreen.m
//  KN_VechicleBuzzzz
//
//  Created by kunchal on 25/10/17.
//  Copyright © 2017 VNSoftech. All rights reserved.
//

#import "SingleProductDetailsScreen.h"
#import "TAPageControl.h"

@interface SingleProductDetailsScreen ()<UIScrollViewDelegate, TAPageControlDelegate>
{
    NSTimer *timer;
    NSInteger index;
    NSMutableArray * singleProductArr;
}
@property (strong, nonatomic) TAPageControl *customPageControl2;

@property (strong, nonatomic) NSArray *imagesData;

@end

@implementation SingleProductDetailsScreen

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
}
-(void)viewWillAppear:(BOOL)animated
{
    
    
    timer=[NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(runImages) userInfo:nil repeats:YES];
    
    NSString * homeURL = @"http://www.vehiclebuzzzz.com/index.php/JsonController/vehicledtls";
    NSDictionary *params = @{@"veh_id":self.vID,@"veh_category":self.Vcat};
    
    self.manager = [AFHTTPSessionManager manager];
    self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    [self.manager POST:homeURL parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         
         singleProductArr = responseObject;
         //NSLog(@"%lu",[[[[responseObject valueForKey:@"server_vehicledtlsresponse"]valueForKey:@"veh_dtls"] valueForKey:@"image_path"]count]);
         [self scrollImages];
     }
              failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                  
              }];
    
}

-(void)scrollImages
{
    
    NSString *url = [[[singleProductArr valueForKey:@"server_vehicledtlsresponse"]valueForKey:@"veh_dtls"] valueForKey:@"image_path"];
    self.imagesData = [url componentsSeparatedByString:@"$$$"];
    
    NSLog(@"%li",self.imagesData.count);
    for(int i=0; i<self.imagesData.count;i++){
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.view.frame) * i, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.scrollVIEWobj.frame))];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.image = [UIImage imageNamed:[self.imagesData objectAtIndex:i]];
        [self.scrollVIEWobj addSubview:imageView];
    }
    self.scrollVIEWobj.delegate = self;
    index=0;
    
    
    // Progammatically init a TAPageControl with a custom dot view.
    self.customPageControl2 = [[TAPageControl alloc] initWithFrame:CGRectMake(20,self.scrollVIEWobj.frame.origin.y+self.scrollVIEWobj.frame.size.height,self.scrollVIEWobj.frame.size.width,40)];//CGRectMake(0, CGRectGetMaxY(self.scrollView.frame) - 100, CGRectGetWidth(self.scrollView.frame), 40)
    // Example for touch bullet event
    self.customPageControl2.delegate      = self;
    self.customPageControl2.numberOfPages = self.imagesData.count;
    self.customPageControl2.dotSize       = CGSizeMake(20, 20);
    self.scrollVIEWobj.contentSize = CGSizeMake(CGRectGetWidth(self.view.frame) * self.imagesData.count, CGRectGetHeight(self.scrollVIEWobj.frame));
    [self.view addSubview:self.customPageControl2];
}




-(void)viewDidDisappear:(BOOL)animated{
    if (timer) {
        [timer invalidate];
        timer=nil;
    }
}

-(void)runImages{
    self.customPageControl2.currentPage=index;
    if (index==self.imagesData.count-1) {
        index=0;
    }else{
        index++;
    }
    [self TAPageControl:self.customPageControl2 didSelectPageAtIndex:index];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    
}

#pragma mark - ScrollView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger pageIndex = scrollView.contentOffset.x / CGRectGetWidth(scrollView.frame);
    self.customPageControl2.currentPage = pageIndex;
    index=pageIndex;
}
// Example of use of delegate for second scroll view to respond to bullet touch event
- (void)TAPageControl:(TAPageControl *)pageControl didSelectPageAtIndex:(NSInteger)currentIndex
{
    index=currentIndex;
    [self.scrollVIEWobj scrollRectToVisible:CGRectMake(CGRectGetWidth(self.view.frame) * currentIndex, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.scrollVIEWobj.frame)) animated:YES];
}


- (IBAction)backbutton:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    
}

@end
