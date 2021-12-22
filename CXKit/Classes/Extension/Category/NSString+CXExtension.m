//

//

#import "NSString+CXExtension.h"

@implementation NSString (CXExtension)
//判断是否为整形：
- (BOOL)isPureInt{
    NSScanner* scan = [NSScanner scannerWithString:self];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}

//判断是否为浮点形：
- (BOOL)isPureFloat{
    NSScanner* scan = [NSScanner scannerWithString:self];
    float val;
    return[scan scanFloat:&val] && [scan isAtEnd];
}
//身份证好验证
- (BOOL)judgeIdentityStringValid {
    
    if (self.length != 18) return NO;
    // 正则表达式判断基本 身份证号是否满足格式
    NSString *regex2 = @"^(^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$)|(^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])((\\d{4})|\\d{3}[Xx])$)$";
    NSPredicate *identityStringPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    //如果通过该验证，说明身份证格式正确，但准确性还需计算
    if(![identityStringPredicate evaluateWithObject:self]) return NO;
    
    //** 开始进行校验 *//
    
    //将前17位加权因子保存在数组里
    NSArray *idCardWiArray = @[@"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2"];
    
    //这是除以11后，可能产生的11位余数、验证码，也保存成数组
    NSArray *idCardYArray = @[@"1", @"0", @"10", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2"];
    
    //用来保存前17位各自乖以加权因子后的总和
    NSInteger idCardWiSum = 0;
    for(int i = 0;i < 17;i++) {
        NSInteger subStrIndex = [[self substringWithRange:NSMakeRange(i, 1)] integerValue];
        NSInteger idCardWiIndex = [[idCardWiArray objectAtIndex:i] integerValue];
        idCardWiSum+= subStrIndex * idCardWiIndex;
    }
    
    //计算出校验码所在数组的位置
    NSInteger idCardMod=idCardWiSum%11;
    //得到最后一位身份证号码
    NSString *idCardLast= [self substringWithRange:NSMakeRange(17, 1)];
    //如果等于2，则说明校验码是10，身份证号码最后一位应该是X
    if(idCardMod==2) {
        if(![idCardLast isEqualToString:@"X"]||[idCardLast isEqualToString:@"x"]) {
            return NO;
        }
    }
    else{
        //用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
        if(![idCardLast isEqualToString: [idCardYArray objectAtIndex:idCardMod]]) {
            return NO;
        }
    }
    return YES;
}
//日历周几转换（英文习惯-中文习惯）
- (NSString *)getChineseWeekdayFormEnglishWeekday:(NSInteger)weekday
{
    switch (weekday) {
        case 1:
            return @"周日";
            break;
        case 2:
            return @"周一";
            break;
        case 3:
            return @"周二";
            break;
        case 4:
            return @"周三";
            break;
        case 5:
            return @"周四";
            break;
        case 6:
            return @"周五";
            break;
        case 7:
            return @"周六";
            break;
        default:
            return @"周日";
            break;
    }
}

/**
 *  把格式化的JSON格式的字符串转换成字典
 *
 *  @return 返回字典
 */
- (NSDictionary *)dictionaryWithJsonString{
    if (self == nil)
    {
        return nil;
    }
    
    NSData *jsonData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData  options:NSJSONReadingMutableContainers error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}
//计算文本的高度：
- (CGFloat)textHeightSize:(CGSize)maxSize font:(UIFont *)font lineSpacing:(CGFloat)lineSpace {
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    
    paraStyle.lineBreakMode = NSLineBreakByWordWrapping;
    paraStyle.alignment = NSTextAlignmentLeft;
    paraStyle.lineSpacing = lineSpace;//行间距
    
    // NSKernAttributeName 字间距
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle};
    
    CGFloat textH = [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size.height;
    return textH;
}

+(NSString *)deleteSpace:(NSString *)string
{
    //去除首尾空格
    NSString *str =[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    return str;
}

//汉字、英语的拼音
- (NSString *)pinyin
{
    NSMutableString *str = [self mutableCopy];
    NSMutableString *strResult = [NSMutableString string];
    NSArray *array = @[@"掠",@"略",@"锊"];
    
    for (int i=0; i<str.length; i++)
    {
        NSString *subStr = [str substringWithRange:NSMakeRange(i, 1)];
        BOOL flag = NO;
        for (int j= 0 ; j<array.count; j++)
        {
            if ([subStr isEqualToString:array[j]])
            {
                flag = YES;
            }
        }
        
        if (flag)
        {
            subStr = @"l";
        }
        else
        {
            NSMutableString *subStr1 = [NSMutableString stringWithString:subStr];
            CFStringTransform(( CFMutableStringRef)subStr1, NULL, kCFStringTransformToLatin, NO);
            CFStringTransform((CFMutableStringRef)subStr1, NULL, kCFStringTransformStripDiacritics, NO);
            subStr = subStr1;
        }
        [strResult appendFormat:@"%@",subStr];
    }
    
    /*多音字处理*/
    if ([[str substringToIndex:1] compare:@"长"] == NSOrderedSame)
    {
        [strResult replaceCharactersInRange:NSMakeRange(0, 5) withString:@"chang"];
    }
    if ([[str substringToIndex:1] compare:@"沈"] == NSOrderedSame)
    {
        [strResult replaceCharactersInRange:NSMakeRange(0, 4) withString:@"shen"];
    }
    if ([[str substringToIndex:1] compare:@"厦"] == NSOrderedSame)
    {
        [strResult replaceCharactersInRange:NSMakeRange(0, 3) withString:@"xia"];
    }
    if ([[str substringToIndex:1] compare:@"地"] == NSOrderedSame)
    {
        [strResult replaceCharactersInRange:NSMakeRange(0, 3) withString:@"di"];
    }
    if ([[str substringToIndex:1] compare:@"重"] == NSOrderedSame)
    {
        [strResult replaceCharactersInRange:NSMakeRange(0, 5) withString:@"chong"];
    }
    
    return [[strResult stringByReplacingOccurrencesOfString:@" " withString:@""] lowercaseString];
}

/**
 修改字符串中数字颜色, 并返回对应富文本
 
 @param color 数字颜色, 包括小数
 @param normalColor 默认颜色
 @return 结果富文本
 */
- (NSMutableAttributedString *)modifyDigitalColor:(UIColor *)color normalColor:(UIColor *)normalColor;
{
    NSRegularExpression *regular = [NSRegularExpression regularExpressionWithPattern:@"([0-9]\\d*\\.?\\d*)" options:0 error:NULL];
    
    NSArray<NSTextCheckingResult *> *ranges = [regular matchesInString:self options:0 range:NSMakeRange(0, [self length])];
    
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByWordWrapping;
    paraStyle.alignment = NSTextAlignmentLeft;
    paraStyle.lineSpacing = 3; //设置行间距
    
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:self attributes:@{NSForegroundColorAttributeName : normalColor,NSFontAttributeName:[UIFont systemFontOfSize:12], NSParagraphStyleAttributeName:paraStyle}];
    
    for (int i = 0; i < ranges.count; i++) {
        [attStr setAttributes:@{NSForegroundColorAttributeName : color} range:ranges[i].range];
    }

    return attStr;
}

@end
