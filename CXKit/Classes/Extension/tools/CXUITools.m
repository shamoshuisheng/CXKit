//
//  CXUITools.m
//
//
//  Created by 灿汐 on 2020/6/21.
//  Copyright © 2020 hntnet. All rights reserved.
//

#import "CXUITools.h"
#import <AVFoundation/AVAsset.h>
#import <AVFoundation/AVAssetImageGenerator.h>
#import <AVFoundation/AVTime.h>
@implementation CXUITools
static CXUITools *instance = nil;

#pragma mark ===========单例===============
+(instancetype)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc]init];
    });
    return instance;
}
#pragma mark ===========创建tableView===============
+(UITableView *)creatTableView:(CGRect)rect andTableViewStyle:(UITableViewStyle)tableStyle andTarget:(id)target andSeparatorStyle:(UITableViewCellSeparatorStyle)separatorMode andCellReuseId:(NSString *)cellID andUseCellNib:(BOOL)useNib  andCellName:(NSString *)cellNmae andBackGroundColor:(UIColor *)color
{
    UITableView *tableView = [[UITableView alloc]initWithFrame:rect style:tableStyle];
    tableView.delegate = target;
    tableView.dataSource = target;
    tableView.separatorStyle = separatorMode;
    tableView.backgroundColor = color;
    tableView.showsVerticalScrollIndicator = NO;
    tableView.showsHorizontalScrollIndicator = NO;
//    tableView.estimatedRowHeight = 0.0;
    tableView.estimatedSectionFooterHeight = 0.0;
    tableView.estimatedSectionHeaderHeight = 0.0;

//        if (@available(iOS 11.0, *))
//        {
//            tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
//        } else {
//            // 针对 11.0 以下的iOS系统进行处理
//            // 不要自动调整inset
//            UIViewController *vc = target;
//            vc.automaticallyAdjustsScrollViewInsets = NO;
//        }
    if (useNib) {
        // 注册cell
        [tableView registerNib:[UINib nibWithNibName:cellNmae bundle:nil] forCellReuseIdentifier:cellID];
    } else{
        [tableView registerClass:NSClassFromString(cellNmae) forCellReuseIdentifier:cellID];
    }
    if (@available(iOS 15.0, *)) {
       tableView.sectionHeaderTopPadding = 0;
    }
    return tableView;
}

#pragma mark ===========创建一个webView===============
+ (WKWebView *)createWebView:(CGRect)frame urlString:(NSString *)urlStr
{
    
     WKWebViewConfiguration *configuration = [WKWebViewConfiguration new];
          
          WKPreferences *preference = [WKPreferences new];
          preference.minimumFontSize = 15;
          configuration.preferences = preference;
      WKWebView * webView = [[WKWebView alloc]initWithFrame:frame configuration: configuration];
      webView.backgroundColor = CXColorFromRGB(0xf5f5f5);

    NSURL * url = [NSURL URLWithString:urlStr];
    [webView loadRequest:[NSURLRequest requestWithURL:url]];
    //开了支持滑动返回
        webView.allowsBackForwardNavigationGestures = YES;
    return webView;
}


+ (WKWebView *)createWebView:(CGRect)frame contentString:(NSString *)contentString andBaseURLString:(NSString *)baseUrlString{
    WKWebViewConfiguration *configuration = [WKWebViewConfiguration new];
        
        WKPreferences *preference = [WKPreferences new];
        preference.minimumFontSize = 15;
        configuration.preferences = preference;
    WKWebView * webView = [[WKWebView alloc]initWithFrame:frame configuration: configuration];
    webView.backgroundColor = CXColorFromRGB(0xf5f5f5);
       

        //开了支持滑动返回
        webView.allowsBackForwardNavigationGestures = YES;
    //    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.help_url]]];
        [webView loadHTMLString:contentString baseURL:[NSURL URLWithString:baseUrlString]];
     
    
    
    
    return webView;
}
#pragma mark ===========创建一个scrollView===============

