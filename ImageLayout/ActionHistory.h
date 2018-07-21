//
//  ActionHistory.h
//  ImageLayout
//
//  Created by MuFe on 2018/6/14.
//  Copyright © 2018年 benyi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Action.h"
@interface ActionHistory : NSObject
/**
 *添加左划记录
 */
-(void)addLeftAction:(NSString *)time name:(NSString *)name;
/**
 *添加右划记录
 */
-(void)addRightAction:(NSString *)time name:(NSString *)name;
/**
 *添加上划记录
 */
-(void)addTopAction:(NSString *)time name:(NSString *)name data:(id)data;
/**
 *添加下划记录
 */
-(void)addBottomAction:(NSString *)time name:(NSString *)name data:(id)data;
/**
 *获取最后一次记录
 */
-(Action *)getLastAction;

/**
 *获取并且移除最后一次记录
 */
-(Action *)pop;

/**
 *获取所有记录
 */
-(NSMutableArray *)getActions;

/**
 *加载记录
 */
-(void)loadActions:(NSMutableArray *)actions;
@end
