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

@property (strong, nonatomic) NSMutableArray *imagesData;

@end

@implementation SingleProductDetailsScreen

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
}
-(void)viewWillAppear:(BOOL)animated
{
    
    self.scorllHieght.constant = 1000;
    timer=[NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(runImages) userInfo:nil repeats:YES];
    
    NSString * homeURL = @"http://www.vehiclebuzzzz.com/index.php/JsonController/vehicledtls";
    NSDictionary *params = @{@"veh_id":self.vID,@"veh_category":self.Vcat};
    
    self.manager = [AFHTTPSessionManager manager];
    self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    [self.manager POST:homeURL parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         
         singleProductArr = responseObject;
         NSLog(@"%@",singleProductArr);
         [self scrollImages];
     }
        failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                  
        }];
    
}

-(void)scrollImages
{
    self.imagesData = [[NSMutableArray alloc]init];
    NSString *url = [NSString stringWithFormat:@"%@",[[[[singleProductArr valueForKey:@"server_vehicledtlsresponse"] valueForKey:@"veh_dtls"] objectAtIndex:0]valueForKey:@"image_path"]];
    
    NSArray * arr = [url componentsSeparatedByString:@"$$$"];
    for (NSString * str in arr)
    {
        NSString *url_Img1 = @"http://vehiclebuzzzz.com/";

        NSString *url_Img_FULL = [url_Img1 stringByAppendingPathComponent:str];
        [self.imagesData addObject:url_Img_FULL];
    }

    
    for(int i=0; i<self.imagesData.count;i++)
    {
        NSLog(@"%@",[self.imagesData objectAtIndex:i]);
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.view.frame) * i, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.scrollVIEWobj.frame))];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        [imageView setImageWithURL:[NSURL URLWithString:[self.imagesData objectAtIndex:i]]];
        [self.scrollVIEWobj addSubview:imageView];
    }
    self.scrollVIEWobj.delegate = self;
    index=0;
    
    
    // Progammatically init a TAPageControl with a custom dot view.
    self.customPageControl2 = [[TAPageControl alloc] initWithFrame:CGRectMake(20,self.scrollVIEWobj.frame.origin.y+self.scrollVIEWobj.frame.size.height,self.scrollVIEWobj.frame.size.width,40)];

    // Example for touch bullet event
    self.customPageControl2.delegate      = self;
    self.customPageControl2.numberOfPages = self.imagesData.count;
    self.customPageControl2.dotSize       = CGSizeMake(20, 20);
    self.scrollVIEWobj.contentSize = CGSizeMake(CGRectGetWidth(self.view.frame) * self.imagesData.count, CGRectGetHeight(self.scrollVIEWobj.frame));
    [self.view addSubview:self.customPageControl2];
    
    
    NSNumberFormatter *currencyFormatter = [[NSNumberFormatter alloc] init];
    [currencyFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    [currencyFormatter setMaximumFractionDigits:0];
    [currencyFormatter setCurrencySymbol:@""];
    [currencyFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_IN"]];
    
    NSNumber* my1 = [NSNumber numberWithInt:[[[[[singleProductArr valueForKey:@"server_vehicledtlsresponse"]valueForKey:@"veh_dtls"]objectAtIndex:0] valueForKey:@"oorrice"]intValue]];
    
    NSNumber* my = [NSNumber numberWithInt:[[[[[singleProductArr valueForKey:@"server_vehicledtlsresponse"]valueForKey:@"veh_dtls"]objectAtIndex:0] valueForKey:@"oprice"]intValue]];
    
    self.priceLabel.text = [NSString stringWithFormat:@"₹%@",[currencyFormatter stringFromNumber:my]];
    
    
    self.originalPriceLabel.text = [NSString stringWithFormat:@"₹%@",[currencyFormatter stringFromNumber:my1]];
    
    self.nameLabel.text =[[[[singleProductArr valueForKey:@"server_vehicledtlsresponse"]valueForKey:@"veh_dtls"]objectAtIndex:0] valueForKey:@"vehname"];
     self.modelLabel.text =[[[[singleProductArr valueForKey:@"server_vehicledtlsresponse"]valueForKey:@"veh_dtls"]objectAtIndex:0] valueForKey:@"modelnm"];
    
    
    self.realdescriptionLabel.text =[NSString stringWithFormat:@"%@",[[[[singleProductArr valueForKey:@"server_vehicledtlsresponse"]valueForKey:@"veh_dtls"]objectAtIndex:0] valueForKey:@"discbody"]];
    
    
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

- (IBAction)getEMIButton:(UIButton *)sender
{
    [self popUPView:self.getEmiView];
    
}

- (IBAction)benefitsButton:(UIButton *)sender
{
    [self popUPView:self.benifitsView];

}

- (IBAction)sellerDetailsButton:(UIButton *)sender
{
    [self popUPView:self.getSellerView];

}

- (void)popUPView:(UIView *)viewobj
{
    {
        viewobj.frame = CGRectMake(20, -350,self.view.frame.size.width - 40,0);
        viewobj.hidden = NO;
        [self.view addSubview:viewobj];
        [UIView animateWithDuration:1.0 animations:^{
            
           viewobj.layer.shadowOpacity = 0.2;
            viewobj.layer.masksToBounds = NO;
            viewobj.layer.shadowOpacity = 0.5;
            viewobj.frame = CGRectMake(20, 140,self.view.frame.size.width - 40,300);
            viewobj.layer.cornerRadius = 8.0;
       viewobj.layer.borderColor = [[UIColor colorWithRed:17/255.0 green:67/255.0 blue:114/255.0 alpha:1.0]CGColor];
            
        }
                         completion:^(BOOL finished)
         {
             
         }];
        
    }
}



- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touches began");
    UITouch *touch = [touches anyObject];
//    if(touch.view!=self.getEmiView){
//        self.getEmiView.hidden = YES;
//        self.benifitsView.hidden = YES;
//
//        self.getSellerView.hidden = YES;
//
//
//    }
    
}

- (IBAction)popUpCancelbtn:(UIButton *)sender
{
    
    self.getEmiView.hidden = YES;

}
- (IBAction)getSellerBtn:(UIButton *)sender
{
    
    self.getSellerView.hidden = YES;

}
- (IBAction)benenifitsbtn:(UIButton *)sender
{
  self.benifitsView.hidden = YES;

}
@end
