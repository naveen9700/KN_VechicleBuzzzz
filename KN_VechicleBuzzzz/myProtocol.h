//
//  myProtocol.h
//  KN_VechicleBuzzzz
//
//  Created by kunchal on 24/10/17.
//  Copyright © 2017 VNSoftech. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol myProtocol <NSObject>
@required
-(void)collectionData:(NSString *)VID
          vechicleCat:(NSString *)VCAT;
@end
