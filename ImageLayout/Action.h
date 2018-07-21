//
//  Action.h
//  ImageLayout
//
//  Created by MuFe on 2018/6/14.
//  Copyright © 2018年 benyi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Action : NSObject
+(instancetype)leftAction:(NSString *)time folder:(NSString *)folder;
+(instancetype)rightAction:(NSString *)time folder:(NSString *)folder;
+(instancetype)topAction:(NSString *)time folder:(NSString *)folder data:(id)data;
+(instancetype)bottomAction:(NSString *)time folder:(NSString *)folder data:(id)data;
+(instancetype)selectAction:(NSString *)time folder:(NSString *)folder oldIndex:(NSInteger)oldIndex newIndex:(NSInteger)newIndex;

-(BOOL)isLeftAction;
-(BOOL)isRightAction;
-(BOOL)isTopAction;
-(BOOL)isBottomAction;
-(BOOL)isSelectAction;
-(id)getData;
-(NSInteger)getOldIndex;
@end
