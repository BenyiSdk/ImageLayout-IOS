//
//  InboxActivityLayout.h
//  TestSlideBix
//
//  Created by MuFe on 2018/6/4.
//  Copyright © 2018年 小kk. All rights reserved.
//

#import <UIKit/UIKit.h>
#define NONE 0
#define LEFT 1
#define RIGHT 2
#define UP 3
#define DOWN 4
/**
 *数据源协议
 **/
@protocol InboxActivityLayoutDataSource <NSObject>
/**
 *获取图片数据源
 */
-(NSMutableArray *)getSource;
/**
 *获取正在展示的Index
 */
-(NSUInteger)getShowIndex;
-(CGRect)getTopHideRect;
-(CGRect)getBottomHideRect;
@end
@protocol InboxActivityLayoutActionDelegate <NSObject>
-(void)undoAction;
-(void)animationStateChange:(BOOL)isStart;
-(void)nextAction;
-(void)prevAction;
-(void)undoSelectAction;
-(void)topAction;
-(void)bottomAction;
-(void)bottomAction:(NSString *)name;
-(void)loadResourceToCardView:(id)data view:(UIView *)view;
-(void)addViewToCardView:(UIView *)cardView data:(id)data;
-(void)sigleClick:(UIView *)cardView data:(id)data;
@end

@interface InboxActivityLayout : UIView
@property (nonatomic, weak, nullable) id <InboxActivityLayoutDataSource> dataSource;
@property (nonatomic, weak, nullable) id <InboxActivityLayoutActionDelegate> delegate;
@property (nonatomic)NSInteger orientation;
-(void)initFromPosition:(NSUInteger)position;
-(BOOL)isReady;
-(void)bottomPhotoToFloder:(NSString *)floder;
-(void)refreshShowCardView;
@end
