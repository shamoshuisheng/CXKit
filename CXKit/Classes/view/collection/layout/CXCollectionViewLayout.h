//
//  CXCollectionViewLayout.h

//

//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class CXCollectionViewLayout;
@protocol CXCollectionViewLayoutDelegate <NSObject>
//Inspired by UITableViewDelegate 😄
/**
 *  返回所在section的每个item的width（一个section只有一个width）
 *
 */
- (CGFloat)collectionView:(nonnull UICollectionView *)collectionView
                   layout:(nonnull CXCollectionViewLayout *)collectionViewLayout
   widthForItemInSection:( NSInteger )section;
/**
 *  返回所在indexPath的每个item的height（每个item有一个height，要不然怎么是瀑布流😄）
 *
 */
- (CGFloat)collectionView:(nonnull UICollectionView *)collectionView
                   layout:(nonnull CXCollectionViewLayout *)collectionViewLayout
 heightForItemAtIndexPath:(nonnull NSIndexPath *)indexPath;

@optional
/**
 *  返回所在indexPath的header的height
 *
*/
- (CGFloat) collectionView:(nonnull UICollectionView *)collectionView
                    layout:(nonnull CXCollectionViewLayout *)collectionViewLayout
heightForHeaderAtIndexPath:(nonnull NSIndexPath *)indexPath;
/**
 *  返回所在indexPath的footer的height
 *
 */
- (CGFloat) collectionView:(nonnull UICollectionView *)collectionView
                    layout:(nonnull CXCollectionViewLayout *)collectionViewLayout
heightForFooterAtIndexPath:(nonnull NSIndexPath *)indexPath;
/**
 *  返回所在section与上一个section的间距(表达的可能不够准确，但是你们都懂的)
 *
 */
- (CGFloat) collectionView:(nonnull UICollectionView *)collectionView
                    layout:(nonnull CXCollectionViewLayout *)collectionViewLayout
topInSection:(NSInteger )section;
/**
 *  返回所在section与下一个section的间距(表达的可能不够准确，但是你们都懂的)
 *
 */
- (CGFloat) collectionView:(nonnull UICollectionView *)collectionView
                    layout:(nonnull CXCollectionViewLayout *)collectionViewLayout
            bottomInSection:( NSInteger)section;
/**
 *  返回所在section的header停留时与顶部的距离（如果设置isTopForHeader ＝ YES ，则距离会叠加）
 *
 */
- (CGFloat) collectionView:(nonnull UICollectionView *)collectionView
                    layout:(nonnull CXCollectionViewLayout *)collectionViewLayout
           headerToTopInSection:( NSInteger)section;


-(void) collectionView:(nonnull UICollectionView *)collectionView
           andHeight:(CGFloat)height;
@end
typedef NS_ENUM(NSUInteger,CXStickHeaderAlignment)
{
    CXStickHeaderAlignmentLeft =0,
    CXStickHeaderAlignmentcenter
};


@interface CXCollectionViewLayout : UICollectionViewLayout

@property (nonatomic, assign,nonnull)  id<CXCollectionViewLayoutDelegate> delegate;
//当你用UINavigationController和UITabbarViewController并设置一些属性时，collectionview的展示视图的坐标y会变得很奇怪，那就在此修正,默认64
@property (nonatomic,assign) CGFloat fixTop;
//对齐方式一个是靠最左边，一个是靠中间
@property(nonatomic,assign) CXStickHeaderAlignment headAlignment;
//是否设置sectionHeader停留,默认YES
@property (nonatomic) BOOL isStickyHeader;
//section停留的位置是否包括原来设置的top，默认NO
@property (nonatomic) BOOL isTopForHeader;

@property (nonatomic) BOOL isStickyFooter;

///行间距
@property (nonatomic ,assign) CGFloat lineSpace;

///首先间距
@property (nonatomic ,assign) CGFloat topLineSpace;


@end

NS_ASSUME_NONNULL_END
