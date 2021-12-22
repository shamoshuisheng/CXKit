//
//  CXCollectionView.h
//
//

#import <UIKit/UIKit.h>
#import "CXCollectionViewModel.h"
#import "MJRefresh.h"
#import <LYEmptyView/LYEmptyViewHeader.h>
#import "CXTools.h"


NS_ASSUME_NONNULL_BEGIN
@class CXCollectionView;
@protocol CXCollectionViewDelegate <NSObject>

@optional
- (void)baseCollectionView:(UICollectionView *)collectionView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

-(void)baseCollectionView:(UICollectionView *)collectionView andHeight:(CGFloat)height;

@end

@interface CXCollectionView : UIView


@property (nonatomic ,weak) id<CXCollectionViewDelegate> delegate;



-(void)reloadDate;

@property (nonatomic ,strong) CXCollectionViewModel *param;



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