+(UIScrollView *)creatScrollView:(CGRect)rect andTarget:(UIViewController *)target andScrollEnabled:(BOOL)scrollEnabled andPagingEnabled:(BOOL)pagingEnabled andBounces:(BOOL)bounces
{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:rect];
    scrollView.scrollEnabled = scrollEnabled;
    scrollView.pagingEnabled = pagingEnabled;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.bounces = bounces;
        if (@available(iOS 11.0, *))
        {
            scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }else
        {
            // 针对 11.0 以下的iOS系统进行处理
            target.automaticallyAdjustsScrollViewInsets = NO;
        }
    
    return scrollView;
}

#pragma mark ===========创建一个imageView===============
//图片 有边框圆角

+(UIImageView *)createImageView:(CGRect)rect andImageViewName:(NSString *)imageName andLayerBorderWidth:(NSInteger)borderWidth andBorderColor:(UIColor *)color andCornerRadius:(NSInteger)cornerRadius
{
    UIImageView * imageV = [[UIImageView alloc]initWithFrame:rect];
    imageV.userInteractionEnabled = YES;
    if (imageName)
    {
        imageV.image = [UIImage imageNamed:imageName];
    }
    
    if (borderWidth) {
        imageV.layer.borderWidth = borderWidth;
        imageV.layer.borderColor = color.CGColor;
    }
    if (cornerRadius)
    {
        imageV.layer.cornerRadius = cornerRadius;
        imageV.layer.masksToBounds =YES;
    }
    
    return imageV;
}
+(UIImageView *)createImageView:(CGRect)rect andImageViewName:(NSString *)imageName{
    UIImageView *imageV = [[UIImageView alloc]initWithFrame:rect];
      imageV.userInteractionEnabled = YES;
      if (imageName)
      {
          imageV.image = [UIImage imageNamed:imageName];
      }
      return imageV;
}

#pragma mark ===========创建通过颜色一个图片===============
 +(UIImage *)createImageFromColor:(UIColor *)color rect:(CGRect)rect{
    
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

#pragma mark ===========创建渐变色图片===============
+(UIImage *)createGradientImageWithBounds:(CGRect)bounds andColors:(NSArray*)colors andGradientType:(GradientDirection)gradientType{
    NSMutableArray *ar = [NSMutableArray array];

       for(UIColor *c in colors) {
          [ar addObject:(id)c.CGColor];
       }
       UIGraphicsBeginImageContextWithOptions(bounds.size, YES, 1);
       CGContextRef context = UIGraphicsGetCurrentContext();
       CGContextSaveGState(context);
       CGColorSpaceRef colorSpace = CGColorGetColorSpace([[colors lastObject] CGColor]);
       CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef)ar, NULL);
       CGPoint startPt =  CGPointMake(0.0, 0.0);
       CGPoint endPt =  CGPointMake(0.0, 0.0);

      switch (gradientType) {
          case GradientDirectionTopToBottom:
             startPt= CGPointMake(0.0, 0.0);
             endPt= CGPointMake(0.0, bounds.size.height);
          break;
          case GradientDirectionLeftToRight:
             startPt = CGPointMake(0.0, 0.0);
             endPt = CGPointMake(bounds.size.width, 0.0);
          break;
          case GradientDirectionBottomToTop:
             startPt = CGPointMake(0.0, bounds.size.height);
             endPt = CGPointMake(0.0, 0.0);
          break;
          case GradientDirectionRightToLeft:
             startPt = CGPointMake(bounds.size.width, 0.0);
             endPt = CGPointMake(0, 0.0);
          break;
     }
     CGContextDrawLinearGradient(context, gradient, startPt, endPt, kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
     UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
     CGGradientRelease(gradient);
     CGContextRestoreGState(context);
     CGColorSpaceRelease(colorSpace);
     UIGraphicsEndImageContext();
     return image;
    
}

