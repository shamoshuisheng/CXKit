//
//  HQPicCodeCulculateView.h
//  HQPicCodeProject
//
//  Created by 花强 on 2018/3/16.
//  Copyright © 2018年 花强. All rights reserved.
//  //验证码

#import <UIKit/UIKit.h>

typedef void (^PicCodeReceive)(NSString * code);

@interface HQPicCodeCulculateView : UIView

-(instancetype)initWithFrame:(CGRect)frame IsRotation:(BOOL)isRotation Block:(PicCodeReceive)block;
-(void)freshVerCode;

@end
