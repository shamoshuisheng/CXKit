#  <#Title#>

    HQPicCodeCulculateView * viewCul = [[HQPicCodeCulculateView alloc] initWithFrame:CGRectMake(0, 0, 80, 30) IsRotation:YES    Block:^(NSString *code) {
//        NSLog(@"code----%@",code);
        self.checkNum = code;
        
        
    }];
    [viewCul freshVerCode];
