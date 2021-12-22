//
//  CXUtilsMacros.h


//

#ifndef CXUtilsMacros_h
#define CXUtilsMacros_h

/**
 调试阶段，用CXLog代替NSLog
 发布阶段，CXLog就不会打印
 */
#ifdef DEBUG
#define CXLog(...) NSLog(__VA_ARGS__)
#else
#define CXLog(...)
#endif
/**宏定义方法的打印方式*/
#define HXLogFunc HXLog(@"%s", __func__)
//获取系统对象
#define CXApplication        [UIApplication sharedApplication]
#define CXAppWindow          [UIApplication sharedApplication].delegate.window
#define CXAppDelegate        [AppDelegate shareAppDelegate]
#define CXRootViewController [UIApplication sharedApplication].delegate.window.rootViewController
#define CXUserDefaults       [NSUserDefaults standardUserDefaults]



///IOS 版本判断
#define IOSAVAILABLEVERSION(version) ([[UIDevice currentDevice] availableVersion:version] < 0)
// 当前系统版本
#define CXCurrentSystemVersion [[UIDevice currentDevice].systemVersion doubleValue]


//-------------------打印日志-------------------------
//DEBUG  模式下打印日志,当前行
#ifdef DEBUG
#define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define DLog(...)
#endif

//拼接字符串
#define CXStringFormat(format,...) [NSString stringWithFormat:format,##__VA_ARGS__]


//定义UIImage对象
#define CXImageWithFile(_pointer) [UIImage imageWithContentsOfFile:([[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@@%dx", _pointer, (int)[UIScreen mainScreen].nativeScale] ofType:@"png"])]


//数据验证
#define CXStrValid(f) (f!=nil && [f isKindOfClass:[NSString class]] && ![f isEqualToString:@""])
#define CXSafeStr(f) (StrValid(f) ? f:@"")
#define CXHasString(str,key) ([str rangeOfString:key].location!=NSNotFound)

#define CXValidStr(f) StrValid(f)
#define CXValidDict(f) (f!=nil && [f isKindOfClass:[NSDictionary class]])
#define CXValidArray(f) (f!=nil && [f isKindOfClass:[NSArray class]] && [f count]>0)
#define CXValidNum(f) (f!=nil && [f isKindOfClass:[NSNumber class]])
#define CXValidClass(f,cls) (f!=nil && [f isKindOfClass:[cls class]])
#define CXValidData(f) (f!=nil && [f isKindOfClass:[NSData class]])

// 是否为空对象
#define CXObjectIsNil(__object)  ((nil == __object) || [__object isKindOfClass:[NSNull class]])
// 字符串为空
#define CXStringIsEmpty(__string) ((__string.length == 0) || MHObjectIsNil(__string))

//获取一段时间间隔
#define CXStartTime CFAbsoluteTime start = CFAbsoluteTimeGetCurrent();
#define CXEndTime  NSLog(@"Time: %f", CFAbsoluteTimeGetCurrent() - start)


//发送通知
#define CXPostNotification(name,obj) [[NSNotificationCenter defaultCenter] postNotificationName:name object:obj];

//单例化一个类
#define CXSinglton_For_HEADER(className) \
\
+ (className *)shared##className;

#define SINGLETON_FOR_CLASS(className) \
\
+ (className *)shared##className { \
static className *shared##className = nil; \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
shared##className = [[self alloc] init]; \
}); \
return shared##className; \
}

//判断是否是ipad
#define CXisPad ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)

//获取屏幕宽高
#define CXScreenWidth ([[UIScreen mainScreen] bounds].size.width)
#define CXScreenHeight ([[UIScreen mainScreen] bounds].size.height)
#define CXScreen_Bounds [UIScreen mainScreen].bounds

#define CXIphone6ScaleWidth CXScreenWidth/375.0
#define CXIphone6ScaleHeight CXScreenHeight/667.0

//根据ip6的屏幕来拉伸
#define CXRealWidth(with) ((with)*(CXScreenWidth/375.0f))
//缺省页高度
#define CXEmptyViewSize(with) CGSizeMake(CXRealWidth(with), CXRealWidth(with*(306.f/313.f)))

// 5/5s/se         4.0寸   320*568
#define CXISIPHONE_5  (CXScreenWidth == 320.0f && CXScreenHeight == 568)
// 6/6s/7/8        4.7寸   375*667
#define CXISIPHONE_6  (CXScreenWidth == 375.0f && CXScreenHeight == 667)
// 6p/6ps/7p/8p    5.5寸   414*736
#define CXISIPHONE_6P (CXScreenWidth == 414.0f && CXScreenHeight == 736)

