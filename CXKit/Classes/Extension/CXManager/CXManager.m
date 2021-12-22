//
//  CXManager.m
//  ctrip360
//
//  Created by hntnet on 2021/1/3.
//

#import "CXManager.h"

@implementation CXManager

WMZDialog *myAlert;

/**
 *  显示“加载中”，带圈圈，若要修改直接修改kLoadingMessage的值即可
 */
+ (void)showLoading{
    myAlert =
    Dialog()
    //加载框颜色
    .wLoadingColorSet([UIColor whiteColor])
    //无文字
    .wTitleSet(@"loading")
    //毛玻璃背景
//    .wEffectShowSet(NO)
    .wTypeSet(DialogTypeLoading)
    //加载框type
    .wLoadingTypeSet(LoadingStyleWait)
    .wShadowColorSet([UIColor blackColor])
    .wShadowAlphaSet(0.5)
    .wShadowCanTapSet(NO)
    //动画时间
    .wAnimationDurtionSet(2)
    //加载框大小
    .wLoadingSizeSet(CGSizeMake(50, 50))
    .wStart();
 
    //自动消失
    [myAlert performSelector:@selector(closeView) withObject:nil afterDelay:10];

}


+ (void)showLoadingC{
    myAlert =
    Dialog()
    //加载框颜色
    .wLoadingColorSet([UIColor whiteColor])
    //无文字
    .wTitleSet(@"loading")
    //毛玻璃背景
//    .wEffectShowSet(NO)
    .wTypeSet(DialogTypeLoading)
    //加载框type
    .wLoadingTypeSet(LoadingStyleWait)
    .wShadowColorSet([UIColor blackColor])
    .wShadowAlphaSet(0.5)
    .wShadowCanTapSet(NO)
    //动画时间
    .wAnimationDurtionSet(2)
    //加载框大小
    .wLoadingSizeSet(CGSizeMake(50, 50))
    .wStart();

}



/**
 *  显示简短的提示语，默认2秒钟，时间可直接修改kShowTime
 *
 *  @param alert 提示信息
 */
+ (void) showBriefAlert:(NSString *) alert{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        Dialog().wTypeSet(DialogTypeAuto)
        .wMessageSet(alert)
        //自动消失时间 默认1.5
        .wDisappelSecondSet(1)
        .wStart();
    });
    
   
}


/**
 *  显示简短的提示语，默认2秒钟，时间可直接修改kShowTime
 *
 *  @param alert 提示信息
 */
+ (void) showBriefAlert:(NSString *) alert andTime:(int)time{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        Dialog().wTypeSet(DialogTypeAuto)
        .wMessageSet(alert)
        //自动消失时间 默认1.5
        .wDisappelSecondSet(time)
        .wStart();
    });
}

+(void)hideAlert{
    
    [myAlert closeView];

}

#pragma mark ===========alert===============
+ (void)showAlertWithTitle:(NSString *)title andTitleColor:(UIColor *)titleColor andDesc:(NSString *)desc andDescColor:(UIColor *)descColor andCancelTitle:(NSString *)cancelTitle andCancelTitleColor:(UIColor *)cancelColor andFinishTitle:(NSString *)finishTitle andFinishColor:(UIColor *)finishColor andClick:(void(^)(NSInteger index))finished{
    
    Dialog()
    .wMessageSet(desc)
    .wTitleSet(title)
    .wOKTitleSet(finishTitle)
    .wCancelTitleSet(cancelTitle)
    .wMessageColorSet(descColor)
    
    .wTitleColorSet(titleColor)
    .wOKColorSet(finishColor)
    .wCancelColorSet(cancelColor)
    .wTitleFontSet(14)
    .wEventCancelFinishSet(^(id anyID, id otherData) {
        finished(0);
    })
    .wEventOKFinishSet(^(id anyID, id otherData) {
        finished(1);
    })
    .wTypeSet(DialogTypeNornal).wStart();

}


#pragma mark ===========picker===============
+ (void)showPickerView:(NSArray *)arr andOkTitle:(NSString *)okTitle andOkTitleColor:(UIColor *)okColor andCancelTitle:(NSString *)cancelTitle  andCancelTitleColor:(UIColor *)cancelColor  andFinished:(void(^)(id dic))finished{
    if (!okColor) {
        okColor = [UIColor redColor];
    }
    if (!cancelColor) {
        cancelColor = [UIColor grayColor];
    }
    
    
        Dialog()
       .wTitleSet(@"")
       .wOKTitleSet(okTitle)
       .wOKColorSet(okColor)
       .wCancelTitleSet(cancelTitle)
        .wCancelColorSet(cancelColor)
       .wTypeSet(DialogTypePickSelect)
       .wEventOKFinishSet(^(id anyID, id otherData) {
             
           finished(anyID);
        })
       //一层直接传入带字典/字符串的数组 name为显示的文字 其他携带的model可以自由传入
       .wDataSet(arr)
       .wStart();
    
    
    
}



+(void)showPhotoSheet{
   
    /**
     选择照片回调，回调解析好的图片、对应的asset对象、是否原图
     pod 2.2.6版本之后 统一通过selectImageBlock回调
     */

   
    
    
    ZLPhotoPreviewSheet *actionSheet = [[ZLPhotoPreviewSheet alloc] init];
    ZLPhotoConfiguration *config = [ZLPhotoConfiguration default];
    config.maxSelectCount = 2;
    [actionSheet setSelectImageBlock:^(NSArray<UIImage *> * _Nonnull images, NSArray<PHAsset *> * _Nonnull assets, BOOL isOriginal) {
        
        
    }];
    
    [actionSheet showPhotoLibraryWithSender:[CXUITools getCurrentVC]];
    
}



@end
