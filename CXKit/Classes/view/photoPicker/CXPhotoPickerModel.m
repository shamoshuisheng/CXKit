//
//  CXPhotoPickerModel.m
//  CXKit
//
//  Created by hntnet on 2021/12/16.
//

#import "CXPhotoPickerModel.h"

@implementation CXPhotoPickerModel


-(int)maxNum{
    
    if (_maxNum == 0) {
        _maxNum = 3;
    }
    return _maxNum;
}

-(int)columnNum{
    if (_columnNum == 0) {
        _columnNum = 3;
    }
    return _columnNum;
}

-(float)height{
    CGFloat hei = 0;
    
    hei = CXScreenWidth/self.columnNum;
    if (self.maxNum % self.columnNum == 0) {
        hei = hei * (self.maxNum / self.columnNum);
    }else{
        hei = hei * ((self.maxNum / self.columnNum) +1);
    }
    
    return hei;
}


@end
