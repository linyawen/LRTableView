//
//  RetryView.h
//  LoadingRetryTableView
//
//  Created by Lin Yawen on 15/12/2.
//  Copyright (c) 2015年 ND_XM_LinYaWen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoadingRetryAble.h"

@interface RetryView : UIView<IRetryView>
@property(nonatomic,copy) void(^ onRetryBlock)(id<IRetryView> sender);

@end
