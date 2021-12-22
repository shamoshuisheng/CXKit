//
//  UITextField+CXExtended.h
//  福格玛
//
//  Created by shamo on 2021/3/13.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol CXTextFieldDelegate <UITextFieldDelegate>
@optional
- (void)textFieldDidDeleteBackward:(UITextField *)textField;
@end
@interface UITextField (CXExtended)
@property (weak, nonatomic) id<CXTextFieldDelegate> delegate;
@end

/**
 *  监听删除按钮
 *  object:UITextField
 */
extern NSString * const WJTextFieldDidDeleteBackwardNotification;

NS_ASSUME_NONNULL_END
