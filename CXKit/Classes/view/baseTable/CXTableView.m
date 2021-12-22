//
//  CXBaseTableView.m
//
//

#import "CXTableView.h"

#define CXWeakSelf(type)  __weak typeof(type) weak##type = type;

@interface CXTableView()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong) UITableView *tableView;


@end
@implementation CXTableView

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
    self.tableView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
}



#pragma mark ==========tableview==========
-(UITableView *)tableView{
    if (_tableView==nil) {
        if (self.param.cellNameArray.count == 0) {
            return nil;
        }
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 150) style:self.param.tableViewStyle];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
    
        _tableView.estimatedSectionFooterHeight = 0.0;
        _tableView.estimatedSectionHeaderHeight = 0.0;

    //        if (@available(iOS 11.0, *))
    //        {
    //            tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    //        } else {
    //            // 针对 11.0 以下的iOS系统进行处理
    //            // 不要自动调整inset
    //            UIViewController *vc = target;
    //            vc.automaticallyAdjustsScrollViewInsets = NO;
    //        }
        
        
        
        if (@available(iOS 15.0, *)) {
            _tableView.sectionHeaderTopPadding = 0;
        }
        
        
        for (int i = 0; i < self.param.cellNameArray.count; i ++ ) {
            NSString *cellName = self.param.cellNameArray[i];
            NSString *path = [[NSBundle mainBundle] pathForResource:cellName ofType:@"nib"];
            if (path != nil) {
                //没有xib文件
                [_tableView registerNib:[UINib nibWithNibName:cellName bundle:nil] forCellReuseIdentifier:cellName];
            }else{
                [_tableView registerClass:NSClassFromString(cellName) forCellReuseIdentifier:cellName];
            }
            
        }
        
        _tableView.bounces = self.param.bounces;
        _tableView.scrollEnabled = self.param.allowScroll;
    }
    return _tableView;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    id model = self.param.dataSource.firstObject;
    if ([model isKindOfClass:[NSArray class]]) {
        return self.param.dataSource.count;
    }else{
        return 1;
    }
   
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    id model = self.param.dataSource.firstObject;
    if ([model isKindOfClass:[NSArray class]]) {
        NSArray *arr = self.param.dataSource[section];
        return arr.count;
        
    }else{
        return self.param.dataSource.count;
    }
    
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
     return self.param.tableCellCallBlock(indexPath, tableView);
}


#pragma mark ----行高----
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.param.tableCellHeightBlock) {

        CGFloat height = 0;
        if (self.param.tableCellHeightBlock) {
            height = self.param.tableCellHeightBlock(indexPath, tableView);
        }

        return height;
    }else{
        return UITableViewAutomaticDimension;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}


#pragma mark ----head----

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (self.param.tableHeaderCallBlock) {
        return self.param.tableHeaderCallBlock(section, tableView);
    }else{
        return nil;
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    CGFloat height = 0.01;
    if (self.param.tableHeaderHeightBlock) {
        
     height = self.param.tableHeaderHeightBlock(section, tableView);
    }

    
    return height;
}


#pragma mark ----footer----
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{

    if (self.param.tableFooterCallBlock) {
        return self.param.tableFooterCallBlock(section, tableView);
    }else{
        return nil;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    CGFloat height = 0.01;
    if (self.param.tableFooterHeightBlock) {
        height =  self.param.tableFooterHeightBlock(section, tableView);
    }
    
    return height;
}

#pragma mark ===========点击事件===============
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.delegate && [self.delegate respondsToSelector:@selector(cxTableView:didSelectRowAtIndexPath:)]) {
        [self.delegate cxTableView:tableView didSelectRowAtIndexPath:indexPath];
    }
}

-(void)reloadDate{
    [self.tableView reloadData];
}




#pragma mark ===========数据加载===============
-(void)setParam:(CXTableViewModel *)param{
    _param = param;
    
    [self addSubview:self.tableView];
    
//    self.tableView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
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
    self.tableView.ly_emptyView = emptyView;
}




#pragma mark ===========添加刷新控件===============
-(void)addRefresh
{
    CXWeakSelf(self);


    self.tableView.mj_header.automaticallyChangeAlpha = YES;

    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakself.tableView.mj_footer.hidden = YES;
        if (self.param.tableHeaderRefreshingBlock) {
            self.param.tableHeaderRefreshingBlock(self);
            
        }
    }];
//    [self.tableView.mj_header beginRefreshing];

    //追加尾部刷新
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
    
        if (self.param.tableFooterRefreshingBlock) {
            self.param.tableFooterRefreshingBlock(self);
        }

    }];
    self.tableView.mj_footer.hidden = YES;
    
}
#pragma mark ===停止刷新===
-(void)stopRefreshing{
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}
#pragma mark ===开始刷新===
-(void)beginRefreshing{
    [self.tableView.mj_header beginRefreshing];
    self.tableView.mj_footer.hidden = YES;
    
}
#pragma mark ===显示无更多数据状态===
-(void)endRefreshingWithNoMoreData{
    [self.tableView.mj_footer endRefreshingWithNoMoreData];
}
#pragma mark ===隐藏footer刷新===
-(void)hiddenFooterRefreshing:(BOOL)hidden{
    [self.tableView.mj_footer setHidden:hidden];
}
#pragma mark ===隐藏header刷新===
-(void)hiddenHeaderRefreshing:(BOOL)hidden{
    [self.tableView.mj_header setHidden:hidden];
}





#pragma mark ===========创建tableView===============
-(UITableView *)creatTableView:(CGRect)rect andTableViewStyle:(UITableViewStyle)tableStyle andTarget:(id)target andSeparatorStyle:(UITableViewCellSeparatorStyle)separatorMode andCellReuseId:(NSString *)cellID andUseCellNib:(BOOL)useNib  andCellName:(NSString *)cellNmae andBackGroundColor:(UIColor *)color
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

@end
