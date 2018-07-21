//
//  Action.m
//  ImageLayout
//
//  Created by MuFe on 2018/6/14.
//  Copyright © 2018年 benyi. All rights reserved.
//

#import "Action.h"
#define LEFT_ACITON @"LEFT"
#define SELECT_ACITON @"SELECT"
#define TOP_ACITON @"TOP"
#define RIGHT_ACITON @"RIGHT"
#define BOTTOM_ACITON @"BOTTOM"
@interface Action ()
@property (nonatomic,strong)  NSString *action;
@property (nonatomic,strong)  NSString *time;
@property (nonatomic,strong) id data;
@property (nonatomic,strong) NSString *name;
@property (nonatomic) NSInteger oldIndex;
@property (nonatomic) NSInteger newIndex;
@end
@implementation Action
+(instancetype)leftAction:(NSString *)time folder:(NSString *)folder{
    Action *action=[[Action alloc] init];
    action.action=LEFT_ACITON;
    action.name=folder;
    action.time=time;
    return action;
}
+(instancetype)rightAction:(NSString *)time folder:(NSString *)folder{
    Action *action=[[Action alloc] init];
    action.action=RIGHT_ACITON;
    action.time=time;
    return action;
}
+(instancetype)topAction:(NSString *)time folder:(NSString *)folder data:(id)data{
    Action *action=[[Action alloc] init];
    action.action=TOP_ACITON;
    action.time=time;
    action.data=data;
    action.name=folder;
    return action;
}
+(instancetype)bottomAction:(NSString *)time folder:(NSString *)folder data:(id)data{
    Action *action=[[Action alloc] init];
    action.action=BOTTOM_ACITON;
    action.time=time;
    action.name=folder;
    action.data=data;
    return action;
}
+(instancetype)selectAction:(NSString *)time folder:(NSString *)folder oldIndex:(NSInteger)oldIndex newIndex:(NSInteger)newIndex{
    Action *action=[[Action alloc] init];
    action.action=SELECT_ACITON;
    action.time=time;
    action.name=folder;
    action.oldIndex=oldIndex;
    action.newIndex=newIndex;
    return action;
}
- (id)getData{
    return _data;
}
- (NSInteger)getOldIndex{
    return _oldIndex;
}
-(BOOL)isLeftAction{
    return [self.action isEqualToString:LEFT_ACITON];
}
-(BOOL)isRightAction{
    return [self.action isEqualToString:RIGHT_ACITON];
}
-(BOOL)isTopAction{
    return [self.action isEqualToString:TOP_ACITON];
}
-(BOOL)isBottomAction{
    return [self.action isEqualToString:BOTTOM_ACITON];
}
-(BOOL)isSelectAction{
    return [self.action isEqualToString:SELECT_ACITON];
}

@end
