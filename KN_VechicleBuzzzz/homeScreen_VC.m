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

@end

@implementation homeScreen_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self carouselViewWithLocalImages];
    
}

- (void)clearCachedImages {
    
    [SRCarouselImageManager clearCachedImages];
}

- (void)carouselViewWithLocalImages {
    
    NSArray *imageArray = @[[UIImage imageNamed:@"logo.png"],
                            [UIImage imageNamed:@"logo.png"],
                            ];
    NSMutableArray *describeArray = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < imageArray.count; i++) {
        NSString *tempDesc = [NSString stringWithFormat:@"Image Description %zd", i + 1];
        [describeArray addObject:tempDesc];
    }
    SRCarouselView *carouselView = [SRCarouselView sr_carouselViewWithImageArrary:imageArray describeArray:nil placeholderImage:nil delegate:self];
    carouselView.frame = CGRectMake(0, 100, self.view.frame.size.width, 150);
    carouselView.autoPagingInterval = 10.0;
    [self.view addSubview:carouselView];
}


@end
