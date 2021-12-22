//

//


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 button 的样式，以图片为基准
 */
typedef NS_ENUM(NSInteger, CXButtonContentLayoutStyle) {
    CXButtonContentLayoutStyleNormal = 0,       // 内容居中-图左文右
    CXButtonContentLayoutStyleCenterImageRight, // 内容居中-图右文左
    CXButtonContentLayoutStyleCenterImageTop,   // 内容居中-图上文下
    CXButtonContentLayoutStyleCenterImageBottom,// 内容居中-图下文上
    CXButtonContentLayoutStyleLeftImageLeft,    // 内容居左-图左文右
    CXButtonContentLayoutStyleLeftImageRight,   // 内容居左-图右文左
    CXButtonContentLayoutStyleRightImageLeft,   // 内容居右-图左文右
    CXButtonContentLayoutStyleRightImageRight,  // 内容居右-图右文左
};

@interface UIButton (CXContentLayout)

/**
 button 的布局样式，文字、字体大小、图片等参数一定要在其之前设置，方便计算
 */
@property(nonatomic, assign) CXButtonContentLayoutStyle cxUI_buttonContentLayoutType;

/*!
 *  图文间距，默认为：0
 */
@property (nonatomic, assign) CGFloat cxUI_padding;

/*!
 *  图文边界的间距，默认为：5
 */
@property (nonatomic, assign) CGFloat cxUI_paddingInset;





@end
NS_ASSUME_NONNULL_END


