//



//

#import "UILabel+CXExtension.h"

@implementation UILabel (CXExtension)
// 改变某些文字颜色
-(void)setColorAttributedText:(NSString *)allStr andChangeStr:(NSString *)changeStr andColor:(UIColor *)color
{
    NSString *string = changeStr;//要单独改变的字体颜色
    NSRange range = [allStr rangeOfString:string];
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc]initWithString:allStr];
    [attStr addAttribute:NSForegroundColorAttributeName value:color range:range];
    self.attributedText = attStr;
}

// 改变某些文字颜色
-(void)setColorAttributedText:(NSString *)allStr andChangeRange:(NSRange )range andColor:(UIColor *)color
{
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc]initWithString:allStr];
    [attStr addAttribute:NSForegroundColorAttributeName value:color range:range];
    self.attributedText = attStr;
}

// 改变某些文字大小
-(void)setFontAttributedText:(NSString *)allStr andChangeStr:(NSString *)changeStr andFont:(UIFont *)font
{
    NSString *string = changeStr;//要单独改变的字体颜色
    NSRange range = [allStr rangeOfString:string];
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc]initWithString:allStr];
    [attStr addAttribute:NSFontAttributeName value:font range:range];
    self.attributedText = attStr;
}

-(void)setFontAttributedText:(NSString *)allStr andChangeRange:(NSRange )range andFont:(UIFont *)font
{
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc]initWithString:allStr];
    [attStr addAttribute:NSFontAttributeName value:font range:range];
    self.attributedText = attStr;
}

// 改变某些文字大小和颜色
-(void)setFontAndColorAttributedText:(NSString *)allStr andChangeStr:(NSString *)changeStr andColor:(UIColor *)color andFont:(UIFont *)font
{
    NSString *string = changeStr;//要单独改变的字体颜色
    NSRange range = [allStr rangeOfString:string];
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc]initWithString:allStr];
    [attStr addAttribute:NSForegroundColorAttributeName value:color range:range];
    [attStr addAttribute:NSFontAttributeName value:font range:range];
    self.attributedText = attStr;
}
-(void)setTextWithLineSpace:(CGFloat)lineSpace withString:(NSString*)str withFont:(UIFont*)font {
    
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByWordWrapping;
    paraStyle.alignment = NSTextAlignmentLeft;
    paraStyle.lineSpacing = lineSpace; //设置行间距
    
    //设置字间距 NSKernAttributeName:@1.5f
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle};
    
    NSAttributedString *attributeStr = [[NSAttributedString alloc] initWithString:str attributes:dic];
    
    self.attributedText = attributeStr;
}

@end
