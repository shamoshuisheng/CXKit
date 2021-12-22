//
//  CXFounctionTools.m

//

#import "CXFounctionTools.h"
#import <CommonCrypto/CommonDigest.h>
#import <MapKit/MapKit.h>
@class AMapLocationManager;

@interface CXFounctionTool()
@property (nonatomic ,strong) AMapLocationManager *locationManager;
@end
@implementation CXFounctionTool


#pragma mark ===========判断是否为首次登录===============
+(BOOL)isFirstLaunch{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"version"]) {
        NSString *systemVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString*)kCFBundleVersionKey];
        BOOL isFirst = [systemVersion isEqualToString:[defaults objectForKey:@"version"]];
        
        //无论是否与当前版本一致，都重新写入
        [defaults setObject:systemVersion forKey:@"version"];
        [defaults synchronize];
//        判读是否为首次进入
        if (isFirst) {
           return NO;
        }else{
            return YES;
        }
    }
    
    NSString *systemVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString *)kCFBundleVersionKey];
    [defaults setObject:systemVersion forKey:@"version"];
    [defaults synchronize];
    return YES;
}




#pragma mark ===========判断字符串是否为指定类型===============
+ (BOOL)validateString:(NSString*)number withType:(CXNumberType)type{
    BOOL result = YES;
    if(type == CXNumberNormal)
    {
        NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
        int i = 0;
        while (i < number.length)
        {
            NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
            NSRange range = [string rangeOfCharacterFromSet:tmpSet];
            if (range.length == 0 ) {
                result = NO;
                break;
            }
            i++;
        }
        return result;
    }
    
    else if(type == CXNumberFloat)
    {
        NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789."];
        int i = 0;
        while (i < number.length)
        {
            NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
            NSRange range = [string rangeOfCharacterFromSet:tmpSet];
            if (range.length == 0 ) {
                result = NO;
                break;
            }
            i++;
        }
        return result;
    }
    else if(type == CXNumberWord)
    {
        NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"];
        int i = 0;
        while (i < number.length)
        {
            NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
            NSRange range = [string rangeOfCharacterFromSet:tmpSet];
            if (range.length == 0 ) {
                result = NO;
                break;
            }
            i++;
        }
        return result;
    }
    else
        
    {
        NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789Xx"];
        int i = 0;
        while (i < number.length)
        {
            NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
            NSRange range = [string rangeOfCharacterFromSet:tmpSet];
            if (range.length == 0 ) {
                result = NO;
                break;
            }
            i++;
        }
        return result;
    }
    
    
}


