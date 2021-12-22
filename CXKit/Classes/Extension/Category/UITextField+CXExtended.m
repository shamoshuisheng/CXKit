//
//  UITextField+CXExtended.m
//  福格玛
//
//  Created by shamo on 2021/3/13.
//

#import "UITextField+CXExtended.h"
#import <objc/runtime.h>
//NSString * const CXTextFieldDidDeleteBackwardNotification = @"com.whojun.textfield.did.notification";
@implementation UITextField (CXExtended)
+ (void)load {
    //交换2个方法中的IMP
    Method method1 = class_getInstanceMethod([self class], NSSelectorFromString(@"deleteBackward"));
    Method method2 = class_getInstanceMethod([self class], @selector(cx_deleteBackward));
    method_exchangeImplementations(method1, method2);
}

- (void)cx_deleteBackward {
    [self cx_deleteBackward];
    
    if ([self.delegate respondsToSelector:@selector(textFieldDidDeleteBackward:)])
    {
        id <CXTextFieldDelegate> delegate  = (id<CXTextFieldDelegate>)self.delegate;
        [delegate textFieldDidDeleteBackward:self];
    }
    
//    [[NSNotificationCenter defaultCenter] postNotificationName:CXTextFieldDidDeleteBackwardNotification object:self];
}
@end
