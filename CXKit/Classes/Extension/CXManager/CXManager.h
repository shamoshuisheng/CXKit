//
//  CXManager.h
//  ctrip360
//
//  Created by hntnet on 2021/1/3.
//

#import <Foundation/Foundation.h>
#import "WMZDialog.h"
#import "CXTools.h"
@import ZLPhotoBrowser;
NS_ASSUME_NONNULL_BEGIN

@interface CXManager : NSObject


/**
 *  显示“加载中”，带圈圈，若要修改直接修改kLoadingMessage的值即可
 */
+ (void)showLoading;


+ (void)showLoadingC;

/**
 *  显示简短的提示语，默认2秒钟，时间可直接修改kShowTime
 *
 *  @param alert 提示信息
 */
+ (void) showBriefAlert:(NSString *) alert;


/**
 *  显示简短的提示语，默认2秒钟，时间可直接修改kShowTime
 *
 *  @param alert 提示信息
 */
+ (void) showBriefAlert:(NSString *) alert andTime:(int)time;

+(void)hideAlert;

#pragma mark ===========alert===============
+ (void)showAlertWithTitle:(NSString *)title andTitleColor:(UIColor *)titleColor andDesc:(NSString *)desc andDescColor:(UIColor *)descColor andCancelTitle:(NSString *)cancelTitle andCancelTitleColor:(UIColor *)cancelColor andFinishTitle:(NSString *)finishTitle andFinishColor:(UIColor *)finishColor andClick:(void(^)(NSInteger index))finished;


#pragma mark ===========picker===============
+ (void)showPickerView:(NSArray *)arr andOkTitle:(NSString *)okTitle andOkTitleColor:(UIColor *)okColor andCancelTitle:(NSString *)cancelTitle  andCancelTitleColor:(UIColor *)cancelColor  andFinished:(void(^)(id dic))finished;


+(void)showPhotoSheet;

@end

NS_ASSUME_NONNULL_END
