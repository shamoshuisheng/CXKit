//
//  HXLocationTool_.h
//  KYPX
//
//  Created by hxrc on 2017/9/22.
//  Copyright © 2017年 JC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CXTools.h"
@protocol HXLocationTool_Delegate <NSObject>

- (void)locationDidEndUpdatingLongitude:(CGFloat)longitude latitude:(CGFloat)latitude city:(NSString *)city;
- (void)locationDidEndUpdatingLongitude:(CGFloat)longitude latitude:(CGFloat)latitude address:(NSString *)address;
@end
@interface HXLocationTool_ : NSObject
@property (nonatomic, weak) id<HXLocationTool_Delegate> delegate;

- (void)beginUpdatingLocation;
@end
