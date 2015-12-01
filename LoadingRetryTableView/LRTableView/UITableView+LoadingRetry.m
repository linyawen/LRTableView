//
//  UITableView+LoadingRetry.m
//  LoadingRetryTableView
//
//  Created by Lin Yawen on 15/12/2.
//  Copyright (c) 2015年 ND_XM_LinYaWen. All rights reserved.
//

#import "UITableView+LoadingRetry.h"
#import <objc/runtime.h>
#import "RetryView.h"
@interface UITableView()
@property(nonatomic,assign)UITableViewCellSeparatorStyle rawSeparatorStyle;
@end

@implementation UITableView (LoadingRetry)
-(UIView *)defaultLoadingView
{
    CGRect rect = self.bounds;
    UILabel * lblLoading = [[UILabel alloc] initWithFrame:rect];
    lblLoading.textAlignment = NSTextAlignmentCenter;
    lblLoading.text = @"Try to loading...";
    return lblLoading;
}

-(UIView<IRetryView> *)defaultRetryView
{
    UINib * nib = [UINib nibWithNibName:@"RetryView" bundle:nil];
    NSArray * arrData = [nib  instantiateWithOwner:nil options:nil];
    RetryView * view = arrData[0];
    return view;
}

-(UIView *)defaultEmptyView
{
    CGRect rect = self.bounds;
    UILabel * lblEmpty = [[UILabel alloc] initWithFrame:rect];
    lblEmpty.textAlignment = NSTextAlignmentCenter;
    lblEmpty.text = @"no data ~";
    return lblEmpty;
}

-(UIView<ILoadingView> *)loadingView
{
    UIView<ILoadingView> * v = objc_getAssociatedObject(self, @selector(loadingView));
    if (nil == v) {
        v = (UIView<ILoadingView>*)[self defaultLoadingView];
        objc_setAssociatedObject(self, @selector(loadingView), v, OBJC_ASSOCIATION_RETAIN);
    };
    return v;
}

-(void)setLoadingView:(UIView<ILoadingView> *)v
{
    objc_setAssociatedObject(self, @selector(loadingView), v, OBJC_ASSOCIATION_RETAIN);
};

-(UIView<IRetryView> *)retryView
{
    UIView<IRetryView> * v = objc_getAssociatedObject(self, @selector(retryView));
    if (nil == v) {
        v = (UIView<IRetryView>*)[self defaultRetryView];
        objc_setAssociatedObject(self, @selector(retryView), v, OBJC_ASSOCIATION_RETAIN);
    };
    return v;
}

-(void)setRetryView:(UIView<IRetryView> *)v
{
    objc_setAssociatedObject(self, @selector(retryView), v, OBJC_ASSOCIATION_RETAIN);
}

-(UIView *)emptyView
{
    UIView * v = objc_getAssociatedObject(self, @selector(emptyView));
    if (nil == v) {
        v = [self defaultEmptyView];
        objc_setAssociatedObject(self, @selector(emptyView), v, OBJC_ASSOCIATION_RETAIN);
    };
    return v;
}

-(void)setEmptyView:(UIView *)v
{
    objc_setAssociatedObject(self, @selector(emptyView), v, OBJC_ASSOCIATION_RETAIN);
}

-(UITableViewCellSeparatorStyle)rawSeparatorStyle
{
    NSNumber * v = objc_getAssociatedObject(self, @selector(rawSeparatorStyle));
    return [v integerValue];
}

-(void)setRawSeparatorStyle:(UITableViewCellSeparatorStyle)separatorStyle
{
    objc_setAssociatedObject(self, @selector(rawSeparatorStyle), @(separatorStyle), OBJC_ASSOCIATION_RETAIN );
}

-(void)reload_begin
{
    [self reloadData];
    self.rawSeparatorStyle = self.separatorStyle;
    if (self.numberOfSections && [self numberOfRowsInSection:0]) {
        //there is some data,maybe cache ,do not show loading view
        self.backgroundView = nil;
        self.separatorStyle = self.rawSeparatorStyle;
    }else
    {
        UIView<ILoadingView> * v = [self loadingView];
        v.frame = self.bounds;
        self.backgroundView = v;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        if ([v respondsToSelector:@selector(startLoading)]) {
            [v startLoading];
        };
    };
}

-(void)reload_error
{
    [self reloadData];
    if (self.numberOfSections && [self numberOfRowsInSection:0]) {
        //there is some data,maybe cache ,do not show retry view
        self.backgroundView = nil;
        self.separatorStyle = self.rawSeparatorStyle;
    }else
    {
        UIView<IRetryView> * v = [self retryView];
        v.frame = self.bounds;
        self.backgroundView = v;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
    };
}

-(void)reload_end
{
    [self reloadData];
    if (self.numberOfSections && [self numberOfRowsInSection:0]) {
        //there is some data,maybe cache ,do not show retry view
        self.backgroundView = nil;
        self.separatorStyle = self.rawSeparatorStyle;
    }else
    {
        UIView* v = [self emptyView];
        v.frame = self.bounds;
        self.backgroundView = v;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
    };
}

@end
