//
//  customTableCell.m
//  KN_VechicleBuzzzz
//
//  Created by kunchal on 04/10/17.
//  Copyright © 2017 VNSoftech. All rights reserved.
//

#import "customTableCell.h"
#import "UIImageView+AFNetworking.h"
#import "ViewAllProductsScreen.h"
#import "homeScreen_VC.h"


@implementation customTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.homeCollectionObj.delegate = self;
    self.homeCollectionObj.dataSource = self;
    [self.homeCollectionObj setShowsHorizontalScrollIndicator:NO];
    
    //NSLog(@"%@",self.productDtlsCollectionArray);
}


-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    
    
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section

{
    
    
         return [[self.productDtlsCollectionArray objectAtIndex:self.tableSection]count];
    
   
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    customCollectionCell*ccell = [collectionView dequeueReusableCellWithReuseIdentifier:@"customCollectionCell" forIndexPath:indexPath];
    
    NSString *url_Img1 = @"http://vehiclebuzzzz.com/";
    NSString *url_Img2 = [[[self.productDtlsCollectionArray objectAtIndex:self.tableSection] objectAtIndex:indexPath.row]valueForKey:@"img_name"];
    
    NSString *url_Img_FULL = [url_Img1 stringByAppendingPathComponent:url_Img2];
    
   // NSLog(@"Show url_Img_FULL: %@",url_Img_FULL);
    
    
    [ccell.collectionImage setImageWithURL:[NSURL URLWithString:url_Img_FULL] placeholderImage:[UIImage imageNamed:@"logo.png"]];
    ccell.productName.text = [[[self.productDtlsCollectionArray objectAtIndex:self.tableSection] objectAtIndex:indexPath.row]valueForKey:@"p_name"];
    
    NSNumber* my = [NSNumber numberWithInt:[[[[self.productDtlsCollectionArray objectAtIndex:self.tableSection] objectAtIndex:indexPath.row]valueForKey:@"price"]intValue]];
    
    NSNumberFormatter *currencyFormatter = [[NSNumberFormatter alloc] init];
    [currencyFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    [currencyFormatter setMaximumFractionDigits:0];
    [currencyFormatter setCurrencySymbol:@""];
    [currencyFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_IN"]];
    
    ccell.productPrice.text = [NSString stringWithFormat:@"₹%@",[currencyFormatter stringFromNumber:my]];
    
    ccell.productFuelType.text =[[[self.productDtlsCollectionArray objectAtIndex:self.tableSection] objectAtIndex:indexPath.row]valueForKey:@"fueltype"];
    
    
    ccell.layer.borderWidth=1.0f;
    ccell.layer.borderColor=[UIColor lightGrayColor].CGColor;
    return ccell;
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    [self.delegate collectionData:[[self.productDtlsCollectionArray objectAtIndex:self.tableSection] objectAtIndex:indexPath.row]];
    
}

@end

