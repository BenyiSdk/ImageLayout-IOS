//
//  InboxCardView.m
//  TestSlideBix
//
//  Created by MuFe on 2018/6/4.
//  Copyright © 2018年 小kk. All rights reserved.
//

#import "InboxCardView.h"

@implementation InboxCardView{
    BOOL isInitData;
    CGFloat left;
    CGFloat top;
    CGFloat width;
    CGFloat height;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    isInitData=NO;
    return self;
}

-(void)refresh{
    self->isInitData=NO;
}
-(void)loadData{
    if(self->isInitData){
        return;
    }
    self->isInitData=YES;
    [self.delegate loadResourceToCardView:_imageModel view:self];
}
- (void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    left=frame.origin.x;
    top=frame.origin.y;
    width=frame.size.width;
    height=frame.size.height;
}

-(void)moveToLeft:(CGFloat)x proportion:(CGFloat)proportion{
    CGAffineTransform translate_transform = CGAffineTransformMakeTranslation(x,0);
    self.transform = translate_transform;
    [self setAlpha:1.0];
}
-(void)firstPhotoMoveToRight:(CGFloat)x proportion:(CGFloat)proportion{
    CGAffineTransform translate_transform = CGAffineTransformMakeTranslation( 0.15f * x,0);
    self.transform = translate_transform;
    [self setAlpha:1.0];
}
-(void)moveToRight:(CGFloat)x proportion:(CGFloat)proportion{
    CGAffineTransform translate_transform = CGAffineTransformMakeTranslation(x,0);
    self.transform = translate_transform;
    [self setAlpha:1.0];
}
-(void)moveToBottom:(CGFloat)x y:(CGFloat)y proportion:(CGFloat)proportion {
    CGAffineTransform translate_transform = CGAffineTransformMakeTranslation( 0, 0.5f * y);
    self.transform = translate_transform;
}
-(void)moveToTop:(CGFloat)x y:(CGFloat)y proportion:(CGFloat)proportion{
    CGFloat temp = 0.0006f*UIScreen.mainScreen.nativeScale;
    CGFloat scale=1.0f - fabs(temp * y);
    CGAffineTransform translate_transform = CGAffineTransformMakeTranslation(x,y);
    CGAffineTransform translate_transform1=CGAffineTransformRotate(translate_transform, (-y * 12.0F / 800)*((CGFloat)M_PI) / 180.0);
    CGAffineTransform translate_transform2=CGAffineTransformScale(translate_transform1,scale , scale);
    self.transform = translate_transform2;
}

-(void)hideTop:(CGFloat)x proportion:(CGFloat)proportion{
    CGFloat f1 = 1.0F;
    CGFloat f2 = 0.0F + (f1 - proportion);
    CGFloat f3 = 0.8F + 0.2F * (f1 - proportion);
    if (f2 <= f1) {
        f1 = f2;
    }
    [self setAlpha:f1];
    self.transform = CGAffineTransformMakeScale(f3, f3);
}

-(void)showNext:(CGFloat)x proportion:(CGFloat)proportion{
    CGFloat f1 = 1.0F;
    CGFloat f2 = 0.0F + proportion;
    CGFloat f3 = 0.8F + 0.2F * proportion;
    if(f2<=f1){
        if (f2 < 0) {
            f1 = 0;
        } else {
            f1 = f2;
        }
    }
    [self setAlpha:f1];
    self.transform = CGAffineTransformScale(CGAffineTransformIdentity,f3, f3);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