#pragma mark ===========验证邮箱===============
//验证邮箱格式的正则表达式
+(BOOL)isValidateEmail:(NSString *)email{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

#pragma mark ===========身份证号码验证===============
///身份证号 格式验证 （模糊）
/// 模糊返回是否是身份证号
/// @param identityCard 身份证号
+ (BOOL) validateIdentityCard: (NSString *)identityCard{
    BOOL flag;
       if (identityCard.length <= 0) {
           flag = NO;
           return flag;
       }
       NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
       NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
       return [identityCardPredicate evaluateWithObject:identityCard];
}
/**
 身份证号 真假验证 （精确）
 
 @param value 身份证号
 @return 精确返回是否是身份证号
 */
+(BOOL)validateIDCardNumber:(NSString *)value{
    value = [value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
       NSInteger length =0;
       if (!value)
       {
           return NO;
       }else
       {
           length = value.length;
           //不满足15位和18位，即身份证错误
           if (length !=15 && length !=18) {
               return NO;
           }
       }
       // 省份代码
       NSArray *areasArray = @[@"11",@"12", @"13",@"14", @"15",@"21", @"22",@"23", @"31",@"32", @"33",@"34", @"35",@"36", @"37",@"41", @"42",@"43", @"44",@"45", @"46",@"50", @"51",@"52", @"53",@"54", @"61",@"62", @"63",@"64", @"65",@"71", @"81",@"82", @"91"];
       // 检测省份身份行政区代码
       NSString *valueStart2 = [value substringToIndex:2];
       BOOL areaFlag =NO; //标识省份代码是否正确
       for (NSString *areaCode in areasArray) {
           if ([areaCode isEqualToString:valueStart2]) {
               areaFlag =YES;
               break;
           }
       }
       if (!areaFlag)
       {
           return NO;
       }
       NSRegularExpression *regularExpression;
       NSUInteger numberofMatch;
       int year =0;
       //分为15位、18位身份证进行校验
       switch (length)
       {
           case 15:
               //获取年份对应的数字
               year = [value substringWithRange:NSMakeRange(6,2)].intValue +1900;
               if (year %4 ==0 || (year %100 ==0 && year %4 ==0))
               {
                   //创建正则表达式 NSRegularExpressionCaseInsensitive：不区分字母大小写的模式
                   regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}$" options:NSRegularExpressionCaseInsensitive error:nil];//测试出生日期的合法性
               }else {
                   regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}$" options:NSRegularExpressionCaseInsensitive error:nil];//测试出生日期的合法性
               }
               //使用正则表达式匹配字符串 NSMatchingReportProgress:找到最长的匹配字符串后调用block回调
               numberofMatch = [regularExpression numberOfMatchesInString:value options:NSMatchingReportProgress range:NSMakeRange(0, value.length)];
               if(numberofMatch >0)
               {
                   return YES;
               }else {
                   return NO;
               }
           case 18:
               year = [value substringWithRange:NSMakeRange(6,4)].intValue;
               if (year %4 ==0 || (year %100 ==0 && year %4 ==0)) {
                   regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^((1[1-5])|(2[1-3])|(3[1-7])|(4[1-6])|(5[0-4])|(6[1-5])|71|(8[12])|91)\\d{4}(((19|20)\\d{2}(0[13-9]|1[012])(0[1-9]|[12]\\d|30))|((19|20)\\d{2}(0[13578]|1[02])31)|((19|20)\\d{2}02(0[1-9]|1\\d|2[0-8]))|((19|20)([13579][26]|[2468][048]|0[048])0229))\\d{3}(\\d|X|x)?$" options:NSRegularExpressionCaseInsensitive error:nil];//测试出生日期的合法性
               }else {
                   regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^((1[1-5])|(2[1-3])|(3[1-7])|(4[1-6])|(5[0-4])|(6[1-5])|71|(8[12])|91)\\d{4}(((19|20)\\d{2}(0[13-9]|1[012])(0[1-9]|[12]\\d|30))|((19|20)\\d{2}(0[13578]|1[02])31)|((19|20)\\d{2}02(0[1-9]|1\\d|2[0-8]))|((19|20)([13579][26]|[2468][048]|0[048])0229))\\d{3}(\\d|X|x)?$" options:NSRegularExpressionCaseInsensitive error:nil];//测试出生日期的合法性
               }
               numberofMatch = [regularExpression numberOfMatchesInString:value options:NSMatchingReportProgress range:NSMakeRange(0, value.length)];
               if(numberofMatch >0) {
                   //1：校验码的计算方法 身份证号码17位数分别乘以不同的系数。从第一位到第十七位的系数分别为：7－9－10－5－8－4－2－1－6－3－7－9－10－5－8－4－2。将这17位数字和系数相乘的结果相加。
                   int S = [value substringWithRange:NSMakeRange(0,1)].intValue*7 + [value substringWithRange:NSMakeRange(10,1)].intValue *7 + [value substringWithRange:NSMakeRange(1,1)].intValue*9 + [value substringWithRange:NSMakeRange(11,1)].intValue *9 + [value substringWithRange:NSMakeRange(2,1)].intValue*10 + [value substringWithRange:NSMakeRange(12,1)].intValue *10 + [value substringWithRange:NSMakeRange(3,1)].intValue*5 + [value substringWithRange:NSMakeRange(13,1)].intValue *5 + [value substringWithRange:NSMakeRange(4,1)].intValue*8 + [value substringWithRange:NSMakeRange(14,1)].intValue *8 + [value substringWithRange:NSMakeRange(5,1)].intValue*4 + [value substringWithRange:NSMakeRange(15,1)].intValue *4 + [value substringWithRange:NSMakeRange(6,1)].intValue*2 + [value substringWithRange:NSMakeRange(16,1)].intValue *2 + [value substringWithRange:NSMakeRange(7,1)].intValue *1 + [value substringWithRange:NSMakeRange(8,1)].intValue *6 + [value substringWithRange:NSMakeRange(9,1)].intValue *3;
                   //2：用加出来和除以11，看余数是多少？余数只可能有0－1－2－3－4－5－6－7－8－9－10这11个数字
                   int Y = S %11;
                   NSString *M =@"F";
                   NSString *JYM =@"10X98765432";
                   M = [JYM substringWithRange:NSMakeRange(Y,1)];// 3：获取校验位
                   NSString *lastStr = [value substringWithRange:NSMakeRange(17,1)];
                   NSLog(@"%@",M);
                   NSLog(@"%@",[value substringWithRange:NSMakeRange(17,1)]);
                   //4：检测ID的校验位
                   if ([lastStr isEqualToString:@"x"]) {
                       if ([M isEqualToString:@"X"]) {
                           return YES;
                       }else{
                           return NO;
                       }
                   }else{
                       if ([M isEqualToString:[value substringWithRange:NSMakeRange(17,1)]]) {
                           return YES;
                       }else {
                           return NO;
                       }
                   }
               }else {
                   return NO;
               }
           default:
               return NO;
       }
}


