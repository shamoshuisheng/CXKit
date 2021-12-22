//
//  NSBundle+CXBundle.h
//  CXKit
//
//  Created by hntnet on 2021/12/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSBundle (CXBundle)
//bundleName是和组件名字一样的
+ (instancetype)cxBundleWithBundleName:(NSString *)bundleName targetClass:(Class)targetClass;
@end

NS_ASSUME_NONNULL_END
