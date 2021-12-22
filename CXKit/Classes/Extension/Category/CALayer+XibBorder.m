//

//

#import "CALayer+XibBorder.h"

#import <UIKit/UIKit.h>

@implementation CALayer (XibBorder)

- (void)setBorderUIColor:(UIColor *)color {
    self.borderColor = color.CGColor;
}

- (UIColor*)borderUIColor {
    return [UIColor colorWithCGColor:self.borderColor];
}

- (void)setCornerRadiusFit:(CGFloat)cornerRadius {
    self.cornerRadius =(CGFloat) cornerRadius * CXScreenWidth /375.;
}

- (CGFloat)cornerRadiusFit {
    return self.cornerRadius;
//    [UIColor colorWithCGColor:self.borderColor];
}


@end

