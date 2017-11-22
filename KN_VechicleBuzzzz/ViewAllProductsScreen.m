//
//  ViewAllProductsScreen.m
//  KN_VechicleBuzzzz
//
//  Created by kunchal on 14/10/17.
//  Copyright © 2017 VNSoftech. All rights reserved.
//

#import "ViewAllProductsScreen.h"
#import "UIImageView+AFNetworking.h"
#import "SingleProductDetailsScreen.h"




@interface ViewAllProductsScreen ()

@end

@implementation ViewAllProductsScreen

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    
    if (self.viewAllProductArray.count==0)
    {
        [self alertMessage:@"NO data To Display"];
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.headerTitle.text = [[self.viewAllProductArray objectAtIndex:0]valueForKey:@"p_type"];
    return 200;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return  self.viewAllProductArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    viewAllTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"viewAllTableViewCell"];
    
    NSString *url_Img1 = @"http://vehiclebuzzzz.com/";
    NSString *url_Img2 = [[self.viewAllProductArray objectAtIndex:indexPath.row]valueForKey:@"img_name"];
    
    NSString *url_Img_FULL = [url_Img1 stringByAppendingPathComponent:url_Img2];

    
    [cell.imageObj setImageWithURL:[NSURL URLWithString:url_Img_FULL] placeholderImage:[UIImage imageNamed:@"logo.png"]];
    
    NSNumber* my = [NSNumber numberWithInt:[[[self.viewAllProductArray objectAtIndex:indexPath.row]valueForKey:@"price"]intValue]];
    
    NSNumberFormatter *currencyFormatter = [[NSNumberFormatter alloc] init];
    [currencyFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    [currencyFormatter setMaximumFractionDigits:0];
    [currencyFormatter setCurrencySymbol:@""];
    [currencyFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_IN"]];
    
    cell.price.text = [NSString stringWithFormat:@"₹%@",[currencyFormatter stringFromNumber:my]];
    
    cell.fuelType.text =[[self.viewAllProductArray objectAtIndex:indexPath.row]valueForKey:@"fueltype"];
    cell.discount.text = [[self.viewAllProductArray objectAtIndex:indexPath.row]valueForKey:@"discount"];
    
    cell.vechicleName.text = [[self.viewAllProductArray objectAtIndex:indexPath.row]valueForKey:@"p_name"];
    
    
    return  cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SingleProductDetailsScreen * spds = [self.storyboard instantiateViewControllerWithIdentifier:@"SingleProductDetailsScreen"];
    spds.vID =  [[self.viewAllProductArray objectAtIndex:indexPath.row]valueForKey:@"p_id"];
    
    spds.Vcat =[[self.viewAllProductArray objectAtIndex:indexPath.row]valueForKey:@"p_type"] ;
    
    [self.navigationController pushViewController:spds animated:YES];
    
    
    
}
-(void)alertMessage:(NSString*)message
{
    UIAlertController *alert1 = [UIAlertController alertControllerWithTitle:@"warning" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
    {
        
        

    }];
    [alert1 addAction:okAction];
    [self presentViewController:alert1 animated:YES completion:nil];
    
}




- (IBAction)backButton:(UIButton *)sender
{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
@end