#pragma mark ===========通过颜色和文字创建一个图片===============
+ (UIImage *)createImageWithColor:(UIColor *)color
                          ImageSize:(CGSize)size
                          text:(NSString *)text
                         textSize:( CGFloat)textSize{
    if (!color || size.width <= 0 || size.height <= 0) return nil;
        CGRect rect = CGRectMake(0, 0, size.width, size.height);
        UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
        CGContextRef context = UIGraphicsGetCurrentContext();
        
      
        
        // color
        CGContextSetFillColorWithColor(context, color.CGColor);
        CGContextFillRect(context, rect);
        
        // text
 
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    
    
    NSString *headerName = nil;
        if (text.length < 2) {
            headerName = text;
        }else{
            headerName = [text substringFromIndex:text.length-1];
        }
        UIImage *headerimg = [self imageToAddText:image withText:headerName andSize:textSize];
        return headerimg;
        
    
}
//把文字绘制到图片上
+ (UIImage *)imageToAddText:(UIImage *)img withText:(NSString *)text andSize:(CGFloat)size
{
    //1.获取上下文
    UIGraphicsBeginImageContext(img.size);
    //2.绘制图片
    [img drawInRect:CGRectMake(0, 0, img.size.width, img.size.height)];
    //3.绘制文字
    CGRect rect = CGRectMake((img.size.width)/2 - size/2 ,(img.size.height)/2 - size/2 -1, size, size);
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
    style.alignment = NSTextAlignmentCenter;
    //文字的属性
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:size-2],NSParagraphStyleAttributeName:style,NSForegroundColorAttributeName:[UIColor whiteColor]};
    //将文字绘制上去
    [text drawInRect:rect withAttributes:dic];
    //4.获取绘制到得图片
    UIImage *watermarkImg = UIGraphicsGetImageFromCurrentImageContext();
    //5.结束图片的绘制
    UIGraphicsEndImageContext();

    return watermarkImg;
}


#pragma mark ===========获取视频第一帧===============

+ (UIImage *)getImageFromVideoPreViewImage:(NSURL *)path{
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:path options:nil];
        AVAssetImageGenerator *assetGen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
        
        assetGen.appliesPreferredTrackTransform = YES;
        CMTime time = CMTimeMakeWithSeconds(0.0, 600);
        NSError *error = nil;
        CMTime actualTime;
        CGImageRef image = [assetGen copyCGImageAtTime:time actualTime:&actualTime error:&error];
        UIImage *videoImage = [[UIImage alloc] initWithCGImage:image];
        CGImageRelease(image);
        return videoImage;
}



#pragma mark ===========view转image===============
//使用该方法不会模糊，根据屏幕密度计算
+ (UIImage *)viewToImage:(UIView *)view {
    
    UIGraphicsBeginImageContext(view.bounds.size);
       [view.layer renderInContext:UIGraphicsGetCurrentContext()];
       UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
       UIGraphicsEndImageContext();
       return image;
}

#pragma mark ===========叠加图片===============

+ (UIImage *)addImage:(UIImage *)image1 withImage:(UIImage *)image2{
    
    UIGraphicsBeginImageContext(image1.size);

    //UIGraphicsBeginImageContextWithOptions(image.size, NO, [UIScreen mainScreen].scale);//这样就不模糊了

    [image1 drawInRect:CGRectMake(0, 0, image1.size.width, image1.size.height)];

    [image2 drawInRect:CGRectMake((image1.size.width - image2.size.width)/2,(image1.size.height - image2.size.height)/2, image2.size.width, image2.size.height)];

    UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();

    UIGraphicsEndImageContext();

    return resultingImage;

}






#pragma mark ===========创建label===============
+(UILabel *)creatLabel:(CGRect)rect andBackGroundColor:(UIColor*)backColor andTextAlignment:(NSInteger)alignment andFont:(UIFont *)font andTextColor:(UIColor *)textColor andText:(NSString *)text
{
    UILabel *label = [[UILabel alloc]init];
    label.frame = rect;
    if (backColor)
    {
        label.backgroundColor = backColor;
    }
    label.userInteractionEnabled = YES;
    label.textAlignment = alignment;
    label.font  = font;
    label.textColor = textColor;
    label.text  =  text;
    return label;
}

