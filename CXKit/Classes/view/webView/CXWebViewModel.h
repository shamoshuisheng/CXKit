//
//  CXWebViewModel.h
//  CXKit
//
//  Created by hntnet on 2021/12/15.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CXWebViewModel : NSObject
///内容
@property(nonatomic, copy) NSString *content;
///高度
@property(nonatomic, assign) double height;
///url
@property (nonatomic ,strong) NSString *urlStr;
///是否为本地文件
@property (nonatomic ,assign) BOOL isLocal;

///用来处理页面内点击跳转链接@"/pages/goods/goods"
@property (nonatomic ,copy) NSString *filterStr;
///如：sku_id
@property (nonatomic ,copy) NSString *idType;

@end

NS_ASSUME_NONNULL_END
