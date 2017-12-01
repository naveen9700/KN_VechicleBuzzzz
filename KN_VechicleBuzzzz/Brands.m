//
//  Brands.m
//  KN_VechicleBuzzzz
//
//  Created by kunchal on 23/11/17.
//  Copyright © 2017 VNSoftech. All rights reserved.
//

#import "Brands.h"
#import "AFHTTPSessionManager.h"
#import "UIImageView+AFNetworking.h"
#import "BrandsTableViewCell.h"

@interface Brands ()
{
    AFHTTPSessionManager * manager;
    NSMutableArray * brandsArr;
    NSMutableArray * singleBrandArr;
    NSString * selectedBrand;
}
@end

@implementation Brands

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated
{
    self.brandsTable.hidden = YES;

     manager= [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    [manager GET:@"http://www.vehiclebuzzzz.com/index.php/JsonController/brand" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
    {
        
        brandsArr = responseObject;
        [self.collectionOBJ reloadData];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
    
    
    
    
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    
    return 1;
    
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return [[brandsArr valueForKey:@"brand"]count];
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BrandsCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BrandsCollectionViewCell" forIndexPath:indexPath];
    
    
    NSString *url_Img1 = @"http://vehiclebuzzzz.com/";
    NSString *url_Img2 = [[[brandsArr valueForKey:@"brand"]objectAtIndex:indexPath.row]valueForKey:@"icon"];
    
    NSString *url_Img_FULL = [url_Img1 stringByAppendingPathComponent:url_Img2];
    [cell.brandImage setImageWithURL:[NSURL URLWithString:url_Img_FULL]];
    cell.brandNameLbl.text=[[[brandsArr valueForKey:@"brand"]objectAtIndex:indexPath.row]valueForKey:@"category"];
    
//    cell.layer.borderWidth=1.0f;
//    cell.layer.borderColor=[UIColor lightGrayColor].CGColor;
    cell.cellView.layer.borderWidth=1.0f;
    cell.cellView.layer.borderColor=[UIColor lightGrayColor].CGColor;
    
    cell.cellView.layer.cornerRadius = 5;
    cell.cellView.layer.masksToBounds = true;
    
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    singleBrandArr = [[[brandsArr valueForKey:@"brand"]objectAtIndex:indexPath.row]valueForKey:@"brandresult"];
    selectedBrand = [[[brandsArr valueForKey:@"brand"]objectAtIndex:indexPath.row]valueForKey:@"category"];
    self.brandsTable.delegate = self;
    self.brandsTable.dataSource = self;
    self.brandsTable.hidden = NO;

    [self.brandsTable reloadData];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}
-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    
    return selectedBrand;
}
- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 45)] ;
    headerView.backgroundColor = [UIColor blueColor];
    
    
    UILabel * LBL = [[UILabel alloc]initWithFrame:CGRectMake(20, 5, 70, 30)];
    LBL.textColor = [UIColor whiteColor];
    LBL.text = selectedBrand;
    LBL.font = [UIFont systemFontOfSize:20];
    [headerView addSubview:LBL];
    
    return headerView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section

{
    return 45;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return singleBrandArr.count;
}

-(UITableViewCell* )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BrandsTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"BrandsTableViewCell"];
    
    NSString *url_Img1 = @"http://vehiclebuzzzz.com/";
    NSString *url_Img2 = [[singleBrandArr objectAtIndex:indexPath.row] valueForKey:@"brand_logo"];
    
    NSString *url_Img_FULL = [url_Img1 stringByAppendingPathComponent:url_Img2];
    [cell.brandimageTable setImageWithURL:[NSURL URLWithString:url_Img_FULL]];
    cell.brandLBLTable.text=[[singleBrandArr objectAtIndex:indexPath.row] valueForKey:@"brand"];
    
//    cell.layer.borderWidth=1.0f;
//    cell.layer.borderColor=[UIColor lightGrayColor].CGColor;
    cell.cellViewTable.layer.cornerRadius = 5;
    cell.cellViewTable.layer.masksToBounds = true;
    cell.cellViewTable.layer.borderWidth=1.0f;
    cell.cellViewTable.layer.borderColor=[UIColor lightGrayColor].CGColor;
    
    
    return cell;
    
}





@end
