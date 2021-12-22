//
//  CXUITools.h
//
//
//  Created by 灿汐 on 2020/6/21.
//  Copyright © 2020 hntnet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>
#import "CXDefineHeader.h"
NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger, GradientDirection) {
     GradientDirectionTopToBottom = 0,    // 从上往下 渐变
     GradientDirectionLeftToRight,        // 从左往右
     GradientDirectionBottomToTop,      // 从下往上
     GradientDirectionRightToLeft      // 从右往左
};

@interface CXUITools : NSObject
+(instancetype)shareInstance;



#pragma mark ===========创建tableView===============
/// <#Description#>
/// @param rect <#rect description#>
/// @param tableStyle <#tableStyle description#>
/// @param target <#target description#>
/// @param separatorMode <#separatorMode description#>
/// @param cellID <#cellID description#>
/// @param useNib <#useNib description#>
/// @param cellNmae <#cellNmae description#>
/// @param color <#color description#>

+(UITableView *)creatTableView:(CGRect)rect andTableViewStyle:(UITableViewStyle)tableStyle andTarget:(id)target andSeparatorStyle:(UITableViewCellSeparatorStyle)separatorMode andCellReuseId:(NSString *)cellID andUseCellNib:(BOOL)useNib  andCellName:(NSString *)cellNmae andBackGroundColor:(UIColor *)color;

#pragma mark ===========collectionView===============
+(UICollectionView *)collectionViewWithLayout:(UICollectionViewFlowLayout *)layout andFrame:(CGRect)frame andContentInset:(UIEdgeInsets)contentInset andTarget:(id)vc andNibCellName:(NSString *)cellName andCellID:(NSString *)cellID andHeaderName:(NSString *)headerName andHeaderId:(NSString *)headerId;


#pragma mark ===========创建webview===============
//创建webview
/// 创建webview
/// @param frame <#frame description#>
/// @param urlStr <#urlStr description#>
+ (WKWebView *)createWebView:(CGRect)frame urlString:(NSString *)urlStr;

+ (WKWebView *)createWebView:(CGRect)frame contentString:(NSString *)contentString andBaseURLString:(NSString
                                                                                           *)baseUrlString;

#pragma mark ===========创建ScrollView===============
/// 创建ScrollView
/// @param rect <#rect description#>
/// @param target <#target description#>
/// @param scrollEnabled <#scrollEnabled description#>
/// @param pagingEnabled <#pagingEnabled description#>
/// @param bounces <#bounces description#>

+(UIScrollView *)creatScrollView:(CGRect)rect andTarget:(UIViewController *)target andScrollEnabled:(BOOL)scrollEnabled andPagingEnabled:(BOOL)pagingEnabled andBounces:(BOOL)bounces;

#pragma mark ===========创建 imageView===============
//图片 有边框圆角
+ (UIImageView*)createImageView:(CGRect)rect andImageViewName:(NSString*)imageName andLayerBorderWidth:(NSInteger)borderWidth andBorderColor:(UIColor*)color andCornerRadius:(NSInteger)cornerRadius;

+(UIImageView *)createImageView:(CGRect)rect andImageViewName:(NSString *)imageName;

#pragma mark ===========创建通过颜色一个图片===============
+(UIImage *)createImageFromColor:(UIColor *)color rect:(CGRect)rect;

#pragma mark ===========创建渐变色图片===============
+(UIImage *)createGradientImageWithBounds:(CGRect)bounds andColors:(NSArray*)colors andGradientType:(GradientDirection)gradientType;

#pragma mark ===========通过颜色和文字创建一个图片===============
+ (UIImage *)createImageWithColor:(UIColor *)color
                          ImageSize:(CGSize)size
                          text:(NSString *)text
                         textSize:( CGFloat)textSize;

#pragma mark ===========获取视频第一帧===============

+ (UIImage *)getImageFromVideoPreViewImage:(NSURL *)path;



#pragma mark ===========view转image===============
+ (UIImage *)viewToImage:(UIView *)view;


#pragma mark ===========叠加图片===============

+ (UIImage *)addImage:(UIImage *)image1 withImage:(UIImage *)image2;



#pragma mark ===========创建lable===============

+(UILabel *)creatLabel:(CGRect)rect andBackGroundColor:(UIColor*)backColor andTextAlignment:(NSInteger)alignment andFont:(UIFont *)font andTextColor:(UIColor *)textColor andText:(NSString *)text;

#pragma mark ===========创建button===============

+(UIButton*)createButton:(CGRect)rect andTarget:(id)target andSeletor:(SEL)sel andTitleColor:(UIColor*)titleColor andFont:(UIFont*)font  andBackGroundColor:(UIColor *)backGroundColor andBackGroundImage:(NSString*)backImage andTitle:(NSString*)title;


#pragma mark ===========创建view===============
+(UIView *)creatBackGroundView:(CGRect)rect AndColor:(UIColor *)color;

+(UIView *)createGradientView:(CGRect)rect andStartColor:(UIColor *)startColor andEndColor:(UIColor *)endColor andIsLongitudinal:(BOOL)isLong;



#pragma mark ===创建lineView===

+(UIView *)creatLineView:(CGRect)rect;
#pragma mark ===========创建textField===============

+(UITextField *)creatTextFiled:(CGRect)rect andPlaceHolder:(NSString *)placeholder andText:(NSString *)text andSecureTextEntry:(BOOL)flag andClearsOnBeginEditing:(BOOL)clearFlag andClearButtonMode:(BOOL)clearButtonFlag andKeyBoardType:(UIKeyboardType)keyBoardType;

#pragma mark ===========创建一个alertView===============
+(void)showTwoAlertTitle:(NSString *)title andMsg:(NSString *)msg  target:(UIViewController *)target :(void (^)(void))completion;

#pragma mark ===========+++++++++++++===============


#pragma mark ===========获取当前屏幕显示的viewcontroller===============
/*
获取当前屏幕显示的viewcontroller
*/
+ (UIViewController *)getCurrentVC;


#pragma mark ===========dismiss到最底层的控制器===============
+(void)dismissToRootViewController:(UIViewController *)target;




/*
周边加阴影，并且同时圆角
*/

+ (void)addShadowToView:(UIView *)view withOpacity:(float)shadowOpacity shadowRadius:(CGFloat)shadowRadius andCornerRadius:(CGFloat)cornerRadius;

/*
 添加border，并且同时圆角
*/

+ (void)addborderToView:(UIView *)view andBorderColor:(UIColor *)borderColor andBorderWidth:(float)borderWidth andCornerRadius:(CGFloat)cornerRadius;



#pragma mark ===========中划线===============
+(NSMutableAttributedString *)createUnderLineAttributeStingWithString:(NSString *)str;

@end

NS_ASSUME_NONNULL_END
