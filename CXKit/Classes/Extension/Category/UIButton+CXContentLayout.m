//

//

#import "UIButton+CXContentLayout.h"
#import <objc/runtime.h>

NS_ASSUME_NONNULL_BEGIN

static NSString * const kbuttonContentLayoutTypeKey = @"cxUI_buttonContentLayoutTypeKey";
static NSString * const kpaddingKey = @"cxUI_paddingKey";
static NSString * const kpaddingInsetKey = @"cxUI_paddingInsetKey";


@implementation UIButton (CXContentLayout)

- (void)setupButtonLayout{
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    CGFloat image_w = self.imageView.frame.size.width;
    CGFloat image_h = self.imageView.frame.size.height;
    
    CGFloat title_w = self.titleLabel.frame.size.width;
    CGFloat title_h = self.titleLabel.frame.size.height;
    
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0){
        // 由于iOS8中titleLabel的size为0，用下面的这种设置
        title_w = self.titleLabel.intrinsicContentSize.width;
        title_h = self.titleLabel.intrinsicContentSize.height;
    }
    
    UIEdgeInsets imageEdge = UIEdgeInsetsZero;
    UIEdgeInsets titleEdge = UIEdgeInsetsZero;
    
    if (self.cxUI_paddingInset == 0){
        self.cxUI_paddingInset = 5;
    }
    
    switch (self.cxUI_buttonContentLayoutType) {
        case CXButtonContentLayoutStyleNormal:{
            titleEdge = UIEdgeInsetsMake(0, self.cxUI_padding, 0, 0);
            imageEdge = UIEdgeInsetsMake(0, 0, 0, self.cxUI_padding);
            self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        }
            break;
        case CXButtonContentLayoutStyleCenterImageRight:{
            titleEdge = UIEdgeInsetsMake(0, -image_w - self.cxUI_padding, 0, image_w);
            imageEdge = UIEdgeInsetsMake(0, title_w + self.cxUI_padding, 0, -title_w);
            self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        }
            break;
        case CXButtonContentLayoutStyleCenterImageTop:{
            titleEdge = UIEdgeInsetsMake(0, -image_w, -image_h - self.cxUI_padding, 0);
            imageEdge = UIEdgeInsetsMake(-title_h - self.cxUI_padding, 0, 0, -title_w);
            self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        }
            break;
        case CXButtonContentLayoutStyleCenterImageBottom:{
            titleEdge = UIEdgeInsetsMake(-image_h - self.cxUI_padding, -image_w, 0, 0);
            imageEdge = UIEdgeInsetsMake(0, 0, -title_h - self.cxUI_padding, -title_w);
            self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        }
            break;
        case CXButtonContentLayoutStyleLeftImageLeft:{
            titleEdge = UIEdgeInsetsMake(0, self.cxUI_padding + self.cxUI_paddingInset, 0, 0);
            imageEdge = UIEdgeInsetsMake(0, self.cxUI_paddingInset, 0, 0);
            self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        }
            break;
        case CXButtonContentLayoutStyleLeftImageRight:{
            titleEdge = UIEdgeInsetsMake(0, -image_w + self.axcUI_paddingInset, 0, 0);
            imageEdge = UIEdgeInsetsMake(0, title_w + self.cxUI_padding + self.cxUI_paddingInset, 0, 0);
            self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        }
            break;
        case CXButtonContentLayoutStyleRightImageLeft:{
            imageEdge = UIEdgeInsetsMake(0, 0, 0, self.cxUI_padding + self.cxUI_paddingInset);
            titleEdge = UIEdgeInsetsMake(0, 0, 0, self.axcUI_paddingInset);
            self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        }
            break;
        case CXButtonContentLayoutStyleRightImageRight:{
            titleEdge = UIEdgeInsetsMake(0, -self.frame.size.width / 2, 0, image_w + self.cxUI_padding + self.cxUI_paddingInset);
            imageEdge = UIEdgeInsetsMake(0, 0, 0, -title_w + self.cxUI_paddingInset);
            self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        }
            break;
        default:break;
    }
    self.imageEdgeInsets = imageEdge;
    self.titleEdgeInsets = titleEdge;
    [self setNeedsDisplay];
}


#pragma mark - SET
- (void)setAxcUI_buttonContentLayoutType:(CXButtonContentLayoutStyle)cxUI_buttonContentLayoutType{
    [self willChangeValueForKey:kbuttonContentLayoutTypeKey];
    objc_setAssociatedObject(self, &kbuttonContentLayoutTypeKey,
                             @(cxUI_buttonContentLayoutType),
                             OBJC_ASSOCIATION_ASSIGN);
    [self didChangeValueForKey:kbuttonContentLayoutTypeKey];
    [self setupButtonLayout];
}

- (CXButtonContentLayoutStyle)cxUI_buttonContentLayoutType{
    return [objc_getAssociatedObject(self, &kbuttonContentLayoutTypeKey) integerValue];
}

- (void)setCXUI_padding:(CGFloat)cxUI_padding{
    [self willChangeValueForKey:kpaddingKey];
    objc_setAssociatedObject(self, &kpaddingKey,
                             @(cxUI_padding),
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:kpaddingKey];

    [self setupButtonLayout];
}

- (CGFloat)cxUI_padding{
    return [objc_getAssociatedObject(self, &kpaddingKey) floatValue];
}

- (void)setCXUI_paddingInset:(CGFloat)cxUI_paddingInset{
    [self willChangeValueForKey:kpaddingInsetKey];
    objc_setAssociatedObject(self, &kpaddingInsetKey,
                             @(cxUI_paddingInset),
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:kpaddingInsetKey];
    [self setupButtonLayout];
}

- (CGFloat)axcUI_paddingInset{
    return [objc_getAssociatedObject(self, &kpaddingInsetKey) floatValue];
}


@end
NS_ASSUME_NONNULL_END

