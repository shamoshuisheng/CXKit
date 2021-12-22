//
//  CXCollectionView.m
//
//

#import "CXCollectionView.h"
#import "CXCollectionViewLayout.h"
#import "NSBundle+CXBundle.h"
#define CXWeakSelf(type)  __weak typeof(type) weak##type = type;

@interface CXCollectionView()<UICollectionViewDelegate,UICollectionViewDataSource,CXCollectionViewLayoutDelegate>
@property (nonatomic ,strong) UICollectionView *collectionView;

@property (nonatomic ,strong) UICollectionViewFlowLayout *layout;
@end
@implementation CXCollectionView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
       
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        
    }
    return self;
}


-(void)layoutSubviews{
    self.collectionView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    
    
    ///此处主要用于initWithCoder:(NSCoder *)coder此方法执行时
    if (self.param.collectionViewStyle == CollectionViewStyleHorizontal) {
        if (self.param.isAverage) {
            
            self.layout.itemSize = CGSizeMake((self.frame.size.width-(self.param.num+1)*self.param.interval)/self.param.num, self.frame.size.height-self.param.topLineSpace-self.param.lineSpace);
        }else{
         
            CGFloat width = 0;
            NSIndexPath *indexPath = [_collectionView indexPathsForVisibleItems].firstObject;
            
            if (self.param.collectionCellHeightBlock) {
                width +=  self.param.collectionCellHeightBlock(indexPath, _collectionView);
            }
            self.layout.itemSize = CGSizeMake(width, self.frame.size.height-self.param.topLineSpace-self.param.lineSpace);
        }

    }
}

-(UICollectionView *)collectionView
{
    if (_collectionView == nil)
    {
        if (self.param.collectionViewStyle == CollectionViewStyleHorizontal) {
            self.layout = [[UICollectionViewFlowLayout alloc] init];
            
            if (self.param.isAverage) {
                /**
                 如果均分当前屏幕时，执行此处，
                 */
                if (self.param.num == 0) {
                    /**
                     在均分时，如果没有设置均分数量，则均分数量为4
                     */
                    self.param.num = 4;
                }
               
                self.layout.itemSize = CGSizeMake((self.frame.size.width-(self.param.num+1)*self.param.interval)/self.param.num, self.frame.size.height-self.param.topLineSpace-self.param.lineSpace);
            }else{
             
                CGFloat width = 0;
                NSIndexPath *indexPath = [_collectionView indexPathsForVisibleItems].firstObject;
                
                if (self.param.collectionCellHeightBlock) {
                    width +=  self.param.collectionCellHeightBlock(indexPath, _collectionView);
                }else{
                    
                }
                self.layout.itemSize = CGSizeMake(width, self.frame.size.height-self.param.topLineSpace-self.param.lineSpace);
            }
            
            //设置cell间距
            self.layout.minimumLineSpacing = self.param.interval;
            
            self.layout.sectionInset = UIEdgeInsetsMake(self.param.topLineSpace, self.param.interval, self.param.lineSpace, self.param.interval);
            self.layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
            _collectionView  = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0,  self.frame.size.width, self.frame.size.height ) collectionViewLayout:self.layout];
        }else{
            CXCollectionViewLayout *layout = [[CXCollectionViewLayout alloc] init];
            layout.delegate = self;
            layout.fixTop = 0;
            layout.isStickyHeader = self.param.isStickyHeader;
            layout.isTopForHeader = YES;
            layout.lineSpace = self.param.lineSpace;
            layout.topLineSpace = self.param.topLineSpace;
            
            
            
            
            
            
            _collectionView  = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0,  self.frame.size.width, self.frame.size.height ) collectionViewLayout:layout];
        }
        _collectionView.contentInset = UIEdgeInsetsZero;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.scrollEnabled = self.param.allowScroll;
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.pagingEnabled = self.param.pagingEnabled;
        _collectionView.showsVerticalScrollIndicator = NO;
        if (self.param.cellNameArray.count == 0) {
            return nil;
        }
        
        for (int i = 0; i < self.param.cellNameArray.count; i ++) {
            if ([[NSBundle mainBundle] pathForResource:self.param.cellNameArray[i] ofType:@"bundle"]) {
                [_collectionView registerNib:[UINib nibWithNibName:self.param.cellNameArray[i] bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:self.param.cellNameArray[i]];

            }else{
                [_collectionView registerNib:[UINib nibWithNibName:self.param.cellNameArray[i] bundle:[CXFounctionTool getMainBundle]] forCellWithReuseIdentifier:self.param.cellNameArray[i]];
            }
        }
        
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"UICollectionReusableView"];
        
        if (self.param.headerNameArray.count > 0) {
            for (NSString *headerName in self.param.headerNameArray) {
                [_collectionView registerNib:[UINib nibWithNibName:headerName bundle:[NSBundle mainBundle]] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerName];
            }
        }
    }
    return _collectionView;
}


#pragma mark - UICollectionViewDelegate , UICollectionViewDataSource

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.param.dataSource.count;;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSArray *arr = self.param.dataSource[section];
    return arr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *arr = self.param.dataSource[indexPath.section];
    id model = arr[indexPath.row];
     return self.param.collectionCellCallBlock(indexPath, collectionView, model);
    
}
#pragma mark ===========header===============
#pragma mark ===headerView===

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if (self.param.collectionHeaderCallBlock) {
        return self.param.collectionHeaderCallBlock(indexPath,collectionView,kind);
    }else{
        UICollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"UICollectionReusableView" forIndexPath:indexPath];
        return header;
    }
}
#pragma mark ===header尺寸===
-(CGSize )collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (self.param.collectionViewStyle == CollectionViewStyleHorizontal) {
        return CGSizeMake(0, 0);;
    }else{
        CGFloat height = 0;
        if (self.param.collectionHeaderHeightBlock) {
         height = self.param.collectionHeaderHeightBlock(section, collectionView);
        }
        return CGSizeMake(self.frame.size.width, height);
    }
   
}

