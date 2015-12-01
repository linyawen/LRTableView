//
//  LoadingRetryAble.h
//  LoadingRetryTableView
//
//  Created by Lin Yawen on 15/12/2.
//  Copyright (c) 2015年 ND_XM_LinYaWen. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ILoadingView <NSObject>
-(void)startLoading;
@end

@protocol IRetryView <NSObject>
@property(nonatomic,copy) void(^ onRetryBlock)(id<IRetryView> sender);
@end

/**
 *  某个视图 支持 加载中，空数据，网络异常重试三种状态.
 */
@protocol LoadingRetryAble <NSObject>
//加载中视图
-(UIView<ILoadingView> *)loadingView;
-(void)setLoadingView:(UIView<ILoadingView> *) loadingView;
-(UIView<IRetryView> *)retryView;
-(void)setRetryView:(UIView<IRetryView> *)retryView;
-(UIView *)emptyView;
-(void)setEmptyView:(UIView *)v;

@end