#pragma mark ===判断是否为电话号码===
//判断是否为电话号码
+ (BOOL)isValidateMobile:(NSString *)mobile{
    //手机号以13， 15，18开头，八个 \d 数字字符
       //NSString *phoneRegex = @"^((13[0-9])|(14[^4,\\D])|(15[^4,\\D])|(17[0-9])|(18[0-9]))\\d{8}$";
       NSString *phoneRegex = @"^((1[0-9]))\\d{9}$";
       NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
       return [phoneTest evaluateWithObject:mobile];
}


#pragma mark ===========对象和字符串互换===============
//将日期对象转为字符串
+ (NSString *)getDateStringWithDate:(double)date{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateString = [dateFormat stringFromDate:[NSDate dateWithTimeIntervalSince1970:date/1000]];
    return dateString;
}

//将时间字符串转为date对象
+ (NSDate *)toDateWithString: (NSString *)dateStr{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
       [dateFormatter setDateFormat:@"yyyy-MM-dd"];
       NSDate *date = [dateFormatter dateFromString:dateStr];
       return date;
}

#pragma mark ===========字典、数组、json===============
#pragma mark ===字典转json保留 space===
+ (NSString*)dictionaryToJson:(NSDictionary *)dic{
    if (dic != nil)
       {
           NSError *parseError = nil;
           NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:0 error:&parseError];
           
           NSString *jsonString;
           if (!jsonData)
           {
               NSLog(@"%@",parseError);
           }else
           {
               jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
           }
           
           NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
           
           NSRange range = {0,jsonString.length};
           
           //去掉字符串中的换行符
           
           [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range];
           
           return mutStr;
       }
       else
           return nil;
}
#pragma mark ===字典转json并去除其中的space===
+ (NSString*)dictionaryToJsonAndTrimSpace:(NSDictionary *)dic{
    if (dic != nil)
       {
           NSError *parseError = nil;
           NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:0 error:&parseError];
           
           NSString *jsonString;
           if (!jsonData)
           {
               NSLog(@"%@",parseError);
           }else
           {
               jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
           }
           
           NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
           
           NSRange range = {0,jsonString.length};
           
           //去掉字符串中的空格
           
           [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
           
           NSRange range2 = {0,mutStr.length};
           
           //去掉字符串中的换行符
           
           [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
           
           return mutStr;
       }
       else
           return nil;
}

#pragma mark ===数组转json===
+ (NSString*)arrayToJson:(NSArray *)array{
    if (array != nil)
    {
        NSError *parseError = nil;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:array options:NSJSONWritingPrettyPrinted error:&parseError];
        
        NSMutableString *transStr = [[NSMutableString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        [transStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:NSMakeRange(0, transStr.length)];
        [transStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:NSMakeRange(0, transStr.length)];
        
        return transStr;
    }
    else
        return nil;
}
#pragma mark ===json转字典===
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString{
    if (jsonString == nil)
    {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *err;
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    
    if(err)
    {
        [CXManager showBriefAlert:@"json解析失败"];
        return nil;
    }
    
    return dic;
}

#pragma mark ===json转数组===
+ (NSArray *)stringToArray:(NSString *)jsonString{
  
    
    NSMutableString *jsonDataString=[NSMutableString string];

    if (jsonString == nil)
       {
           return nil;
       }
       NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
       
       NSError *err;
       
        NSMutableArray *array = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
       
       if(err)
       {
//           [MBManager showBriefAlert:@"json解析失败" inView:nil];
           return nil;
       }
       
       return array;
  


    
    
    
}

#pragma mark ===字典转json保留 space===
+ (NSString*)dictionaryToString:(NSDictionary *)dic{
    if (dic != nil)
       {
           NSError *parseError = nil;
           NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:0 error:&parseError];
           
           NSString *jsonString;
           if (!jsonData)
           {
               NSLog(@"%@",parseError);
           }else
           {
               jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
           }
           
           NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
           
           NSRange range = {0,jsonString.length};
           
           //去掉字符串中的空格
           
           [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
           
           NSRange range2 = {0,mutStr.length};
           
           //去掉字符串中的换行符
           
           [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
           
//           去掉\
           
           [mutStr replaceOccurrencesOfString:@"\\" withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, mutStr.length)];
         
           
           
           return mutStr;
       }
       else
           return nil;
    
}
#pragma mark ===订单编号转字符串===
/**
 订单编号转字符串
 */
+ (NSString*)idArrayToString:(NSArray *)arr{
    NSString * ids = @"";
    for (NSString *str in arr) {
        if (ids.length == 0) {
            ids = str;
        }else{
            ids = [NSString stringWithFormat:@"%@,%@",ids,str];
        }
    }
    
    return ids;
    
}

#pragma mark ===NSSet转NSArray===
+ (NSArray *)setToArray:(NSSet *)set{
//    NSSortDescriptor *sd = [[NSSortDescriptor alloc] initWithKey:@"displayName" ascending:YES];
//    NSArray *sortDescriptors = [NSArray arrayWithObjects:sd, nil];
//    NSArray *arr = [set sortedArrayUsingDescriptors:sortDescriptors];
    NSMutableArray *array = [NSMutableArray array];
    for (id model in set) {
        [array addObject:model];
    }
    return array;
}




#pragma mark ===========时间===============
#pragma mark ===获取系统的当前时间===
//获取系统的当前时间
+ (NSString * )getSystemCurrentTime{
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [dateFormatter setTimeZone:timeZone];
    //    [dateFormatter setDateFormat:@"YYYY/MM/dd hh:mm:ss SS"];
    [dateFormatter setDateFormat:@"YYYY-MM-dd hh:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    return dateString;
}
#pragma mark ===根据时间得到星期===
//根据时间得到星期
+ (NSString*)weekdayStringFromDate:(NSDate*)inputDate{
    NSArray *weekdays = [NSArray arrayWithObjects:[NSNull null],@"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", nil];
       NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierChinese];
       NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
       [calendar setTimeZone: timeZone];
       NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
       NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:inputDate];
       return [weekdays objectAtIndex:theComponents.weekday];
}
#pragma mark ===========时间转时间戳===============
+(NSString *)transToTamp:(NSString *)time
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];// 创建一个时间格式化对象
        [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"]; //设定时间的格式
        NSDate *tempDate = [dateFormatter dateFromString:time];//将字符串转换为时间对象
        NSString *timeStr = [NSString stringWithFormat:@"%ld", (long)[tempDate timeIntervalSince1970]];//字符串转成时间戳,精确到毫秒*1000
        return timeStr;

    
    
    
}

#pragma mark ===时间戳转时间===
/// 时间戳--->时间
/// @param timstamp timsp 时间戳
///  @return 时间 yyyy-MM-dd HH:mm:ss
+(NSString *)transToTime:(NSString *)timstamp{
    NSTimeInterval time=[timstamp doubleValue];//如果不使用本地时区,因为时差问题要加8小时 == 28800 sec
       NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
       
       //实例化一个NSDateFormatter对象
       NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
       [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];//设置本地时区
       //设定时间格式,这里可以设置成自己需要的格式
       [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
       
       NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
       
       return currentDateStr;
}

#pragma mark ===时间戳转日期===
/// 时间戳--->时间
/// @param timstamp timsp 时间戳
///  @return 时间 yyyy-MM-dd
+(NSString *)transToDay:(NSString *)timstamp{
    NSTimeInterval time=[timstamp doubleValue];//如果不使用本地时区,因为时差问题要加8小时 == 28800 sec
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];//设置本地时区
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
    
    return currentDateStr;
}
#pragma mark ===UTC转GMT时间格式===
///输入的UTC日期格式2013-08-03T04:53:51+0000  UTC/GMT时间格式
+(NSString *)transUTCToGMT:(NSString *)utcDate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //输入格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZ"];
    NSTimeZone *localTimeZone = [NSTimeZone localTimeZone];
    [dateFormatter setTimeZone:localTimeZone];
    
    NSDate *dateFormatted = [dateFormatter dateFromString:utcDate];
    //输出格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:dateFormatted];
    
    return dateString;
}