#pragma mark ===========创建button===============

+(UIButton *)createButton:(CGRect)rect andTarget:(id)target andSeletor:(SEL)sel andTitleColor:(UIColor *)titleColor andFont:(UIFont *)font andBackGroundColor:(UIColor *)backGroundColor andBackGroundImage:(NSString *)backImage andTitle:(NSString *)title
{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = rect;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    [button setBackgroundColor:backGroundColor];
    if (backImage)
    {
        [button setBackgroundImage:[UIImage imageNamed:backImage] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:backImage] forState:UIControlStateHighlighted];
    }
    button.titleLabel.font = font;
    [button addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    
    return button   ;
}

#pragma mark ===========创建view===============
+(UIView *)creatBackGroundView:(CGRect)rect AndColor:(UIColor *)color
{
    UIView *label = [[UIView alloc]initWithFrame:rect];
    label.backgroundColor = color;
    return label;
}

+(UIView *)createGradientView:(CGRect)rect andStartColor:(UIColor *)startColor andEndColor:(UIColor *)endColor andIsLongitudinal:(BOOL)isLong{
    UIView *view = [[UIView alloc] initWithFrame:rect];
    
    NSArray *colors = [NSArray arrayWithObjects:(id)startColor.CGColor, (id)endColor.CGColor, nil];
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    
    //设置开始和结束位置(通过开始和结束位置来控制渐变的方向)
    if (isLong) {
        gradient.startPoint = CGPointMake(0, 1);
        gradient.endPoint = CGPointMake(0, 0);
    }else{
        gradient.startPoint = CGPointMake(0, 1);
        gradient.endPoint = CGPointMake(1, 1);
    }
 
    
    gradient.colors = colors;
    
    gradient.frame = rect;
//    CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, HNTNavBarHeight);
    
    [view.layer insertSublayer:gradient atIndex:0];
    
    
    return view;
    
}

#pragma mark ===创建lineView===
+(UIView *)creatLineView:(CGRect)rect
{
    UIView *label = [[UIView alloc]initWithFrame:rect];
    label.backgroundColor = CXColorFromRGB(0xF5F5F5);
    return label;
}

#pragma mark ===========创建textField===============

+(UITextField *)creatTextFiled:(CGRect)rect andPlaceHolder:(NSString *)placeholder andText:(NSString *)text andSecureTextEntry:(BOOL)flag andClearsOnBeginEditing:(BOOL)clearFlag andClearButtonMode:(BOOL)clearButtonFlag andKeyBoardType:(UIKeyboardType)keyBoardType
{
    UITextField *textFiled = [[UITextField alloc]initWithFrame:rect];
    textFiled.placeholder = placeholder;
    textFiled.text = text;
    textFiled.secureTextEntry = flag;
    textFiled.clearsOnBeginEditing = clearFlag;
    textFiled.clearButtonMode = clearButtonFlag;
    textFiled.font = [UIFont systemFontOfSize:15];
    textFiled.keyboardType = keyBoardType;
    return textFiled;
}

#pragma mark ===========创建一个alertView===============
+(void)showTwoAlertTitle:(NSString *)title andMsg:(NSString *)msg  target:(UIViewController *)target :(void (^)(void))completion
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction * cancelAction2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {}];
    
    UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        if (completion)
        {
            completion();
        }
    }];
    
    [alertController addAction:cancelAction2];
    [alertController addAction:cancelAction];
    
    [target presentViewController:alertController animated:YES completion:nil];
}



#pragma mark ===========++++++++++++++===============




#pragma mark ===========获取当前屏幕显示的viewcontroller===============
//获取当前屏幕显示的viewcontroller
+ (UIViewController *)getCurrentVC
{
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    UIViewController *currentVC = [self getCurrentVCFrom:rootViewController];
    
    return currentVC;
}

