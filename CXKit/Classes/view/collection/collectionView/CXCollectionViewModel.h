//
//  CXBaseTableViewModel.h
//
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class CXCollectionView;
typedef UICollectionViewCell* (^CollectionCellCallBlock)(NSIndexPath *indexPath,UICollectionView* collectionView,id model);

typedef CGFloat (^CollectionCellHeightBlock)(NSIndexPath *indexPath,UICollectionView* collectionView);


typedef UICollectionReusableView* (^CollectionHeaderCallBlock)(NSIndexPath * indexPath,UICollectionView* collectionView,NSString *kind);

typedef CGFloat (^CollectionHeaderHeightBlock)(NSInteger section,UICollectionView* collectionView);



typedef void (^CollectionHeaderRefreshingBlock)(CXCollectionView *collectionView);

typedef void (^CollectionFooterRefreshingBlock)(CXCollectionView *collectionView);


typedef enum : NSUInteger {
    ///横向
    CollectionViewStyleHorizontal,
    ///纵向
    CollectionViewStyleVertical,
} CollectionViewStyle;


#define CXPropStatementAndPropSetFuncStatement(propertyModifier,className, propertyPointerType, propertyName)           \
@property(nonatomic,propertyModifier)propertyPointerType  propertyName;                                                 \
- (className * (^) (propertyPointerType propertyName)) propertyName##Set;



#define CXPropSetFuncImpl(className, propertyPointerType, propertyName)                                       \
- (className * (^) (propertyPointerType propertyName))propertyName##Set{                                                \
return ^(propertyPointerType propertyName) {                                                                            \
_##propertyName = propertyName;                                                                                         \
return self;                                                                                                            \
};                                                                                                                      \
}




@interface CXCollectionViewModel : NSObject


#pragma mark ===========通用属性===============
/**
    布局方向，如果是横向，则ratio必须初始化
 */
CXPropStatementAndPropSetFuncStatement(assign, CXCollectionViewModel, CollectionViewStyle, collectionViewStyle);
///数据源
CXPropStatementAndPropSetFuncStatement(strong, CXCollectionViewModel, NSMutableArray*, dataSource);
///是否允许滚动
CXPropStatementAndPropSetFuncStatement(assign, CXCollectionViewModel, BOOL, allowScroll);
///是否分页
CXPropStatementAndPropSetFuncStatement(assign, CXCollectionViewModel, BOOL, pagingEnabled);
///cell名字
CXPropStatementAndPropSetFuncStatement(strong, CXCollectionViewModel, NSArray*, cellNameArray);

///用于设置cell
CXPropStatementAndPropSetFuncStatement(copy, CXCollectionViewModel, CollectionCellCallBlock, collectionCellCallBlock);






/**
 纵向时，设置cell高度，
 横向时，此数据返回为宽度，且，此宽度只在非均分的情况下有效
 */
CXPropStatementAndPropSetFuncStatement(copy, CXCollectionViewModel, CollectionCellHeightBlock, collectionCellHeightBlock);

///header
CXPropStatementAndPropSetFuncStatement(copy, CXCollectionViewModel, CollectionHeaderCallBlock, collectionHeaderCallBlock);

///header高度
CXPropStatementAndPropSetFuncStatement(copy, CXCollectionViewModel, CollectionHeaderHeightBlock, collectionHeaderHeightBlock);
///用于多header
CXPropStatementAndPropSetFuncStatement(strong, CXCollectionViewModel, NSMutableArray*, headerNameArray);

///列数,纵向时，如果不赋值，则此项为2，横向时，如果不赋值，则此项为4
CXPropStatementAndPropSetFuncStatement(assign, CXCollectionViewModel, NSInteger, num);

///间隔，左右间隔皆为此项,如果不赋值，则此项为15
CXPropStatementAndPropSetFuncStatement(assign, CXCollectionViewModel, CGFloat, interval);

///行间距,如果不赋值，则为自动计算，
CXPropStatementAndPropSetFuncStatement(assign, CXCollectionViewModel, CGFloat, lineSpace);
///首先间距,用于某些特殊情况，首先和header之间不需要间隔，如果不赋值，则为自动计算，,如果为横向，则此内容
CXPropStatementAndPropSetFuncStatement(assign, CXCollectionViewModel, CGFloat, topLineSpace);

///最后一个元素，和底部的距离
CXPropStatementAndPropSetFuncStatement(assign, CXCollectionViewModel, CGFloat, bottomLength);



#pragma mark ===========横向时需初始化===============

/**
 宽高比，宽/高得到的数据,横向时，此属性必须初始化,
 纵向，等宽时，可以使用此项来设置cell高度
 */
CXPropStatementAndPropSetFuncStatement(assign, CXCollectionViewModel, CGFloat, ratio);
/**
 是否平均分配到当前屏幕，此属性需要与num共同使用，完成均分
 */
CXPropStatementAndPropSetFuncStatement(assign, CXCollectionViewModel, BOOL, isAverage);



#pragma mark ===========纵向时需初始化===============

/**
 是否设置sectionHeader停留,默认YES
 */
CXPropStatementAndPropSetFuncStatement(assign, CXCollectionViewModel, BOOL, isStickyHeader);




#pragma mark ===========刷新相关===============
/**
 允许刷新
 */
CXPropStatementAndPropSetFuncStatement(assign, CXCollectionViewModel, BOOL, allowRefresh);
/**
 下拉刷新
 */
CXPropStatementAndPropSetFuncStatement(copy, CXCollectionViewModel, CollectionHeaderRefreshingBlock, collectionHeaderRefreshingBlock);

/**
 上拉加载
 */
CXPropStatementAndPropSetFuncStatement(copy, CXCollectionViewModel, CollectionFooterRefreshingBlock, collectionFooterRefreshingBlock);

#pragma mark ===========空页面===============
///是否显示空页面
CXPropStatementAndPropSetFuncStatement(assign, CXCollectionViewModel, BOOL, showEmpty);
///空页面图片名称
CXPropStatementAndPropSetFuncStatement(copy, CXCollectionViewModel, NSString *, emptyImageName);
///空页面图片尺寸
CXPropStatementAndPropSetFuncStatement(assign, CXCollectionViewModel, CGSize, emptyImageSize);

///空页面描述
CXPropStatementAndPropSetFuncStatement(copy, CXCollectionViewModel, NSString *, emptyTitleName);





CXCollectionViewModel *CXCollectionParam(void);

@end

NS_ASSUME_NONNULL_END