#pragma mark =====当前时间的时间戳======
/// 当前时间的时间戳

+(NSString *)getCurrentTimeTimestamp{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss SSS"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    //设置时区,这个对于时间的处理有时很重要
    
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    
    [formatter setTimeZone:timeZone];
    
    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
    
    NSString *timeSp = [NSString stringWithFormat:@"%lld", (long long)[datenow timeIntervalSince1970]];
    
    return timeSp;
}

#pragma mark ===获取前一天===
/// 获取前一天
/// @param str yyyy-MM-dd
+ (NSString * )getYesterdayWithType:(NSString *)str{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
//       [dateFormatter setDateFormat:@"yyyy-MM-dd"];
      [dateFormatter setDateFormat:str];
       NSDate *date = [NSDate date];
       
       NSDate *nextDate = [NSDate dateWithTimeInterval:(-60*60*24) sinceDate:date];
       NSString *timeStr = [dateFormatter stringFromDate:nextDate];
    
    return timeStr;
}

#pragma mark ===获取当天===
/// 获取当天
/// @param str yyyy-MM-dd
+ (NSString * )getSystemCurrentdayWithType:(NSString *)str{
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    //       [dateFormatter setDateFormat:@"yyyy-MM-dd"];
          [dateFormatter setDateFormat:str];
           NSDate *date = [NSDate date];
           
           NSDate *nextDate = [NSDate dateWithTimeInterval:(60*60) sinceDate:date];
           NSString *timeStr = [dateFormatter stringFromDate:nextDate];
        
        return timeStr;
}
#pragma mark ===获取N天前===
/// 获取N天前
/// @param str yyyy-MM-dd
/// @param num 几天前
+ (NSString * )getSeveralDaysAgoWithType:(NSString *)str andDayNum:(NSInteger)num{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    //       [dateFormatter setDateFormat:@"yyyy-MM-dd"];
          [dateFormatter setDateFormat:str];
           NSDate *date = [NSDate date];
           
           NSDate *nextDate = [NSDate dateWithTimeInterval:(-60*60*24*num) sinceDate:date];
           NSString *timeStr = [dateFormatter stringFromDate:nextDate];
        
        return timeStr;
}

