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
/**
 *撤销
 */
-(void)undoAction;
/**
 *动画状态改变
 */
-(void)animationStateChange:(BOOL)isStart;
/**
 *下一个响应
 */
-(void)nextAction;
/**
 *上一个响应
 */
-(void)prevAction;
/**
 *撤销跳转图片
 */
-(void)undoSelectAction;
/**
 *上滑响应
 */
-(void)topAction;
/**
 *返回响应的相册名称
 */
-(NSString *)getBottomActionName;
/**
 *下滑响应
 */
-(void)bottomAction:(NSString *)name;
/**
 *cardView加载资源文件
 */
-(void)loadResourceToCardView:(id)data view:(UIView *)view;
/**
 *添加view到CardView
 */
-(void)addViewToCardView:(UIView *)cardView data:(id)data;
/**
 *单击
 */
-(void)sigleClick:(UIView *)cardView data:(id)data;
@end

@interface InboxActivityLayout : UIView
@property (nonatomic, weak, nullable) id <InboxActivityLayoutDataSource> dataSource;
@property (nonatomic, weak, nullable) id <InboxActivityLayoutActionDelegate> delegate;
@property (nonatomic)NSInteger orientation;
-(void)initFromPosition:(NSUInteger)position;
-(BOOL)isReady;
-(void)bottomPhotoToFloder:(NSString *)floder;
/**
 *刷新当前的View
 */
-(void)refreshShowCardView;
/**
 *撤销右划
 */
-(void)undoRight;
/**
 *撤销左划
 */
-(void)undoLeft;

/**
 *撤销下划
 */
-(void)undoBottom:(NSInteger)index;
/**
 *撤销上划
 */
-(void)undoTop:(NSInteger)index;

/**
 *撤销选择
 */
-(void)undoSelect:(NSInteger)position;
@end
