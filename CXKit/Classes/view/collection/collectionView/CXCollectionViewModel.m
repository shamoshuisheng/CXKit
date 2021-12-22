//
//  CXCollectionViewModel.m

//
//

#import "CXCollectionViewModel.h"

@implementation CXCollectionViewModel



#pragma mark ===========通用属性===============
/**
    布局方向，如果是横向，则ratio必须初始化
 */
CXPropSetFuncImpl(CXCollectionViewModel, CollectionViewStyle, collectionViewStyle);
///数据源
CXPropSetFuncImpl( CXCollectionViewModel, NSMutableArray*, dataSource);
///是否允许滚动
CXPropSetFuncImpl( CXCollectionViewModel, BOOL, allowScroll);
///是否分页
CXPropSetFuncImpl( CXCollectionViewModel, BOOL, pagingEnabled);
///cell名字
CXPropSetFuncImpl( CXCollectionViewModel, NSArray*, cellNameArray);

///用于设置cell
CXPropSetFuncImpl(CXCollectionViewModel, CollectionCellCallBlock, collectionCellCallBlock);

CXPropSetFuncImpl(CXCollectionViewModel, CollectionCellHeightBlock, collectionCellHeightBlock);


///header
CXPropSetFuncImpl(CXCollectionViewModel, CollectionHeaderCallBlock, collectionHeaderCallBlock);

///header高度
CXPropSetFuncImpl(CXCollectionViewModel, CollectionHeaderHeightBlock, collectionHeaderHeightBlock);
///用于多header
CXPropSetFuncImpl( CXCollectionViewModel, NSMutableArray*, headerNameArray);

///列数,纵向时，如果不赋值，则此项为2，横向时，如果不赋值，则此项为4
CXPropSetFuncImpl( CXCollectionViewModel, NSInteger, num);

///间隔，左右间隔皆为此项,如果不赋值，则此项为15
CXPropSetFuncImpl(CXCollectionViewModel, CGFloat, interval);

///行间距,如果不赋值，则为自动计算，
CXPropSetFuncImpl(CXCollectionViewModel, CGFloat, lineSpace);
///首先间距,用于某些特殊情况，首先和header之间不需要间隔，如果不赋值，则为自动计算，,如果为横向，则此内容
CXPropSetFuncImpl(CXCollectionViewModel, CGFloat, topLineSpace);

///最后一个元素，和底部的距离
CXPropSetFuncImpl(CXCollectionViewModel, CGFloat, bottomLength);

#pragma mark ===========横向时需初始化===============

///宽高比，宽/高得到的数据,横向时，此属性必须初始化
CXPropSetFuncImpl(CXCollectionViewModel, CGFloat, ratio);
///是否平均分配到当前屏幕
CXPropSetFuncImpl(CXCollectionViewModel, BOOL, isAverage);
#pragma mark ===========纵向时需初始化===============


//是否设置sectionHeader停留,默认YES
CXPropSetFuncImpl(CXCollectionViewModel, BOOL, isStickyHeader);



#pragma mark ===========刷新相关===============

///允许刷新
CXPropSetFuncImpl(CXCollectionViewModel, BOOL, allowRefresh);
///下拉刷新
CXPropSetFuncImpl(CXCollectionViewModel, CollectionHeaderRefreshingBlock, collectionHeaderRefreshingBlock);

///上拉加载
CXPropSetFuncImpl(CXCollectionViewModel, CollectionFooterRefreshingBlock, collectionFooterRefreshingBlock);

CXCollectionViewModel *CXCollectionParam(void){
    return [CXCollectionViewModel new];
}

#pragma mark ===========空页面===============
///是否显示空页面
CXPropSetFuncImpl(CXCollectionViewModel, BOOL, showEmpty);
///空页面图片名称
CXPropSetFuncImpl(CXCollectionViewModel, NSString *, emptyImageName);
///空页面图片尺寸
CXPropSetFuncImpl(CXCollectionViewModel, CGSize, emptyImageSize);
///空页面描述
CXPropSetFuncImpl(CXCollectionViewModel, NSString *, emptyTitleName);





- (instancetype)init
{
    self = [super init];
    if (self) {
        self.ratio = 1;//宽高比默认设置为0.5
        self.interval = 15;//左右边距默认设置为15
        self.topLineSpace = 15;//顶部距离默认15
        self.lineSpace = 15;//行距默认为15
        self.num = 2;
        self.bottomLength = 0.01;
        
    }
    return self;
}







@end