#pragma mark ====随机数=====
/// 随机数
+(NSString *)random{
    long long int x = arc4random() % 80000001 +10000000;
    NSString *str = [NSString stringWithFormat:@"%lld",x];
    return str;
}
#pragma mark ====md5加密======
/// md5加密
/// @param string <#string description#>
+ (NSString *)md5:(NSString *)string{
    const char *cStr = [string UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(cStr, (CC_LONG)strlen(cStr), digest);
    
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [result appendFormat:@"%02x", digest[i]];
    }
    return result;
}









#pragma mark ===========获得 lable高度===============
+ (CGFloat)getLableHeight:(NSString *)message yyLabel:(YYLabel *)lable lineSpacing:(CGFloat)lineSpace stringFont:(UIFont *)font

{

    NSMutableAttributedString *introText = [[NSMutableAttributedString alloc] initWithString:message];

    introText.yy_font = font;

    introText.yy_lineSpacing = lineSpace;//行间距

    lable.attributedText = introText;

    CGSize introSize = CGSizeMake(lable.frame.size.width, CGFLOAT_MAX);

    YYTextLayout *layout = [YYTextLayout layoutWithContainerSize:introSize text:introText];

    lable.textLayout = layout;

    CGFloat introHeight = layout.textBoundingSize.height;

    return introHeight;

}
#pragma mark ===========获得label宽度===============
+ (CGFloat)getLableWidth:(NSString *)message yyLabel:(YYLabel *)lable stringFont:(UIFont *)font

