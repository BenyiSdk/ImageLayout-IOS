//
//  InboxCardView.h
//  TestSlideBix
//
//  Created by MuFe on 2018/6/4.
//  Copyright © 2018年 小kk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InboxActivityLayout.h"
@interface InboxCardView : UIView
@property (nonatomic,strong) id imageModel;
@property (nonatomic, weak, nullable) id <InboxActivityLayoutActionDelegate> delegate;
-(void)loadData;
-(void)moveToLeft:(CGFloat)x proportion:(CGFloat)proportion;
-(void)moveToRight:(CGFloat)x proportion:(CGFloat)proportion;
-(void)showNext:(CGFloat)x proportion:(CGFloat)proportion;
-(void)firstPhotoMoveToRight:(CGFloat)x proportion:(CGFloat)proportion;
-(void)hideTop:(CGFloat)x proportion:(CGFloat)proportion;
-(void)moveToTop:(CGFloat)x y:(CGFloat)y proportion:(CGFloat)proportion;
-(void)moveToBottom:(CGFloat)x y:(CGFloat)y proportion:(CGFloat)proportion;
-(void)refresh;
@end
