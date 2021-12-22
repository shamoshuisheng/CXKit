//
//  CXTableView.h
//
//

#import <UIKit/UIKit.h>
#import "CXTableViewModel.h"
#import "MJRefresh.h"
#import <LYEmptyView/LYEmptyViewHeader.h>

typedef enum : NSUInteger {
    ///tableViewHeader
    CXTableHeaderTypeHeader,
    ///tableViewFooter
    CXTableHeaderTypeFooter,
} CXTableHeaderType;

NS_ASSUME_NONNULL_BEGIN
@class CXTableView;
@protocol CXTableViewDelegate <NSObject>

@optional
- (void)cxTableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface CXTableView : UIView


@property (nonatomic ,weak) id<CXTableViewDelegate> delegate;



-(void)reloadDate;



@property (nonatomic ,strong) CXTableViewModel *param;



#pragma mark ===========刷新相关===============
#pragma mark ===停止刷新===
-(void)stopRefreshing;
#pragma mark ===开始刷新===
-(void)beginRefreshing;
#pragma mark ===隐藏footer刷新===
-(void)hiddenFooterRefreshing:(BOOL)hidden;
#pragma mark ===隐藏header刷新===
-(void)hiddenHeaderRefreshing:(BOOL)hidden;
#pragma mark ===显示无更多数据状态===
-(void)endRefreshingWithNoMoreData;


@end

NS_ASSUME_NONNULL_END
