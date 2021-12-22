//
//  CXPhotoPicker.m
//  BAWKWebView
//
//  Created by hntnet on 2021/12/16.
//

#import "CXPhotoPicker.h"
#import "CXPhotoPickerCell.h"
@import ZLPhotoBrowser;


@interface CXPhotoPicker()<CXCollectionViewDelegate>

@property (nonatomic ,strong) CXCollectionView *collectionView;

@property (nonatomic ,strong) CXCollectionViewModel *param;


///用来做显示时使用，如果selectedArray的数量等于最大值，则dataSource 等于selectedArray，如果不等于，则在最后加入一个用来显示图库的图片，
@property (nonatomic ,strong) NSMutableArray *dataSource;

///用来接收从相册的回调
@property (nonatomic ,strong) NSMutableArray<PHAsset *> *selectedAsset;
///用来接收从相册的回调
@property (nonatomic ,strong) NSMutableArray *selectedArray;

@end

@implementation CXPhotoPicker

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        
    }
    self.frame = frame;
    return self;
}


-(void)layoutSubviews{
    
    self.collectionView.frame = CGRectMake(0, 0, self.width, self.height);
    
}




-(void)setUI{
    CXWeakSelf(self)
    self.param=
    CXCollectionParam()
        .cellNameArraySet(@[NSStringFromClass([CXPhotoPickerCell class])])
        .collectionCellCallBlockSet(^UICollectionViewCell *(NSIndexPath * _Nonnull indexPath, UICollectionView * _Nonnull collectionView, id  _Nonnull model){
            
            CXPhotoPickerCell *cell =
            [collectionView dequeueReusableCellWithReuseIdentifier:@"CXPhotoPickerCell" forIndexPath:indexPath];
            if (cell == nil) {
                cell = [CXPhotoPickerCell getCell];
            }
            NSMutableArray *arr = self.param.dataSource[indexPath.section];
            /**
                    如果已经选择的数量没有达到最大值，则，最后一个对象显示右上角的关闭按钮
             */
            if (self.selectedArray.count != self.model.maxNum) {
                if (indexPath.row == self.dataSource.count-1) {
                    cell.deleteButton.hidden = YES;
                }else{
                    cell.deleteButton.hidden = NO;
                }
            }else{
                
                cell.deleteButton.hidden = NO;
            }
            
            cell.deleteHandle = ^{
                if (self.selectedArray.count == self.model.maxNum) {
                    /**
                     如果此时已经选择了允许选择的最大值，则，在删除后，添加一个默认图片
                     */
                    [self.dataSource removeObjectAtIndex:indexPath.row];
                    [self.selectedArray removeObjectAtIndex:indexPath.row];
                    [self.selectedAsset removeObjectAtIndex:indexPath.row];
                    
                    [self.dataSource addObject:[self defaultImage]];
                }else{
                    /**
                     如果没有选择了允许选择的最大值，则，直接删除
                     */
                    [self.dataSource removeObjectAtIndex:indexPath.row];
                    [self.selectedArray removeObjectAtIndex:indexPath.row];
                    [self.selectedAsset removeObjectAtIndex:indexPath.row];
                    
                }
                
                NSMutableArray *arr = [NSMutableArray array];
                [arr addObject:self.dataSource];
                self.param.dataSource = arr;
                self.collectionView.param = self.param;
                [self.collectionView reloadDate];
                
               
                if (self.delegate && [self.delegate respondsToSelector:@selector(pickerView:andDeleteIndex:)]) {
                    [self.delegate pickerView:self andDeleteIndex:indexPath.row];
                }
                
            };
            
            cell.smallImage = arr[indexPath.row];
            
            return cell;
        })

    .collectionViewStyleSet(CollectionViewStyleVertical)
    .numSet(self.model.columnNum)
    .ratioSet(1)
    .isAverageSet(YES)
    ;
 self.collectionView.param = self.param;
 [self addSubview:self.collectionView];
}

#pragma mark ===collection===
-(CXCollectionView *)collectionView{
    if (!_collectionView) {
        _collectionView = [[CXCollectionView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        _collectionView.delegate = self;
    }
    return _collectionView;
}

-(void)baseCollectionView:(UICollectionView *)collectionView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
    if (indexPath.row == self.dataSource.count-1) {
        ZLPhotoPreviewSheet *actionSheet = [[ZLPhotoPreviewSheet alloc] initWithSelectedAssets:self.selectedAsset];
        ZLPhotoConfiguration *config = [ZLPhotoConfiguration default];
        config.showSelectedMask = NO;
        
        config.maxSelectCount = self.model.maxNum;
        [actionSheet setSelectImageBlock:^(NSArray<UIImage *> * _Nonnull images, NSArray<PHAsset *> * _Nonnull assets, BOOL isOriginal) {
            [self.dataSource removeAllObjects];
            self.selectedAsset = assets.mutableCopy;
            self.selectedArray = images.mutableCopy;
            [self.dataSource addObjectsFromArray:self.selectedArray];
            
            if (self.selectedArray.count != self.model.maxNum) {
                [self.dataSource addObject:[self defaultImage]];
            }
            NSMutableArray *arr = [NSMutableArray array];
            [arr addObject:self.dataSource];
            self.param.dataSource = arr;
            self.collectionView.param = self.param;
            [self.collectionView reloadDate];
  
        }];

        [actionSheet showPhotoLibraryWithSender:[CXUITools getCurrentVC]];
        
    }else{
        ZLImagePreviewController *vc = [[ZLImagePreviewController alloc]initWithDatas:self.selectedArray index:indexPath.row showSelectBtn:NO showBottomView:YES urlType:nil urlImageLoader:nil];
        vc.modalPresentationStyle = UIModalPresentationFullScreen;
        [[CXUITools getCurrentVC] presentViewController:vc animated:YES completion:nil];
    }
    
    
}

-(void)baseCollectionView:(UICollectionView *)collectionView andHeight:(CGFloat)height{
    if (self.delegate && [self.delegate respondsToSelector:@selector(pickerView:andHeight:)]) {
        [self.delegate pickerView:self andHeight:height];
    }
}



#pragma mark ===========图片===============
-(void)setModel:(CXPhotoPickerModel *)model{
    _model = model;

    [self setUI];
    
    NSMutableArray *arr = [NSMutableArray array];
    [arr addObject:self.dataSource];
    self.param.num = _model.columnNum;
    self.param.dataSource =arr;
    
    
    self.collectionView.param = self.param;
    
    [self.collectionView reloadDate];
    
    
    
}



/**
 用来保存显示的图片
 */
-(NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
        [_dataSource addObject:[self defaultImage]];
    }
    return _dataSource;
}
/**
 用来保存已经选择图片
 */
-(NSMutableArray *)selectedArray{
    if (!_selectedArray) {
        _selectedArray = [NSMutableArray array];
    }
    return _selectedArray;
}
/**
 用来保存已经选择图片，此对象用来向选择器内回调使用，显示已经选择的照片
 */
-(NSMutableArray *)selectedAsset{
    if (!_selectedAsset) {
        _selectedAsset = [NSMutableArray array];
    }
    return _selectedAsset;
}



-(UIImage *)defaultImage{
    NSBundle *bundle = [NSBundle bundleForClass:self.class];
    NSString *filePath = [bundle pathForResource:@"picker_pic_upload" ofType:@"png" inDirectory:@"CXKit.bundle"];
    UIImage * image = [UIImage imageWithContentsOfFile:filePath];

    return self.model.defaultImage?:image;
    
}

@end
