//
//  ActionHistory.m
//  ImageLayout
//
//  Created by MuFe on 2018/6/14.
//  Copyright © 2018年 benyi. All rights reserved.
//

#import "ActionHistory.h"

@implementation ActionHistory{
    NSMutableArray *array;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        array=[[NSMutableArray alloc] init];
    }
    return self;
}
-(void)addLeftAction:(NSString *)time{
    Action *action=[Action leftAction:time];
    [array addObject:action];
}
-(void)addRightAction:(NSString *)time{
    Action *action=[Action rightAction:time];
    [array addObject:action];
}

-(void)addTopAction:(NSString *)time data:(id)data{
    Action *action=[Action topAction:time data:data];
    [array addObject:action];
}

-(void)addBottomAction:(NSString *)time name:(NSString *)name data:(id)data{
    Action *action=[Action bottomAction:time floder:name data:data];
    [array addObject:action];
}

-(Action *)getLastAction{
    if(array.count==0){
        return nil;
    }
    Action *action=array.lastObject;
    [array removeObject:action];
    return action;
}

@end
