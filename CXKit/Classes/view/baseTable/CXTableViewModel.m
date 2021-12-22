//
//  CXTableViewModel.m

//
//

#import "CXTableViewModel.h"

@implementation CXTableViewModel

-(CGFloat)tableHeight{
    CGFloat height = 0;

    CGFloat headerHeight = 0;
    CGFloat footerHeight = 0;
    CGFloat cellHeight = 0;
    
   
    for (int i = 0; i < self.dataSource.count; i ++) {
        id model = self.dataSource[i];
        if ([model isKindOfClass:[NSArray class]]) {
//            如果数据源对象为数组
            if (self.tableHeaderHeightBlock) {
                headerHeight +=  self.tableHeaderHeightBlock(i,nil);
            }
            if (self.tableFooterHeightBlock) {
                footerHeight += self.tableFooterHeightBlock(i,nil);
            }
           
            NSArray *arr = self.dataSource[i];
            for (int j = 0; j < arr.count; j ++) {
                NSIndexPath *indexPath  = [[NSIndexPath alloc]initWithIndex:j];
               
                cellHeight += self.tableCellHeightBlock(indexPath,nil);
            }
        }else{
//            如果数据源对象为model数据
            if (self.tableHeaderHeightBlock) {
                headerHeight =  self.tableHeaderHeightBlock(i,nil);
            }
            if (self.tableFooterHeightBlock) {
                footerHeight = self.tableFooterHeightBlock(i,nil);
            }
           
                NSIndexPath *indexPath  = [[NSIndexPath alloc]initWithIndex:i];
               
                cellHeight += self.tableCellHeightBlock(indexPath,nil);
            
        }
        
    }
    height = headerHeight + footerHeight + cellHeight;
    return height;
}


//table设置
///table样式
CXPropSetFuncImpl(CXTableViewModel, UITableViewStyle, tableViewStyle);

///用于设置cell
CXPropSetFuncImpl(CXTableViewModel, TableCellCallBlock, tableCellCallBlock);

CXPropSetFuncImpl(CXTableViewModel, TableCellHeightBlock, tableCellHeightBlock);

///header
CXPropSetFuncImpl(CXTableViewModel, TableHeaderCallBlock, tableHeaderCallBlock);

///header高度
CXPropSetFuncImpl(CXTableViewModel, TableHeaderHeightBlock, tableHeaderHeightBlock);
///footer
CXPropSetFuncImpl(CXTableViewModel, TableFooterCallBlock, tableFooterCallBlock);
///footer高度
CXPropSetFuncImpl(CXTableViewModel, TableFooterHeightBlock, tableFooterHeightBlock);
///cell名字
CXPropSetFuncImpl(CXTableViewModel, NSArray *, cellNameArray);
///数据源
CXPropSetFuncImpl(CXTableViewModel, NSMutableArray *, dataSource);





///是否允许滚动
CXPropSetFuncImpl(CXTableViewModel, BOOL, allowScroll);
///是否允许回弹
CXPropSetFuncImpl(CXTableViewModel, BOOL, bounces);

///是否显示空页面
CXPropSetFuncImpl(CXTableViewModel, BOOL, showEmpty);
///空页面图片名称
CXPropSetFuncImpl(CXTableViewModel, NSString *, emptyImageName);
///空页面图片尺寸
CXPropSetFuncImpl(CXTableViewModel, CGSize, emptyImageSize);
///空页面描述
CXPropSetFuncImpl(CXTableViewModel, NSString *, emptyTitleName);






#pragma mark ===刷新相关===
///允许刷新
CXPropSetFuncImpl(CXTableViewModel, BOOL, allowRefresh);
///下拉刷新
CXPropSetFuncImpl(CXTableViewModel, TableHeaderRefreshingBlock, tableHeaderRefreshingBlock);

///上拉加载
CXPropSetFuncImpl(CXTableViewModel, TableFooterRefreshingBlock, tableFooterRefreshingBlock);




CXTableViewModel *CXTableParam(void){
    return [CXTableViewModel new];
 
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.tableViewStyle = UITableViewStyleGrouped;
//        self.dataSource = @[@[@{@"name":@"1"},@{@"name":@"1"},@{@"name":@"1"},@{@"name":@"1"}]].mutableCopy;
        self.allowScroll = YES;
        self.allowRefresh = NO;
        
        
        
    }
    return self;
}


@end
