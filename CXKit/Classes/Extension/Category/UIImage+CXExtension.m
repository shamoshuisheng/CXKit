//
//  UIImage+HXExtension.m
//  HX
//
//  Created by hxrc on 16/12/10.
//  Copyright © 2016年 xgt. All rights reserved.
//

#import "UIImage+CXExtension.h"
#import <Accelerate/Accelerate.h>
@implementation UIImage (CXExtension)

+(UIImage *)originalImageWithImageName:(NSString *)name;
{
    UIImage *image = [UIImage imageNamed:name];
    // 不渲染
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    return image;
}

+ (UIImage *)blurImage:(UIImage *)image blur:(CGFloat)blur;
{
    // 模糊度越界
    
    if (blur < 0.f || blur > 1.f) {
        blur = 0.5f;
    }

    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *inputImage= [CIImage imageWithCGImage:image.CGImage];
    //设置filter
    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"];
    [filter setValue:inputImage forKey:kCIInputImageKey];
    [filter setValue:@(blur) forKey: @"inputRadius"];
    //模糊图片
    CIImage *result=[filter valueForKey:kCIOutputImageKey];
    CGImageRef outImage=[context createCGImage:result fromRect:[result extent]];
    UIImage *blurImage=[UIImage imageWithCGImage:outImage];
    CGImageRelease(outImage);
    return blurImage;
    
    //毛玻璃效果
    /*
    int boxSize = (int)(blur * 40);
    boxSize = boxSize - (boxSize % 2) + 1;
    CGImageRef img = image.CGImage;
    vImage_Buffer inBuffer, outBuffer;
    vImage_Error error;
    void *pixelBuffer;
    //从CGImage中获取数据
    CGDataProviderRef inProvider = CGImageGetDataProvider(img);
    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
    //设置从CGImage获取对象的属性
    inBuffer.width = CGImageGetWidth(img);
    inBuffer.height = CGImageGetHeight(img);
    inBuffer.rowBytes = CGImageGetBytesPerRow(img);

    inBuffer.data = (void*)CFDataGetBytePtr(inBitmapData);

    pixelBuffer = malloc(CGImageGetBytesPerRow(img) *
                         CGImageGetHeight(img));

    if(pixelBuffer == NULL)
        NSLog(@"No pixelbuffer");

    outBuffer.data = pixelBuffer;
    outBuffer.width = CGImageGetWidth(img);
    outBuffer.height = CGImageGetHeight(img);
    outBuffer.rowBytes = CGImageGetBytesPerRow(img);

    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);

    if (error) {
        NSLog(@"error from convolution %ld", error);
    }

    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef ctx = CGBitmapContextCreate(
                                             outBuffer.data,
                                             outBuffer.width,
                                             outBuffer.height,
                                             8,
                                             outBuffer.rowBytes,
                                             colorSpace,
                                             kCGImageAlphaNoneSkipLast);
    CGImageRef imageRef = CGBitmapContextCreateImage (ctx);
    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];

    CGContextRelease(ctx);
    CGColorSpaceRelease(colorSpace);

    free(pixelBuffer);
    CFRelease(inBitmapData);

    CGColorSpaceRelease(colorSpace);
    CGImageRelease(imageRef);
    
    return returnImage;
     */
}

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    if (color) {
        CGRect rect = CGRectMake(0, 0, size.width, size.height);
        UIGraphicsBeginImageContext(rect.size);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context,color.CGColor);
        CGContextFillRect(context, rect);
        UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return img;
    }
    return nil;
}

+ (UIImage *)circleImage:(UIImage *)originImage borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth
{
    //设置边框宽度
    CGFloat imageWH = originImage.size.width;
    
    //计算外圆的尺寸
    CGFloat ovalWH = imageWH + 2 * borderWidth;
    
    //开启上下文
    UIGraphicsBeginImageContextWithOptions(originImage.size, NO, 0);
    
    //画一个大的圆形
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, ovalWH, ovalWH)];
    
    [borderColor set];
    
    [path fill];
    
    //设置裁剪区域
    UIBezierPath *clipPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(borderWidth, borderWidth, imageWH, imageWH)];
    [clipPath addClip];
    
    //绘制图片
    [originImage drawAtPoint:CGPointMake(borderWidth, borderWidth)];
    
    //从上下文中获取图片
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    
    //关闭上下文
    UIGraphicsEndImageContext();
    return resultImage;
}

/**
 绘制带有圆弧的图片 四个角
 */
