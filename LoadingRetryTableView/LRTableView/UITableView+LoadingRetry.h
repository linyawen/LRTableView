//
//  UITableView+LoadingRetry.h
//  LoadingRetryTableView
//
//  Created by Lin Yawen on 15/12/2.
//  Copyright (c) 2015年 ND_XM_LinYaWen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoadingRetryAble.h"


@interface UITableView (LoadingRetry)<LoadingRetryAble>

#pragma mark - getter / setter
//加载中视图
-(UIView<ILoadingView> *)loadingView;
-(void)setLoadingView:(UIView<ILoadingView> *) loadingView;
-(UIView<IRetryView> *)retryView;
-(void)setRetryView:(UIView<IRetryView> *)retryView;
-(UIView *)emptyView;
-(void)setEmptyView:(UIView *)v;

//开始加载数据前调用，会显示 loading view
-(void)reload_begin;
//接口正常返回时调用，会显示 emptyView
-(void)reload_end;
//接口返回错误时调用，会显示 RetryView.
-(void)reload_error;

@end
