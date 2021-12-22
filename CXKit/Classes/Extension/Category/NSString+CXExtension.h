//


//

#import <Foundation/Foundation.h>

@interface NSString (CXExtension)

//判断是否为整形：
- (BOOL)isPureInt;
//判断是否为浮点形：
- (BOOL)isPureFloat;
//身份证号验证
- (BOOL)judgeIdentityStringValid;
// 文字高度
- (CGFloat)textHeightSize:(CGSize)maxSize font:(UIFont *)font lineSpacing:(CGFloat)lineSpace;
//日历周几转换（英文习惯-中文习惯）
- (NSString *)getChineseWeekdayFormEnglishWeekday:(NSInteger)weekday;

- (NSDictionary *)dictionaryWithJsonString;

- (NSString *)pinyin;

+(NSString *)deleteSpace:(NSString *)string;

- (NSMutableAttributedString *)modifyDigitalColor:(UIColor *)color normalColor:(UIColor *)normalColor;

@end
