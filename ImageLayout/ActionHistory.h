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
-(void)addLeftAction:(NSString *)time;
/**
 *添加右划记录
 */
-(void)addRightAction:(NSString *)time;
/**
 *添加上划记录
 */
-(void)addTopAction:(NSString *)time data:(id)data;
/**
 *添加下划记录
 */
-(void)addBottomAction:(NSString *)time name:(NSString *)name data:(id)data;
/**
 *获取最后一次记录
 */
-(Action *)getLastAction;
@end