{

    NSMutableAttributedString *introText = [[NSMutableAttributedString alloc] initWithString:message];

    introText.yy_font = font;

    lable.attributedText = introText;

    CGSize introSize = CGSizeMake(CGFLOAT_MAX, lable.frame.size.height);

    YYTextLayout *layout = [YYTextLayout layoutWithContainerSize:introSize text:introText];

    lable.textLayout = layout;

    CGFloat introWidth = layout.textBoundingSize.width;

    return introWidth;

}

//根据字符串获取高度
+ (CGFloat)getHeightFromString:(NSString *)str width:(CGFloat)width fontSize:(CGFloat)fontSize{
    CGSize size = [str boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} context:nil].size;
       NSInteger height = (NSInteger)(size.height);
       return height;
}
#pragma mark ===获取字符串的长度===
+(CGFloat) getWidthForString:(NSString *)value fontSize:(CGFloat)fontSize{
   CGSize titleSize =  [value sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:fontSize]}];
    return titleSize.width;

    
}



#pragma mark ===========判断是否打开了定位===============
+(void)checkLocationStart:(UIViewController *)target andStart:(void (^)(void))start
{
    if([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied)
    {
        [CXManager hideAlert];
        
        [CXUITools showTwoAlertTitle:@"打开[定位服务]来允许[sitehelper]确定您的位置" andMsg:@"请在系统设置中开启定位服务(设置>隐私>定位服务>开启)" target:target :^{
            
            NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            if( [[UIApplication sharedApplication]canOpenURL:url] )
            {
                [[UIApplication sharedApplication] openURL:url];
            }
        }];
        
    }
    else
    {
        start();
        
       
    }
}

 #pragma mark ===========判断是否为模拟器===============
+(BOOL)isSimuLator
{
    if (TARGET_IPHONE_SIMULATOR == 1 && TARGET_OS_IPHONE == 1) {
        //模拟器
        return YES;
    }else{
        //真机
        return NO;
    }
}
#pragma mark ===========字符串去除两端的空白===============
+ (NSString *)removeWhitespaceAndNewlineFromBothEnd:(NSString *)str
{
    NSCharacterSet *whitespace = [NSCharacterSet  whitespaceAndNewlineCharacterSet];

    return [str stringByTrimmingCharactersInSet:whitespace];

}

#pragma mark ===========字符串去除所有空白===============
+ (NSString *)removeAllWhitespace:(NSString *)str
{
    NSString *tmpStr = [self removeWhitespaceAndNewlineFromBothEnd:str];

    NSString *finalString = [tmpStr stringByReplacingOccurrencesOfString:@" " withString:@""];

    return finalString;

}


#pragma mark- 震动、声音效果

#define SOUNDID  1109  //1012 -iphone   1152 ipad  1109 ipad
//+ (void)systemVibrate
//{
//    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
//}
//
//+ (void)systemSound
//{
//    AudioServicesPlaySystemSound(SOUNDID);
//}


#pragma mark ===========获取URL中的参数===============
+(NSMutableDictionary*)getURLParamWithUrlString:(NSString *)urlString {

NSRange range = [urlString rangeOfString:@"?"];

if(range.location==NSNotFound) {

return nil;

}

NSMutableDictionary *params = [NSMutableDictionary  dictionary];

NSString *parametersString = [urlString  substringFromIndex:range.location+1];

if([parametersString  containsString:@"&"]) {

NSArray *urlComponents = [parametersString  componentsSeparatedByString:@"&"];

for(NSString *keyValuePair in urlComponents) {

//生成key/value

NSArray *pairComponents = [keyValuePair componentsSeparatedByString:@"="];

NSString *key = [pairComponents.firstObject stringByRemovingPercentEncoding];

NSString*value = [pairComponents.lastObject stringByRemovingPercentEncoding];

//key不能为nil

if(key==nil|| value ==nil) {

continue;

}

id existValue = [params valueForKey:key];

if(existValue !=nil) {

//已存在的值，生成数组。

if([existValue isKindOfClass:[NSArray class]]) {

//已存在的值生成数组

NSMutableArray*items = [NSMutableArray arrayWithArray:existValue];

[items addObject:value];

[params setValue:items forKey:key];

}else{

//非数组

[params setValue:@[existValue,value]forKey:key];

}

}else{

//设置值

[params setValue:value forKey:key];

}

}

}else{

//单个参数生成key/value

NSArray *pairComponents = [parametersString componentsSeparatedByString:@"="];

if(pairComponents.count==1) {

return nil;

}

//分隔值

NSString *key = [pairComponents.firstObject stringByRemovingPercentEncoding];

NSString *value = [pairComponents.lastObject stringByRemovingPercentEncoding];

//key不能为nil

if(key ==nil|| value ==nil) {

return nil;

}

//设置值

[params setValue:value forKey:key];

}

return params;

}


#pragma mark ===========获取本来json文件===============
+ (NSMutableArray *)getLocalFileWithName:(NSString *)name {
    // 获取文件路径
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"json"];
    // 将文件数据化
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    // 对数据进行JSON格式化并返回字典形式
    return [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
}

#pragma mark ===========获取本来plist文件===============
+ (NSMutableArray *)getLocalPlistFileWithName:(NSString *)name{

    // 获取文件路径
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"plist"];
    // 将文件数据化
    NSMutableArray *arr = [NSMutableArray arrayWithContentsOfFile:path];
    // 对数据进行JSON格式化并返回字典形式
    return arr;


}




