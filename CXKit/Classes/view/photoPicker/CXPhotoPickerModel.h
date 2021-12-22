//
//  CXPhotoPickerModel.h
//  CXKit
//
//  Created by hntnet on 2021/12/16.
//

#import <Foundation/Foundation.h>
#import "CXDefineHeader.h"
NS_ASSUME_NONNULL_BEGIN

@interface CXPhotoPickerModel : NSObject

///每行几个
@property (nonatomic ,assign) int columnNum;

///可以最多添加图片数量
@property (nonatomic ,assign) int maxNum;

///view高度
@property (nonatomic ,assign) float height;


@property (nonatomic ,strong) UIImage *defaultImage;


@end

NS_ASSUME_NONNULL_END
