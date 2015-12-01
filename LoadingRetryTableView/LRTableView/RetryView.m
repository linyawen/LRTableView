//
//  RetryView.m
//  LoadingRetryTableView
//
//  Created by Lin Yawen on 15/12/2.
//  Copyright (c) 2015年 ND_XM_LinYaWen. All rights reserved.
//

#import "RetryView.h"

@implementation RetryView

-(IBAction)actionTap:(id)sender
{
    if (self.onRetryBlock) {
        self.onRetryBlock(self);
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
