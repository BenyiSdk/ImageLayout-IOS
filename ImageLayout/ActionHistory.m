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
-(void)addLeftAction:(NSString *)time name:(NSString *)name{
    Action *action=[Action leftAction:time folder:name];
    [array addObject:action];
}
-(void)addRightAction:(NSString *)time name:(NSString *)name{
    Action *action=[Action rightAction:time folder:name];
    [array addObject:action];
}

-(void)addTopAction:(NSString *)time name:(NSString *)name data:(id)data{
    Action *action=[Action topAction:time folder:name data:data];
    [array addObject:action];
}

-(void)addBottomAction:(NSString *)time name:(NSString *)name data:(id)data{
    Action *action=[Action bottomAction:time folder:name data:data];
    [array addObject:action];
}

-(Action *)pop{
    if(array.count==0){
        return nil;
    }
    Action *action=array.lastObject;
    [array removeObject:action];
    return action;
}
-(Action*)getLastAction{
    if(array.count==0){
        return nil;
    }
    Action *action=array.lastObject;
    return action;
}
-(NSMutableArray *)getActions{
    return array;
}
-(void)loadActions:(NSMutableArray *)actions{
    [array addObjectsFromArray:actions];
}
@end
