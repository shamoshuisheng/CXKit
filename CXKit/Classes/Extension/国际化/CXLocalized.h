//
//  CXLocalized.h
//

#import <Foundation/Foundation.h>
#import "CXDefineHeader.h"

NS_ASSUME_NONNULL_BEGIN
//语言切换
static NSString * const AppLanguage = @"appLanguage";
#define CXLocalized(key, comment)  [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:AppLanguage]] ofType:@"lproj"]] localizedStringForKey:(key) value:@"" table:nil]

@interface CXLocalized : NSObject

+ (CXLocalized *)sharedInstance;

//初始化多语言功能
- (void)initLanguage;

//当前语言
- (NSString *)currentLanguage;

//设置要转换的语言
- (void)setLanguage:(NSString *)language;

//设置为系统语言
- (void)systemLanguage;

@end

NS_ASSUME_NONNULL_END
