//
//  CXPhotoPickerCell.m
//

//

#import "CXPhotoPickerCell.h"

@implementation CXPhotoPickerCell

- (void)awakeFromNib {
    [super awakeFromNib];
    CXViewRadius(_selectImageView, 10);
    
    
}
-(void)setSmallImage:(UIImage *)smallImage
{
    _smallImage = smallImage;
    _selectImageView.image = _smallImage;
}

-(void)setHiddenDeleteButton:(BOOL)hiddenDeleteButton
{
    _hiddenDeleteButton = hiddenDeleteButton;
    _deleteButton.hidden = (_hiddenDeleteButton ? YES :NO);
}


- (IBAction)buttonClick:(UIButton *)sender {
    
    if (self.deleteHandle) {
           self.deleteHandle();
       }
}


+(instancetype)getCell{
    return (CXPhotoPickerCell *)[[[CXFounctionTool getMainBundle] loadNibNamed:@"CXPhotoPickerCell" owner:nil options:nil] lastObject];
}



@end