- (UIImage *)drawCircularIconWithSize:(CGSize )imgSize withRadius:(CGFloat)radius
{
    //    //开启上下文
    UIGraphicsBeginImageContextWithOptions(imgSize, NO, 0.0);
    //    //获取绘制圆的半径，宽，高的一个区域
    CGFloat width = imgSize.width;
    CGFloat height = imgSize.height;
    CGRect rect = CGRectMake(0, 0, width, height);
    //    //使用UIBerierPath路径裁切，注意：先设置裁切路径，再绘制图像。
    UIBezierPath *berzierPath = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius];
    //添加到裁切路径
    [berzierPath addClip];
    //    //将图片绘制到裁切好的区域内
    [self drawInRect:rect];
    //    //从上下文获取当前 绘制成圆形的图片
    UIImage *resImage = UIGraphicsGetImageFromCurrentImageContext();
    //    //关闭上下文
    UIGraphicsEndImageContext();
    
    //    //开启上下文
    //    UIGraphicsBeginImageContextWithOptions(imgSize, NO, 1.0);
    //    //获取上下文
    //    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //    //添加一个圆
    //    CGFloat width = imgSize.width;
    //    CGFloat height = width;
    //    CGRect rect = CGRectMake(0, 0, width, height);
    //    CGContextAddEllipseInRect(ctx, rect);
    //    //裁剪
    //    CGContextClip(ctx);
    //    //将图片绘制到裁切好的区域内
    //    [self drawInRect:rect];
    //    //从上下文获取当前 绘制成圆形的图片
    //    UIImage *resImage = UIGraphicsGetImageFromCurrentImageContext();
    //    //关闭上下文
    //    UIGraphicsEndImageContext();
    
    return resImage;
}


- (UIImage *)drawPointCircleWithSize:(CGSize )imgSize byRoundingCorners:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii;
{
    //    //开启上下文
    UIGraphicsBeginImageContextWithOptions(imgSize, NO, 0.0);
    //    //获取绘制圆的半径，宽，高的一个区域
    CGFloat width = imgSize.width;
    CGFloat height = imgSize.height;
    CGRect rect = CGRectMake(0, 0, width, height);
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corners cornerRadii:cornerRadii];
    //添加到裁切路径
    [maskPath addClip];
    //    //将图片绘制到裁切好的区域内
    [self drawInRect:rect];
    //    //从上下文获取当前 绘制成圆形的图片
    UIImage *resImage = UIGraphicsGetImageFromCurrentImageContext();
    //    //关闭上下文
    UIGraphicsEndImageContext();
    
    //    //开启上下文
    //    UIGraphicsBeginImageContextWithOptions(imgSize, NO, 1.0);
    //    //获取上下文
    //    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //    //添加一个圆
    //    CGFloat width = imgSize.width;
    //    CGFloat height = width;
    //    CGRect rect = CGRectMake(0, 0, width, height);
    //    CGContextAddEllipseInRect(ctx, rect);
    //    //裁剪
    //    CGContextClip(ctx);
    //    //将图片绘制到裁切好的区域内
    //    [self drawInRect:rect];
    //    //从上下文获取当前 绘制成圆形的图片
    //    UIImage *resImage = UIGraphicsGetImageFromCurrentImageContext();
    //    //关闭上下文
    //    UIGraphicsEndImageContext();
    
    return resImage;
}

- (UIImage*) maskImage:(UIImage *)image withMask:(UIImage *)maskImage {
    
    CGImageRef maskRef = maskImage.CGImage;
    
    CGImageRef mask = CGImageMaskCreate(CGImageGetWidth(maskRef),
                                        CGImageGetHeight(maskRef),
                                        CGImageGetBitsPerComponent(maskRef),
                                        CGImageGetBitsPerPixel(maskRef),
                                        CGImageGetBytesPerRow(maskRef),
                                        CGImageGetDataProvider(maskRef), NULL, false);
    
    CGImageRef masked = CGImageCreateWithMask([image CGImage], mask);
    return [UIImage imageWithCGImage:masked];
    
}

+ (UIImage *)fixOrientation:(UIImage *)aImage
{
    // No-op if the orientation is already correct
    if (aImage.imageOrientation == UIImageOrientationUp)
        return aImage;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
                                             CGImageGetBitsPerComponent(aImage.CGImage), 0,
                                             CGImageGetColorSpace(aImage.CGImage),
                                             CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (aImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}
@end
