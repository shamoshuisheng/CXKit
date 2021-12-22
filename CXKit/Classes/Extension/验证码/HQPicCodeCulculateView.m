//
//  HQPicCodeView.m
//  HQPicCodeProject
//
//  Created by 花强 on 2018/3/16.
//  Copyright © 2018年 花强. All rights reserved.
////验证码

#import "HQPicCodeCulculateView.h"

#define ARC4RAND_MAX 0x100000000

@interface HQPicCodeCulculateView()

@property (nonatomic , strong) NSString * imageCodeStr;
@property (nonatomic , strong) NSString * codeResult;

@property (nonatomic , copy) PicCodeReceive block;

@property (nonatomic , strong) NSArray * numArray;
@property (nonatomic , strong) NSArray * opArray;

@property (nonatomic , strong) UIView * bgView;
@property (nonatomic , strong) UIButton * next;

@property (nonatomic , assign) BOOL isRotation;

@end

@implementation HQPicCodeCulculateView
-(NSArray *)opArray{
    if (_opArray == nil) {
        _opArray = @[@"+",@"-",@"*"];
    }
    return _opArray;
}
-(NSArray *)numArray{
    if (_numArray == nil) {
        _numArray = @[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9"];
    }
    return _numArray;
}
-(UIButton *)next{
    if (_next == nil) {
        _next= [UIButton buttonWithType:UIButtonTypeCustom];
        [_next setFrame:self.bounds];
        [_next addTarget:self action:@selector(nextBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _next;
}

-(instancetype)initWithFrame:(CGRect)frame IsRotation:(BOOL)isRotation Block:(PicCodeReceive)block{
    if (self = [super initWithFrame:frame]) {
        self.block = block;
        self.isRotation = isRotation;//
    }
    return self;
}
-(void)nextBtnAction:(UIButton *)button{
    [self freshVerCode];
}
//刷新验证码的操作方法，这个是暴露在外面的的方法，做刷新调用
-(void)freshVerCode
{
    [self changeCodeStr];
    [self initImageCodeView];
}
- (void)changeCodeStr{

        NSInteger indexNum1 = arc4random() % ([self.numArray count] );
        NSInteger indexOp = arc4random() % ([self.opArray count] );
        NSInteger indexNum2 = arc4random() % ([self.numArray count] );

        NSString *num1 = [self.numArray objectAtIndex:indexNum1];
    NSString *op = [self.opArray objectAtIndex:indexOp];
    NSString *num2 = [self.numArray objectAtIndex:indexNum2];
    NSString *equ = @"=";

    int x = 0;
    if ([op isEqualToString:@"+"]) {
        x = [num1 intValue] + [num2 intValue];
    }else if ([op isEqualToString:@"-"]){
        x = [num1 intValue] - [num2 intValue];
    }else if ([op isEqualToString:@"*"]){
        x = [num1 intValue] * [num2 intValue];
    }
    self.imageCodeStr = [NSString stringWithFormat:@"%@%@%@%@",num1,op,num2,equ];
self.codeResult = [NSString stringWithFormat:@"%d",x];
    
    if (self.block) {
        //将验证码通过block的方式传出去
        self.block(self.codeResult);
    }
}
//随机获取背景颜色
-(UIColor *)getRandomBgColorWithAlpha:(CGFloat)alpha{
    float red = arc4random() % 100 / 100.0;
    float green = arc4random() % 100 / 100.0;
    float blue = arc4random() % 100 / 100.0;
    UIColor *color = [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
    return color;
}

-(void)initImageCodeView{
    [self.bgView removeFromSuperview];
    self.bgView = nil;
    self.bgView = [[UIView alloc] initWithFrame:self.bounds];
    [self addSubview:self.bgView];
    [self.bgView addSubview:self.next];
    
    [self.bgView setBackgroundColor:[self getRandomBgColorWithAlpha:0.5]];
    CGSize textSize = [@"W" sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20]}];
    //每个label能随机产生的位置的point.x的最大范围
    int randWidth = (self.frame.size.width)/self.imageCodeStr.length - textSize.width;
    //每个label能随机产生的位置的point.y的最大范围
    int randHeight = self.frame.size.height - textSize.height;
    
    for (int i = 0; i<self.imageCodeStr.length; i++) {
        //随机生成每个label的位置CGPoint(x,y)
        CGFloat px = arc4random()%randWidth + i*(self.frame.size.width-3)/self.imageCodeStr.length;
        CGFloat py = arc4random()%randHeight;
        UILabel * label = [[UILabel alloc] initWithFrame: CGRectMake(px+3, py, textSize.width, textSize.height)];
        label.text = [NSString stringWithFormat:@"%C",[self.imageCodeStr characterAtIndex:i]];
        label.font = [UIFont systemFontOfSize:20];
        [label setTextColor:[self getRandomBgColorWithAlpha:1]];
        //label是否是可以是斜的，isRotation这个属性暴露在外面，可进行设置
        if (self.isRotation) {
            double r = (double)arc4random() / ARC4RAND_MAX * 2 - 1.0f;//随机生成-1到1的小数
            if (r>0.3) {
                r=0.3;
            }else if(r<-0.3){
                r=-0.3;
            }
            label.transform = CGAffineTransformMakeRotation(r);
        }
        
        [self.bgView addSubview:label];
    }
    
    for (int i = 0; i<10; i++) {
        
        UIBezierPath *path = [UIBezierPath bezierPath];
        CGFloat pX = arc4random() % (int)CGRectGetWidth(self.frame);
        CGFloat pY = arc4random() % (int)CGRectGetHeight(self.frame);
        [path moveToPoint:CGPointMake(pX, pY)];
        CGFloat ptX = arc4random() % (int)CGRectGetWidth(self.frame);
        CGFloat ptY = arc4random() % (int)CGRectGetHeight(self.frame);
        [path addLineToPoint:CGPointMake(ptX, ptY)];
        
        CAShapeLayer *layer = [CAShapeLayer layer];
        layer.strokeColor = [[self getRandomBgColorWithAlpha:0.2] CGColor];//layer的边框色
        layer.lineWidth = 1.0f;
        layer.strokeEnd = 1;
        layer.fillColor = [UIColor clearColor].CGColor;
        layer.path = path.CGPath;
        [self.bgView.layer addSublayer:layer];
    }
}






/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end

