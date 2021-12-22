//
//  CXPhotoPickerCell.h
//
//

#import <UIKit/UIKit.h>
#import "CXDefineHeader.h"
#import "CXTools.h"
NS_ASSUME_NONNULL_BEGIN
typedef void(^deleteSeletePic)(void);
@interface CXPhotoPickerCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *selectImageView;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;


@property (nonatomic ,copy) deleteSeletePic deleteHandle;

/* <#description#> */
@property (nonatomic ,strong) UIImage *smallImage;
/* <#description#> */
@property (nonatomic ,assign) BOOL hiddenDeleteButton;


+(instancetype)getCell;
@end

NS_ASSUME_NONNULL_END
