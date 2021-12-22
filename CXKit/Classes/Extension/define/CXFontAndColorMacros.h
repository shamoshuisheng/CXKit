//
//  CXFontAndColorMacros.h


//

#ifndef CXFontAndColorMacros_h
#define CXFontAndColorMacros_h


#pragma mark -  颜色区

/**宏定义RGB颜色的调用方式*/
#define CXRGBColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
/**宏定义RGBA颜色的调用方式*/
#define CXRGBAColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]
/// rgb颜色转换（16进制->10进制）
#define CXColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

/**宏定义应用主题色调用方式*/

#define CXT3Color CXColorFromRGB(0x333333)
#define CXT6Color CXColorFromRGB(0x666666)
#define CXT9Color CXColorFromRGB(0x999999)
#define CXTEColor CXColorFromRGB(0xEEEEEE)

#define CXWhiteColor [UIColor whiteColor]

#define CXBGColor CXColorFromRGB(0xF5F6FA)
#define CXBlueColor CXColorFromRGB(0x2079E8)
/**宏定义项目的视图背景色调用方式*/
/**宏定义项目的主色调调用方式*/
#define CXBlackColor CXColorFromRGB(0x28272C)
/**宏定义项目按钮不可点击的主色调调用方式*/
#define CXGrayColor CXColorFromRGB(0xE5E5E5)

#define CXRedColor CXColorFromRGB(0xF23B30)


/**设置随机颜色*/
#define CXRandomColor [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0]

#define CXClearColor [UIColor clearColor]

//字体
#pragma mark -  字体区


#define CXSystemFont(FONTSIZE)     [UIFont systemFontOfSize:FONTSIZE]
#define CXFont(NAME, FONTSIZE)     [UIFont fontWithName:(NAME) size:(FONTSIZE)]


#endif /* CXFontAndColorMacros_h */