#pragma mark ===========清除缓存===============

+ (void)cleanCache{
//获取缓存路径
    NSString * path = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
    NSFileManager * manager = [NSFileManager defaultManager];
//判断是否存在缓存文件
    if ([manager fileExistsAtPath:path]) {
        NSArray * childFile = [manager subpathsAtPath:path];
//逐个删除缓存文件
        for (NSString *fileName in childFile) {
            NSString * absolutPat = [path stringByAppendingPathComponent:fileName];
            [manager removeItemAtPath:absolutPat error:nil];
        }
//删除sdwebimage的缓存
        [[SDWebImageManager sharedManager].imageCache clearWithCacheType:SDImageCacheTypeAll completion:nil];
    }
    
    
    
//这里是又调用了得到缓存文件大小的方法，是因为不确定是否删除了所有的缓存，所以要计算一遍，展示出来
//    [self getCacheSize];
}

+(NSString *)getCacheSize{
    NSString *folderPath=[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    
    NSFileManager * manager=[NSFileManager defaultManager ];
    if (![manager fileExistsAtPath :folderPath]) {
        return 0 ;
    }
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath :folderPath] objectEnumerator ];
    NSString * fileName;
    long long folderSize = 0 ;
    while ((fileName = [childFilesEnumerator nextObject ]) != nil ){
        NSString * fileAbsolutePath = [folderPath stringByAppendingPathComponent :fileName];
        folderSize += [ self fileSizeAtPath :fileAbsolutePath];
    }
    
    return [NSString stringWithFormat:@".2f",folderSize/( 1024.0 * 1024.0 )];

}
/**
 *  计算单个文件大小
 */
