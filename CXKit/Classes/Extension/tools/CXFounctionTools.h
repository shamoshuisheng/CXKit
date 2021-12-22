//
//  CXFounctionTool.h

//

#import <Foundation/Foundation.h>
#import "CXDefineHeader.h"
#import "YYText.h"
#import "CXManager.h"
#import "CXUITools.h"
#import "SDWebImage.h"
NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger
{
    /// 手机号 验证码等纯数字
    CXNumberNormal,
    /// 浮点型数字
    CXNumberFloat,
    /// 身份证
    CXNumberIDCard,
    /// 数字加字母
    CXNumberWord,
} CXNumberType;

typedef void(^CleanCacheBlock) (void);
@interface CXFounctionTool : NSObject



#pragma mark ===========判断是否为首次登录===============

+(BOOL)isFirstLaunch;


#pragma mark ===========判断字符串是否为指定类型===============
+ (BOOL)validateString:(NSString*)number withType:(CXNumberType)type;

#pragma mark ===========验证邮箱===============
//验证邮箱格式的正则表达式
+(BOOL)isValidateEmail:(NSString *)email;

#pragma mark ===========身份证号码验证===============
#pragma mark ===身份证号 格式验证 （模糊）===
///身份证号 格式验证 （模糊）
/// 模糊返回是否是身份证号
/// @param identityCard 身份证号
+ (BOOL) validateIdentityCard: (NSString *)identityCard;
#pragma mark ===身份证号 真假验证 （精确）===
/**
 身份证号 真假验证 （精确）
 
 @param value 身份证号
 @return 精确返回是否是身份证号
 */
+(BOOL)validateIDCardNumber:(NSString *)value;


#pragma mark ===判断是否为电话号码===
//判断是否为电话号码
+ (BOOL)isValidateMobile:(NSString *)mobile;



#pragma mark ===========对象和字符串互换===============
//将日期对象转为字符串
+ (NSString *)getDateStringWithDate:(double)date;

//将时间字符串转为date对象
+ (NSDate *)toDateWithString: (NSString *)dateStr;

#pragma mark ===========国际化===============
//+(NSString *)getStringWithOString:(NSString *)oString

#pragma mark ===========字典、数组、json===============
#pragma mark ===字典转json保留 space===
+ (NSString*)dictionaryToJson:(NSDictionary *)dic;
#pragma mark ===字典转json并去除其中的space===
+ (NSString*)dictionaryToJsonAndTrimSpace:(NSDictionary *)dic;
#pragma mark ===数组转json===
+ (NSString*)arrayToJson:(NSArray *)array;
#pragma mark ===json转字典===
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;
#pragma mark ===json转数组===
+ (NSArray *)stringToArray:(NSString *)jsonString;

#pragma mark ===字典转json保留 space===
+ (NSString*)dictionaryToString:(NSDictionary *)dic;

#pragma mark ===订单编号转字符串===
/**
 订单编号转字符串
 */
+ (NSString*)idArrayToString:(NSArray *)arr;

#pragma mark ===NSSet转NSArray===
+ (NSArray *)setToArray:(NSSet *)set;


#pragma mark ===========时间===============
#pragma mark ===获取系统的当前时间===
//获取系统的当前时间
+ (NSString * )getSystemCurrentTime;
#pragma mark ===根据时间得到星期===
//根据时间得到星期
+ (NSString*)weekdayStringFromDate:(NSDate*)inputDate;

#pragma mark ===时间戳转时间===
/// 时间戳--->时间
/// @param timstamp timsp 时间戳
///  @return 时间 yyyy-MM-dd HH:mm:ss
+(NSString *)transToTime:(NSString *)timstamp;

#pragma mark ===时间转时间戳===
/// <#Description#>
/// @param time  yyyy-MM-dd HH:mm:ss
///@return timstamp timsp 时间戳
+(NSString *)transToTamp:(NSString *)time;


#pragma mark ===时间戳转日期===
/// 时间戳--->时间
/// @param timstamp timsp 时间戳
///  @return 时间 yyyy-MM-dd HH:mm:ss
+(NSString *)transToDay:(NSString *)timstamp;