+ (UIViewController *)getCurrentVCFrom:(UIViewController *)rootVC
{
    UIViewController *currentVC;
    
    if ([rootVC presentedViewController]) {
        // 视图是被presented出来的
        
        rootVC = [rootVC presentedViewController];
    }
    
    if ([rootVC isKindOfClass:[UITabBarController class]]) {
        // 根视图为UITabBarController
        
        currentVC = [self getCurrentVCFrom:[(UITabBarController *)rootVC selectedViewController]];
        
    } else if ([rootVC isKindOfClass:[UINavigationController class]]){
        // 根视图为UINavigationController
        
        currentVC = [self getCurrentVCFrom:[(UINavigationController *)rootVC visibleViewController]];
        
    } else {
        // 根视图为非导航类
        
        currentVC = rootVC;
    }
    
    return currentVC;
}




#pragma mark ===========dismiss到最底层的控制器===============
+(void)dismissToRootViewController:(UIViewController *)target  {
    UIViewController *vc = target;
    while (vc.presentingViewController) {
      vc = vc.presentingViewController;
    }
    [vc dismissViewControllerAnimated:YES completion:nil];
}



/*
 周边加阴影，并且同时圆角
 */
+ (void)addShadowToView:(UIView *)view
            withOpacity:(float)shadowOpacity
           shadowRadius:(CGFloat)shadowRadius
        andCornerRadius:(CGFloat)cornerRadius
{
    if (shadowRadius > 0) {
        view.layer.shadowOffset = CGSizeMake(0, 0);
        view.layer.shadowOpacity = shadowOpacity;
        view.layer.shadowRadius = shadowRadius;
    } else{
        view.layer.masksToBounds = YES;
    }
  
    view.layer.cornerRadius = cornerRadius;
    
}

#pragma mark ===========collectionView===============
+(UICollectionView *)collectionViewWithLayout:(UICollectionViewFlowLayout *)layout andFrame:(CGRect)frame andContentInset:(UIEdgeInsets)contentInset andTarget:(id)vc andNibCellName:(NSString *)cellName andCellID:(NSString *)cellID andHeaderName:(NSString *)headerName andHeaderId:(NSString *)headerId
{
 
//        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
//        layout.itemSize = CGSizeMake(ItemWidth, ItemHeight);
        //在垂直方向  设置的是cell上下之间的最小间距 在水平方向  设置的是cell左右之间的最小间距
        layout.minimumLineSpacing = 10.0 ;
        //在垂直方向  设置的是cell左右之间的最小间距 在水平方向  设置的是cell上下之间的最小间距
        layout.minimumInteritemSpacing = 10.0;
        //        layout.headerReferenceSize = CGSizeMake(self.width, 45);
        //        layout.footerReferenceSize = CGSizeMake(self.width, 10);
        
        //layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        
        UICollectionView *collectionView   = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:layout];
        collectionView.contentInset = UIEdgeInsetsMake(0 , 10, 0, 5);
        collectionView.delegate = vc;
        collectionView.dataSource = vc;
        collectionView.scrollEnabled = YES;
        collectionView.backgroundColor = [UIColor clearColor];
        collectionView.showsVerticalScrollIndicator = NO;
        
        [collectionView registerNib:[UINib nibWithNibName:cellName bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:cellID];
        [collectionView registerClass:[headerName class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerId];
      
        
    
    return collectionView;
}
/*
 添加border，并且同时圆角
*/

+ (void)addborderToView:(UIView *)view andBorderColor:(UIColor *)borderColor andBorderWidth:(float)borderWidth andCornerRadius:(CGFloat)cornerRadius{
    view.layer.borderColor = borderColor.CGColor;
    view.layer.borderWidth = borderWidth;
    view.layer.cornerRadius = cornerRadius;
    view.layer.masksToBounds = YES;
}


#pragma mark ===========中划线===============
+(NSMutableAttributedString *)createUnderLineAttributeStingWithString:(NSString *)str{
    NSDictionary *attDic = @{NSStrikethroughStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc]initWithString:str attributes:attDic];
    return attStr;
}

@end