#define CXISIPHONE_se1 (CXScreenWidth == 320.0f && CXScreenHeight == 568)

#define CXISIPHONE_se2  (CXScreenWidth == 375.0f && CXScreenHeight == 667)
// iPhonex         5.8寸   375*812
#define CXISIPHONE_X (CXScreenWidth == 375.0f && CXScreenHeight == 812)
//判断iPHoneXr
#define CXISIPHONE_Xr  (CXScreenWidth == 414.0f && CXScreenHeight == 896)

//判断iPhoneXs
#define CXISIPHONE_Xs (CXScreenWidth == 375.0f && CXScreenHeight == 812)

//判断iPhoneXs Max
#define CXISIPHONE_Xs_Max  (CXScreenWidth == 414.0f && CXScreenHeight == 896)

//判断iPhone11
#define CXISIPHONE_11 (CXScreenWidth == 414.0f && CXScreenHeight == 896)
//判断iPhone11 pro
#define CXISIPHONE_11_pro (CXScreenWidth == 375.0f && CXScreenHeight == 812)
//判断iPhone11 pro max
#define CXISIPHONE_11_pro_max (CXScreenWidth == 414.0f && CXScreenHeight == 896)


//判断iPhone11
#define CXISIPHONE_12 (CXScreenWidth == 390.0f && CXScreenHeight == 844)
//判断iPhone11 pro
#define CXISIPHONE_12_pro (CXScreenWidth == 390.0f && CXScreenHeight == 844)
//判断iPhone11 pro max
#define CXISIPHONE_12_pro_max (CXScreenWidth == 428.0f && CXScreenHeight == 926)

#define CXStatus_Bar_Height [[UIApplication sharedApplication] statusBarFrame].size.height

#define CXSingleNavBarHeight 44.f


#define CXSingleTabBarHeight 49.f
// 定义底部安全高度

#define CXBottomHeight (((CXISIPHONE_X) || (CXISIPHONE_Xr) || (CXISIPHONE_Xs) || (CXISIPHONE_Xs_Max) || (CXISIPHONE_11) || (CXISIPHONE_11_pro) || (CXISIPHONE_11_pro_max) || (CXISIPHONE_12) || (CXISIPHONE_12_pro) || (CXISIPHONE_12_pro_max)) ? 34.0f : 0.0f)
// 定义顶部安全高度
#define CXTopHeight (((CXISIPHONE_X) || (CXISIPHONE_Xr) || (CXISIPHONE_Xs) || (CXISIPHONE_Xs_Max) || (CXISIPHONE_11) || (CXISIPHONE_11_pro) || (CXISIPHONE_11_pro_max) || (CXISIPHONE_12) || (CXISIPHONE_12_pro) || (CXISIPHONE_12_pro_max)) ? 44.f : 20.0f)

// 定义导航栏高度
#define CXNavBarHeight (CXTopHeight+CXSingleNavBarHeight) //CXISIPHONE_X ? 88.0f : 64.0f
// 定义Tabbar高度
#define CXTabBarHeight (CXSingleTabBarHeight+CXBottomHeight)

/** 强引用 */
#define CXStrongSelf(type) __strong typeof(type) type = weak##type;
/** 弱引用 */
#define CXWeakSelf(type)  __weak typeof(type) weak##type = type;



// View 圆角
#define CXViewRadius(View, Radius)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES]

/**设置 view 圆角和边框*/
#define CXViewBorderRadius(View, Radius, Width, Color)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]]

/**设置 view 圆角和阴影*/
#define CXViewShadowRadius(View, cornerRadius,shadowRadius,shadowOffset, shadowOpacity, shadowColor)\
\
[View.layer setCornerRadius:(cornerRadius)];\
[View.layer setMasksToBounds:NO];\
[View.layer setShadowRadius:(shadowRadius)];\
[View.layer setShadowOffset:(shadowOffset)];\
[View.layer setShadowOpacity:(shadowOpacity)];\
[View.layer setShadowColor:[shadowColor CGColor]];


/**获取图片资源*/
#define CXGetImage(imageName) [UIImage imageNamed:[NSString stringWithFormat:@"%@",imageName]]
/**获取temp*/
#define CXPathTemp NSTemporaryDirectory()
/**获取沙盒 Document*/
#define CXPathDocument [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]
/**获取沙盒 Cache*/
#define CXPathCache [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]

/** 程序版本号 */
#define CXAPP_VERSION [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
/** 获取APP build版本 */
#define CXAPP_BUILD ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"])


#endif /* CXUtilsMacros_h */