#pragma mark ===UTC转GMT时间格式===
///输入的UTC日期格式2013-08-03T04:53:51+0000  UTC/GMT时间格式
+(NSString *)transUTCToGMT:(NSString *)utcDate;


#pragma mark ===获取前一天===
/// 获取前一天
/// @param str yyyy-MM-dd
+ (NSString * )getYesterdayWithType:(NSString *)str;

#pragma mark ===获取当天===
/// 获取当天
/// @param str yyyy-MM-dd
+ (NSString * )getSystemCurrentdayWithType:(NSString *)str;

#pragma mark ===获取N天前===
/// 获取N天前
/// @param str yyyy-MM-dd
/// @param num 几天前
+ (NSString * )getSeveralDaysAgoWithType:(NSString *)str andDayNum:(NSInteger)num;

#pragma mark =====当前时间的时间戳======
/// 当前时间的时间戳

+(NSString *)getCurrentTimeTimestamp;

#pragma mark ====随机数=====
/// 随机数
+(NSString *)random;
#pragma mark ====md5加密======
/// md5加密
/// @param string <#string description#>
+ (NSString *)md5:(NSString *)string;



#pragma mark ===========获得Label高度和宽度===============
/**

*  @param message lable.text

*  @param lable (YYLabel *)label

*  @return lable的高度

*/

+ (CGFloat)getLableHeight:(NSString *)message yyLabel:(YYLabel *)lable lineSpacing:(CGFloat)lineSpace stringFont:(UIFont *)font;

/**

*  @param message lable.text

*  @param lable (YYLabel *)label

*  @return lable的宽度

*/
+ (CGFloat)getLableWidth:(NSString *)message yyLabel:(YYLabel *)lable stringFont:(UIFont *)font;


//根据字符串获取高度
+ (CGFloat)getHeightFromString:(NSString *)str width:(CGFloat)width fontSize:(CGFloat)fontSize;

#pragma mark ===获取字符串的长度===
+(CGFloat) getWidthForString:(NSString *)value fontSize:(CGFloat)fontSize;


#pragma mark ===========判断是否打开了定位===============
+(void)checkLocationStart:(UIViewController *)target andStart:(void (^)(void))start;

#pragma mark ===========创建alertAction打开地图===============


 #pragma mark ===========判断是否为模拟器===============
+(BOOL)isSimuLator;

#pragma mark ===========字符串去除两端的空白===============
+ (NSString *)removeWhitespaceAndNewlineFromBothEnd:(NSString *)str;

#pragma mark ===========字符串去除所有空白===============
+ (NSString *)removeAllWhitespace:(NSString *)str;



#pragma mark- 震动、声音效果

#define SOUNDID  1109  //1012 -iphone   1152 ipad  1109 ipad
+ (void)systemVibrate;

+ (void)systemSound;


#pragma mark ===========获取URL中的参数===============
+(NSMutableDictionary*)getURLParamWithUrlString:(NSString *)urlString;


#pragma mark ===========获取本来json文件===============
+ (NSMutableArray *)getLocalFileWithName:(NSString *)name;


#pragma mark ===========获取本来plist文件===============
+ (NSMutableArray *)getLocalPlistFileWithName:(NSString *)name;


#pragma mark ===========清除缓存===============

+ (void)cleanCache;

+(NSString *)getCacheSize;

#pragma mark ===========转换版本号为数字===============
+(NSString *)getVersionNumWithVersion:(NSString *)version;

#pragma mark ===========比较当前版本号和应当商店内的版本号===============
///1.表示当前版本大于线上版本，2.表示，等于当前版本，3.表示，当前版本，小于线上版本
+(int)compareCurrentVersionWithVerion:(NSString *)version;

#pragma mark ===========获取所有range===============
+ (NSArray*)getAllRangeOfSubString:(NSString*)subStr inString:(NSString*)string;


#pragma mark ===========获取库内部文件路径===============
+(NSString *)getInnerPathWithClass:(id)classN andFileName:(NSString *)fileName andFileType:(NSString *)fileType;

#pragma mark ===========获取库内部文件Bundle===============
+(NSBundle *)getMainBundle;



@end

NS_ASSUME_NONNULL_END
