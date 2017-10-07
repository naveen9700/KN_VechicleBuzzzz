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
    
    self.headersArray = [[NSMutableArray alloc]init];
    
    self.productDtlsArray = [[NSMutableArray alloc]init];
    
    
  

    
}
-(void)viewWillAppear:(BOOL)animated
{
    NSString * homeURL = @"http://www.vehiclebuzzzz.com/index.php/JsonController/homepage";
    
    self.manager = [AFHTTPSessionManager manager];
    self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    [self.manager GET:homeURL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         self.homeResponseDict = responseObject ;
         NSLog(@"%@",_homeResponseDict);
         [self carouselViewWithLocalImages];
         self.serverResponse = responseObject;
         [self tableViewDataReloading];
         
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
    //NSLog(@"%f",size);

}



-(void)tableViewDataReloading
{
    for (int i = 0; i<[[self.serverResponse valueForKey:@"server_productresponse"]count];i++)
    {
        
        
        if ([[[[self.serverResponse valueForKey:@"server_productresponse"]objectAtIndex:i]valueForKey:@"veh_status"]isEqualToString:@"1"])
        {
            [self.headersArray addObject:[[[self.serverResponse valueForKey:@"server_productresponse"]objectAtIndex:i]valueForKey:@"category"]];
            
            [self.productDtlsArray addObject:[[[self.serverResponse valueForKey:@"server_productresponse"]objectAtIndex:i]valueForKey:@"product_dtls"]];
            
            
        }
        
        
    }
    
    NSLog(@"%@",[self.productDtlsArray objectAtIndex:1]);
    [self.homeScreenTableObj reloadData];
    [self.homeScreenTableObj setShowsVerticalScrollIndicator:NO];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 160;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    
    return self.headersArray.count;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    
    
    return [self.headersArray objectAtIndex:section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    
    return 40.0;
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView* headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
    headerView.backgroundColor = [UIColor blueColor];
    
    UIButton * headerBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    headerBtn.backgroundColor = [UIColor clearColor];
    headerBtn.opaque = NO;
    headerBtn.frame = CGRectMake(self.view.frame.size.width-120, 5, 100.0, 30.0);
    [headerBtn setTitle:@"View All" forState:UIControlStateNormal];
    [headerBtn addTarget:self action:@selector(ActionEventForHeaderButton:) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:headerBtn];
    
    return headerView;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    customTableCell * cell = [tableView dequeueReusableCellWithIdentifier:@"customTableCell"];
    cell.productDtlsCollectionArray = self.productDtlsArray;
    cell.singleProductArray = [self.productDtlsArray objectAtIndex:indexPath.section];
    cell.tableSection = indexPath.section;
    NSLog(@"%lu",indexPath.section);
    [cell.homeCollectionObj reloadData];
    return cell;
    
}

-(void)ActionEventForHeaderButton:(id)sender
{
    
    
    NSLog(@"button pressed");
}




@end
