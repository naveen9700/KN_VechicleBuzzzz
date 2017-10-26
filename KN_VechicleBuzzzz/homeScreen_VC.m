

#import "homeScreen_VC.h"
#import "SRCarouselView.h"
#import "customTableCell.h"
#import "ViewAllProductsScreen.h"

@interface homeScreen_VC () <SRCarouselViewDelegate>

@property  UIView* headerView,*bannerHeaderview;
@property  UILabel *sectionHeaderLabel;
@property UIButton * headerBtn;


@property SRCarouselView *carouselView;
@end

@implementation homeScreen_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.headersArray = [[NSMutableArray alloc]init];
    self.usedProductDtlsArray = [[NSMutableArray alloc]init];

    
    self.NewProductDtlsArray = [[NSMutableArray alloc]init];
    self.vechicleStatusSegment.selectedSegmentIndex=0;
    
    

    
}
-(void)viewWillAppear:(BOOL)animated
{
    NSString * homeURL = @"http://www.vehiclebuzzzz.com/index.php/JsonController/homepage";
    
    self.manager = [AFHTTPSessionManager manager];
    self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    [self.manager GET:homeURL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         self.homeResponseDict = responseObject ;
        // NSLog(@"%@",_homeResponseDict);
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
    
    
    self.bannerHeaderview = [[UIView alloc]initWithFrame:(CGRectMake(0, 0, self.homeScreenTableObj.bounds.size.width, 160))];
    
    //self.homeScreenTableObj.tableHeaderView = self.headerView;
    NSMutableArray * bannerImagesArray = [[NSMutableArray alloc]init];
    
    for (NSString * bannerURL in [[self.homeResponseDict valueForKey:@"server_banerresponse"]valueForKey:@"baner"])
    {
        [bannerImagesArray addObject:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:bannerURL]]]];
        
    }
    
    self.carouselView = [SRCarouselView sr_carouselViewWithImageArrary:bannerImagesArray describeArray:nil placeholderImage:[UIImage imageNamed:@"placeHolder"] delegate:self];
    
    _carouselView.frame = CGRectMake(0, 0, self.bannerHeaderview.frame.size.width, 160);
    _carouselView.autoPagingInterval = 3.0;
    
    self.bannerHeaderview.backgroundColor = [UIColor whiteColor];
    [self.bannerHeaderview addSubview:_carouselView];
    self.homeScreenTableObj.tableHeaderView = self.bannerHeaderview;
    
    

    
    
}

-(void)tableViewDataReloading
{
    for (int i = 0; i<[[self.serverResponse valueForKey:@"server_productresponse"]count];i++)
    {
     
        if ([[[[self.serverResponse valueForKey:@"server_productresponse"]objectAtIndex:i]valueForKey:@"veh_status"]isEqualToString:@"1"])
        {
            [self.headersArray addObject:[[[self.serverResponse valueForKey:@"server_productresponse"]objectAtIndex:i]valueForKey:@"category"]];
            
            [self.NewProductDtlsArray addObject:[[[self.serverResponse valueForKey:@"server_productresponse"]objectAtIndex:i]valueForKey:@"product_dtls"]];
  
        }
        else
        {
           [self.usedProductDtlsArray addObject:[[[self.serverResponse valueForKey:@"server_productresponse"]objectAtIndex:i]valueForKey:@"product_dtls"]];
        }
      
    }
    
   // NSLog(@"%@",[self.NewProductDtlsArray objectAtIndex:1]);
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
    if (self.vechicleStatusSegment.selectedSegmentIndex==0)
    {
        return 1;
        
    }
    else
    {
        if ([[[self.usedProductDtlsArray objectAtIndex:1] valueForKey:@"product_dtls"]count]==0)
        {
            return 0;
        }
        return 1;
    }
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
   
    return [self.headersArray objectAtIndex:section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if ([[self.NewProductDtlsArray valueForKey:@"product_dtls"]objectAtIndex:section]==nil || [[[self.NewProductDtlsArray valueForKey:@"product_dtls"]objectAtIndex:section]count]==0)
    {
        return 0;
    }
    else
    {
       return 40.0;
    }
 
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    // intializing the custom header view for Table view
    self. headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.homeScreenTableObj.frame.size.width, 40)];
    self.headerView.backgroundColor = [UIColor blueColor ];
   
    // intializing the customLabel header  for Table view
    
    self.sectionHeaderLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 5, 100, 30)];
    self.sectionHeaderLabel.textColor = [UIColor whiteColor];
    self.sectionHeaderLabel.font = [UIFont systemFontOfSize:20];
    
    self.headerBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    self. headerBtn.backgroundColor = [UIColor clearColor];
    self.headerBtn.opaque = NO;
    self. headerBtn.frame = CGRectMake(self.view.frame.size.width-120, 5, 100.0, 30.0);
    self.headerBtn.tag = section;
    [self.headerBtn setTitle:@"View All" forState:UIControlStateNormal];

    self.sectionHeaderLabel.text =[self.headersArray objectAtIndex:section];
    [self.headerBtn addTarget:self action:@selector(ActionEventForHeaderButton:) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.sectionHeaderLabel.text =[self.headersArray objectAtIndex:section];
    [self.headerView addSubview:self.sectionHeaderLabel];
    [self.headerView addSubview:self.headerBtn];


    return self.headerView;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    customTableCell * cell = [tableView dequeueReusableCellWithIdentifier:@"customTableCell"];
    
    if (self.vechicleStatusSegment.selectedSegmentIndex ==0)
    {
        cell.productDtlsCollectionArray = self.NewProductDtlsArray;
    }
    else
    {
        cell.productDtlsCollectionArray = self.usedProductDtlsArray;

    }
    
    cell.tableSection = indexPath.section;
    NSLog(@"%lu",indexPath.section);
    
    [cell.homeCollectionObj reloadData];
    cell.delegate = self;
    return cell;
    
}

-(void)ActionEventForHeaderButton:(UIButton *)sender
{
    NSLog(@" tag %lu",sender.tag);
    
    
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main"   bundle:nil];
    ViewAllProductsScreen *vc = [storyboard instantiateViewControllerWithIdentifier:@"ViewAllProductsScreen" ];
    vc.viewAllProductArray = [self.NewProductDtlsArray objectAtIndex:sender.tag];

    [self presentViewController:vc animated:YES completion:Nil];
    
}

- (IBAction)vechicleStatusSegment:(id)sender
{
    customTableCell * cell = [[customTableCell alloc ]init];
    if (self.vechicleStatusSegment.selectedSegmentIndex==0)
    {
        cell.segmentCount=1;
        //NSLog(@"%li",cell.segmentCount);
        
        [self.homeScreenTableObj reloadData];
        
    }
    else if(self.vechicleStatusSegment.selectedSegmentIndex==1)
        {
            
            cell.segmentCount=0;
            //NSLog(@"%li",cell.segmentCount);

            [self.homeScreenTableObj reloadData];
            
        }
    
}

-(void)collectionData:(NSArray *)collectionArr
{
    
    //NSLog(@"%@",collectionArr);
    
    
}

- (void)didTapCarouselViewAtIndex:(NSInteger)index {
    
}

@end