+(long long)fileSizeAtPath:(NSString *)filePath{
    
    NSFileManager *manager = [NSFileManager defaultManager];
    
    if ([manager fileExistsAtPath :filePath]){
        
        return [[manager attributesOfItemAtPath :filePath error : nil ] fileSize];
    }
    return 0 ;
    
}


#pragma mark ===========转换版本号为数字===============

+(NSString *)getVersionNumWithVersion:(NSString *)version{
    NSArray *arr = [version componentsSeparatedByString:@"."];
    NSString *str = @"";
    
    for (int i = 0; i < arr.count; i ++) {
        str = [NSString stringWithFormat:@"%@%@",str,arr[i]];
    }
    return str;
}

///1.表示当前版本大于线上版本，2.表示，等于当前版本，3.表示，当前版本，小于线上版本
+(int)compareCurrentVersionWithVerion:(NSString *)version{
    //        5、获取本地版本
            NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
            // 本地app版本
            NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
     
    NSArray *arrline = [version componentsSeparatedByString:@"."];
    NSArray *arrapp = [app_Version componentsSeparatedByString:@"."];
    
    int code = 0;
    
    NSInteger n = (arrline.count> arrapp.count)?arrapp.count : arrline.count;
       for (int i = 0; i< n; i ++) {

           NSInteger a = [[arrline objectAtIndex:i] integerValue];

           NSInteger b = [[arrapp objectAtIndex:i] integerValue];

           if (a > b) {

//               NSLog(@"有新版本");

               code = 3;
               break;
           }else if(a < b){

               code = 1;
               break;
           }
          
           code = 2;
           
       }

    return code;
}


#pragma mark ===========获取所有range===============
+ (NSArray*)getAllRangeOfSubString:(NSString*)subStr inString:(NSString*)string{
    
    NSMutableArray *rangeArray = [NSMutableArray array];
    
    NSString*string1 = [string stringByAppendingString:subStr];
    
    NSString *temp;
    
    for(int i =0; i < string.length; i ++) {
        
        temp = [string1 substringWithRange:NSMakeRange(i, subStr.length)];
        
        if ([temp isEqualToString:subStr]) {
            
            NSRange range = {i,subStr.length};
            
            [rangeArray addObject: [NSValue valueWithRange:range]];
            
        }
        
    }
    
    //    备注：得到返回的数组后，取出来的元素是NSValue，需要转换成NSRange使用
    //
    //    NSRange range = [value rangeValue];
    
    return rangeArray;
}



#pragma mark ===========获取库内部文件路径===============
+(NSString *)getInnerPathWithClass:(id)classN andFileName:(NSString *)fileName andFileType:(NSString *)fileType{
    NSBundle *bundle = [NSBundle bundleForClass:classN];
    NSString *filePath = [bundle pathForResource:fileName ofType:fileType inDirectory:@"CXKit.bundle"];
    
    return filePath;
}


#pragma mark ===========获取库内部文件Bundle===============
+(NSBundle *)getMainBundle{
    
    NSBundle* bundle = [NSBundle bundleWithPath:[[NSBundle bundleForClass:[self class]] pathForResource:@"CXKit" ofType:@"bundle"]];
    return bundle;
    
}

@end
