//
//  Action.h
//  ImageLayout
//
//  Created by MuFe on 2018/6/14.
//  Copyright © 2018年 benyi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Action : NSObject
+(instancetype)leftAction:(NSString *)time;
+(instancetype)rightAction:(NSString *)time;
+(instancetype)topAction:(NSString *)time data:(id)data;
+(instancetype)bottomAction:(NSString *)time floder:(NSString *)floder data:(id)data;
+(instancetype)selectAction:(NSString *)time oldIndex:(NSInteger)oldIndex newIndex:(NSInteger)newIndex;

-(BOOL)isLeftAction;
-(BOOL)isRightAction;
-(BOOL)isTopAction;
-(BOOL)isBottomAction;
-(BOOL)isSelectAction;
-(id)getData;
-(NSInteger)getOldIndex;
@end