#pragma mark ===========纵向时，会执行以下代理方法===============
#pragma mark ===CXCollectionViewLayout代理方法===

#pragma mark ===item高度===
//item高度
- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(CXCollectionViewLayout *)collectionViewLayout
 heightForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height =0;
    if (self.param.collectionCellHeightBlock) {
        height += self.param.collectionCellHeightBlock(indexPath, collectionView);
    }else{
        CGFloat width = (self.frame.size.width-(self.param.num+1)*self.param.interval)/self.param.num;
        height = width *self.param.ratio;
        
    }
return height;
}


#pragma mark ===header高度===
//header高度
- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(CXCollectionViewLayout *)collectionViewLayout
heightForHeaderAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height =0;
    if (self.param.collectionHeaderHeightBlock) {
      height +=  self.param.collectionHeaderHeightBlock(indexPath.section, collectionView);
    }
    
    return height;
}
#pragma mark ===item宽度===
//item宽度
- (CGFloat)collectionView:(nonnull UICollectionView *)collectionView
                   layout:(nonnull CXCollectionViewLayout *)collectionViewLayout
    widthForItemInSection:( NSInteger )section
{
        return (self.frame.size.width- (self.param.interval) *(self.param.num +1)) /self.param.num;
}

#pragma mark ===固定位置与顶部的距离===
//固定位置与顶部的距离
- (CGFloat) collectionView:(nonnull UICollectionView *)collectionView
                    layout:(nonnull CXCollectionViewLayout *)collectionViewLayout
              topInSection:(NSInteger )section
{
        return 0;
   
}
#pragma mark ===最后一个元素，和底部的距离===
//最后一个元素，和底部的距离
- (CGFloat) collectionView:(nonnull UICollectionView *)collectionView
                    layout:(nonnull CXCollectionViewLayout *)collectionViewLayout
           bottomInSection:( NSInteger)section
{
    return self.param.bottomLength;
}

#pragma mark ===view高度===
-(void)collectionView:(UICollectionView *)collectionView andHeight:(CGFloat)height{

    if (self.delegate && [self.delegate respondsToSelector:@selector(baseCollectionView:andHeight:)]) {
        [self.delegate baseCollectionView:collectionView andHeight:height];
    }
}




#pragma mark ===========横向、纵向都会执行的方法===============

#pragma mark ===点击事件===
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(baseCollectionView:didSelectRowAtIndexPath:)]) {
        [self.delegate baseCollectionView:collectionView didSelectRowAtIndexPath:indexPath];
    }

}



-(void)reloadDate{
    [self.collectionView reloadData];

}




#pragma mark ===========传入参数处理===============
-(void)setParam:(CXCollectionViewModel *)param{
    _param = param;
    
    
    [self addSubview:self.collectionView];
    
    if (_param.allowRefresh) {
        [self addRefresh];
    }
    
 
    if (_param.showEmpty) {
        [self setUpEmptyView];
    }
    
}

#pragma mark ===EmptyView===
-(void)setUpEmptyView
{
    LYEmptyView *emptyView = [LYEmptyView emptyViewWithImageStr:self.param.emptyImageName?:@"empty_page" titleStr:nil detailStr:self.param.emptyTitleName?:@"暂无可用记录噢~"];
    emptyView.subViewMargin = 30.f;
    
    emptyView.contentViewOffset = -100;
    emptyView.imageSize = (self.param.emptyImageSize.height != 0)?self.param.emptyImageSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 100, [UIScreen mainScreen].bounds.size.width - 100);
    self.collectionView.ly_emptyView = emptyView;
}




#pragma mark ===========添加刷新控件===============
-(void)addRefresh
{
    CXWeakSelf(self);


    self.collectionView.mj_header.automaticallyChangeAlpha = YES;

    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakself.collectionView.mj_footer.hidden = YES;
        if (self.param.collectionHeaderRefreshingBlock) {
            self.param.collectionHeaderRefreshingBlock(self);
            
        }
    }];
//    [self.tableView.mj_header beginRefreshing];

    //追加尾部刷新
    self.collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
    
        if (self.param.collectionFooterRefreshingBlock) {
            self.param.collectionFooterRefreshingBlock(self);
        }
    }];
}
#pragma mark ===停止刷新===
-(void)stopRefreshing{
    [self.collectionView.mj_header endRefreshing];
    [self.collectionView.mj_footer endRefreshing];
}
#pragma mark ===开始刷新===
-(void)beginRefreshing{
    [self.collectionView.mj_header beginRefreshing];
    self.collectionView.mj_footer.hidden = YES;
    
}

#pragma mark ===显示无更多数据状态===
-(void)endRefreshingWithNoMoreData{
    [self.collectionView.mj_footer endRefreshingWithNoMoreData];
}
#pragma mark ===隐藏footer刷新===
-(void)hiddenFooterRefreshing:(BOOL)hidden{
    [self.collectionView.mj_footer setHidden:hidden];
}
#pragma mark ===隐藏header刷新===
-(void)hiddenHeaderRefreshing:(BOOL)hidden{
    [self.collectionView.mj_header setHidden:hidden];
}




@end
