//
//  CXPhotoPicker.h
//  BAWKWebView
//
//  Created by hntnet on 2021/12/16.
//

#import <UIKit/UIKit.h>
#import "CXCollectionView.h"
#import "CXDefineHeader.h"
#import "CXPhotoPickerModel.h"
#import "CXTools.h"

NS_ASSUME_NONNULL_BEGIN


@class CXPhotoPicker;
@protocol CXPhotoPickerDelegate <NSObject>

-(void)pickerView:(CXPhotoPicker *)pickerView andHeight:(CGFloat)height;

-(void)pickerView:(CXPhotoPicker *)pickerView andDeleteIndex:(NSInteger)index;

-(void)pickerView:(CXPhotoPicker *)pickerView andImages:(NSMutableArray *)images;

@end
@interface CXPhotoPicker : UIView

@property (nonatomic ,strong) CXPhotoPickerModel *model;

@property (nonatomic ,weak) id<CXPhotoPickerDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
