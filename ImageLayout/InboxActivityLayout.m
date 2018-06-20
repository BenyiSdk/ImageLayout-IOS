//
//  InboxActivityLayout.m
//  TestSlideBix
//
//  Created by MuFe on 2018/6/4.
//  Copyright © 2018年 小kk. All rights reserved.
//

#import "InboxActivityLayout.h"
#import "InboxCardView.h"
@interface InboxActivityLayout ()<UIGestureRecognizerDelegate>
@property (nonatomic,strong) InboxCardView *leftInboxCardView;
@property (nonatomic,strong) InboxCardView *showInboxCardView;
@property (nonatomic,strong) InboxCardView *bottomInboxCardView;
@property (nonatomic,strong) InboxCardView *inboxCardView3;
@end

@implementation InboxActivityLayout{
    CGFloat cardWidth;
    CGFloat cardHeight;
    NSInteger firstViewLeft;
    NSInteger firstViewTop;
    NSInteger gestureViewLeft;
    NSInteger gestureViewTop;
    NSInteger bottomViewLeft;
    NSInteger bottomViewTop;
    BOOL initLayout;
    BOOL isMoveIng;
    NSMutableArray *animateArray;
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        [self setupView];
    }
    return self;
}

-(void)setupView{
    cardWidth =self.frame.size.width ;
    cardHeight =self.frame.size.height ;
    gestureViewLeft = self.frame.origin.x;
    gestureViewTop =0;
    firstViewLeft = (gestureViewLeft - cardWidth);
    firstViewTop = gestureViewTop;
    bottomViewLeft = gestureViewLeft;
    bottomViewTop = gestureViewTop;
    self.userInteractionEnabled=YES;
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(onPanGesture:)];
    panGesture.delegate = self;
    [self addGestureRecognizer:panGesture];
    UITapGestureRecognizer *tapGesturRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    
    [self addGestureRecognizer:tapGesturRecognizer];
    initLayout=NO;
    isMoveIng=NO;
}
-(void)tapAction:(id)tap{
    [self restore];
    if(self.showInboxCardView==nil||self.showInboxCardView.imageModel==nil){
        return;
    }
    [self.delegate sigleClick:self.showInboxCardView data:self.showInboxCardView.imageModel];
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    if ([self isAnimateInit]) {
        return NO;
    }
    return YES;
}
- (void)onPanGesture:(UIPanGestureRecognizer *)gesture{
    //开始滑动
    if (gesture.state == UIGestureRecognizerStateBegan) {
    }
    //结束拖动
    else if (gesture.state == UIGestureRecognizerStateEnded || gesture.state == UIGestureRecognizerStateCancelled) {
       CGPoint translate = [gesture translationInView:self];
       [self endMove:self.orientation translatX:translate.x translateY:translate.y];
       self.orientation=NONE;
    }
    //拖拽过程中
    else if (gesture.state == UIGestureRecognizerStateChanged){
        CGPoint translate = [gesture translationInView:self];
        if(self.orientation==NONE){
            if (translate.x == 0) {
                if (translate.y == 0) {
                    return;
                }
            }
            BOOL isSu = (double) (translate.x * translate.x) < ((double) (translate.y * translate.y)) / 1.5;
            if (isSu) {
                if (translate.y > 0) {
                    self.orientation = DOWN;
                } else {
                    self.orientation = UP;
                }
            } else {
                if (translate.x > 0) {
                    self.orientation = RIGHT;
                } else {
                    self.orientation = LEFT;
                }
            }
            isMoveIng=YES;
        }
        [self move:self.orientation translatX:translate.x translateY:translate.y];
    }
}
- (void)layoutSubviews{
    if (!isMoveIng && ![self isAnimateInit] && !initLayout) {
        initLayout=YES;
        if (self.bottomInboxCardView != nil) {
            [self.bottomInboxCardView removeFromSuperview];
            [self addCardViewToLayout:self.bottomInboxCardView];
            [self initBottomCardView:self.bottomInboxCardView];
        }
        if (self.showInboxCardView != nil) {
            [self.showInboxCardView removeFromSuperview];
            [self addCardViewToLayout:self.showInboxCardView];
            [self initShowCardView:self.showInboxCardView];
        }
        if (self.leftInboxCardView != nil) {
            [self.leftInboxCardView removeFromSuperview];
            [self addCardViewToLayout:self.leftInboxCardView];
            [self initLeftCardView:self.leftInboxCardView];
        }
        if (self.inboxCardView3 != nil) {
            [self.inboxCardView3 removeFromSuperview];
            [self initBottomCardView:self.inboxCardView3];
        }
        initLayout=NO;
    }
}
-(void)move:(NSUInteger)orientation translatX:(CGFloat)x translateY:(CGFloat)y{
    CGFloat proportion=x/cardWidth;
    CGFloat proportion1=y/cardHeight;
    if(orientation==LEFT){
        [self moveToLeft:x proportion:-proportion];
    }else if(orientation==RIGHT){
         [self moveToRight:x proportion:proportion];
    }else if(orientation==UP){
        [self moveToUp:x y:y proportion:-proportion1];
    }else if(orientation==DOWN){
        [self moveToBottom:x y:y proportion:proportion1];
    }
}
-(void)moveToLeft:(CGFloat)x proportion:(CGFloat)proportion{
    if(self.showInboxCardView){
        [self.showInboxCardView moveToLeft:x proportion:proportion];
    }
    if (self.bottomInboxCardView) {
        [self.bottomInboxCardView showNext:x proportion:proportion];
    }
}

-(void)moveToRight:(CGFloat)x proportion:(CGFloat)proportion{
    if(!self.leftInboxCardView){
        if(self.showInboxCardView){
            [self.showInboxCardView firstPhotoMoveToRight:x proportion:proportion];
        }
    }else{
        [self.leftInboxCardView moveToRight:x proportion:proportion];
        if(self.showInboxCardView){
            [self.showInboxCardView hideTop:x proportion:proportion];
        }
    }
}
-(void)moveToUp:(CGFloat)x y:(CGFloat)y proportion:(CGFloat)proportion{
    if(self.showInboxCardView){
        [self.showInboxCardView moveToTop:x y:y proportion:proportion];
    }
    if (self.bottomInboxCardView) {
        [self.bottomInboxCardView showNext:x proportion:proportion];
    }
}
-(void)moveToBottom:(CGFloat)x y:(CGFloat)y proportion:(CGFloat)proportion{
    if(self.showInboxCardView){
        [self.showInboxCardView moveToBottom:x y:y proportion:proportion];
    }
    if (self.bottomInboxCardView) {
        [self.bottomInboxCardView showNext:x proportion:proportion];
    }
}
-(void)endMove:(NSUInteger)orientation translatX:(CGFloat)x translateY:(CGFloat)y{
    isMoveIng=NO;
    float temp1 = 160.0F;
    float temp2 = 120.0F;
    if(orientation==LEFT){
        [self leftEnd:-x>temp2];
    }else if(orientation==RIGHT){
        [self rightEnd:x>temp2];
    }else if(orientation==UP){
        [self topEnd:-y>temp1];
    }else if(orientation==DOWN){
        [self downEnd:y>temp1];
    }
}

/**
 * 还原移动
 */
-(void)restore{
    [self initAnimate];
    [self addAnimator:@"createLeftHideAnimator:" view:self.leftInboxCardView];
    [self addAnimator:@"createLeftShowAnimator:" view:self.showInboxCardView];
    [self addAnimator:@"createBackwardHideAnimator:" view:self.bottomInboxCardView];
    [self startAnimate:^(BOOL finished) {
        [self layoutSubviews];
    }];
}

-(void)leftEnd:(BOOL)change{
    if(!change){
         [self restore];
        return;
    }
    if(!self.showInboxCardView){
         [self restore];
        return;
    }
    [self leftAction];
}
-(void)leftAction{
    InboxCardView *cardView1=self.bottomInboxCardView;
    InboxCardView *cardView2=self.showInboxCardView;
    self.inboxCardView3=self.leftInboxCardView;
    self.leftInboxCardView=cardView2;
    self.showInboxCardView=cardView1;
    self.bottomInboxCardView=nil;
    [self initAnimate];
    [self addAnimator:@"createLeftShowAnimator:" view:cardView1];
    [self addAnimator:@"createLeftHideAnimator:" view:cardView2];
    [self startAnimate:^(BOOL finished) {
        self.bottomInboxCardView=[self createCardView:[self.dataSource getShowIndex]+2];
        [self layoutSubviews];
        [self.delegate nextAction];
    }];
}

-(void)rightEnd:(BOOL)change{
    if(!change){
        [self restore];
        return;
    }
    if(!self.leftInboxCardView){
         [self restore];
        return;
    }
    [self rightAction];
}
-(void)rightAction{
    InboxCardView *cardView1=self.leftInboxCardView;
    InboxCardView *cardView2=self.showInboxCardView;
    self.inboxCardView3=self.bottomInboxCardView;
    self.showInboxCardView=cardView1;
    self.bottomInboxCardView=cardView2;
    [self initAnimate];
    [self addAnimator:@"createBackwardHideAnimator:" view:cardView2];
    [self addAnimator:@"createLeftShowAnimator:" view:cardView1];
    [self startAnimate:^(BOOL finished) {
        self.leftInboxCardView=nil;
        self.leftInboxCardView=[self createCardView:[self.dataSource getShowIndex]-2];
        [self layoutSubviews];
        [self.delegate prevAction];
    }];
}
-(void)topEnd:(BOOL)change{
    if(!self.showInboxCardView){
        return;
    }
    if(!change){
        [self restore];
        return;
    }
    [self topAction];
}
/**
 * 向上滑动
 */
-(void)topAction{
    __weak InboxCardView *cardView1=self.showInboxCardView;
    __weak InboxCardView *cardView2=self.bottomInboxCardView;
    self.bottomInboxCardView=nil;
    self.inboxCardView3=cardView1;
    [self initAnimate];
    [UIView animateWithDuration:0.15 animations:^{
        [self createTopHideAnimator:cardView1 frame:[self.dataSource getTopHideRect]];
    } completion:^(BOOL finished) {
        self->animateArray=nil;
        self.showInboxCardView=cardView2;
        self.bottomInboxCardView=[self createCardView:[self.dataSource getShowIndex]+2];
        [self layoutSubviews];
        [self.delegate topAction];
    }];
    [self addAnimator:@"createLeftShowAnimator:" view:cardView2];
    [self startAnimate:nil];
}

-(void)downEnd:(BOOL)change{
    if(!self.showInboxCardView){
        return;
    }
    NSString *name=[self.delegate getBottomActionName];
    if(name==nil){
        [self bottomAction];
    }else{
        [self bottomPhotoToFloder:name];
    }
}
-(void)bottomAction{
    [self initAnimate];
    [self addAnimator:@"createLeftHideAnimator:" view:self.leftInboxCardView];
    [self addAnimator:@"createLeftShowAnimator:" view:self.showInboxCardView];
    [self addAnimator:@"createBackwardHideAnimator:" view:self.showInboxCardView];
    [self startAnimate:^(BOOL finished) {
        [self layoutSubviews];
        [self.delegate bottomAction:nil];
    }];
}
-(BOOL)isReady{
    if(isMoveIng){
        return YES;
    }else{
        if([self isAnimateInit]){
            return YES;
        }
    }
    return NO;
}
-(void)bottomPhotoToFloder:(NSString *)floder{
    self.inboxCardView3=self.showInboxCardView;
    [self initAnimate];
    [UIView animateWithDuration:0.2 animations:^{
        [self createTopHideAnimator:self.showInboxCardView frame:[self.dataSource getBottomHideRect]];
    } completion:^(BOOL finished) {
        self->animateArray=nil;
        self.showInboxCardView=self.bottomInboxCardView;
        self.bottomInboxCardView=[self createCardView:[self.dataSource getShowIndex]+1];
        [self layoutSubviews];
        [self.delegate bottomAction:floder];
    }];
    [self addAnimator:@"createLeftShowAnimator:" view:self.bottomInboxCardView];
    [self startAnimate:nil];
}

/**
 * 撤销右划
 */
-(void)undoRight{
    InboxCardView *cardView1 = self.bottomInboxCardView;
    InboxCardView *cardView2 = self.showInboxCardView;
    self.inboxCardView3 = self.leftInboxCardView;
    self.leftInboxCardView = cardView2;
    self.showInboxCardView = cardView1;
    self.bottomInboxCardView = nil;
    [self initAnimate];
    [self addAnimator:@"createLeftHideAnimator:" view:cardView2];
    [self addAnimator:@"createLeftShowAnimator:" view:cardView1];
    [self startAnimate:^(BOOL finished) {
        self.bottomInboxCardView=[self createCardView:[self.dataSource getShowIndex]+1];
        [self layoutSubviews];
        [self.delegate undoAction];
    }];
}

/**
 * 撤销左划
 */
-(void)undoLeft{
    InboxCardView *cardView1 = self.leftInboxCardView;
    InboxCardView *cardView2 = self.showInboxCardView;
    self.inboxCardView3 = self.bottomInboxCardView;
    self.bottomInboxCardView = cardView2;
    self.showInboxCardView = cardView1;
    [self initAnimate];
    [self addAnimator:@"createBackwardHideAnimator:" view:cardView2];
    [self addAnimator:@"createLeftShowAnimator:" view:cardView1];
    [self startAnimate:^(BOOL finished) {
        self.leftInboxCardView=[self createCardView:[self.dataSource getShowIndex]-1];
        [self layoutSubviews];
        [self.delegate undoAction];
    }];
}

/**
 * 恢复向下滑动
 *
 * @param index       资源文件index
 */
-(void)undoBottom:(NSInteger)index{
    InboxCardView *tempCard=[self createCardView:index];
    __weak InboxCardView *inboxCardView =tempCard;
    if (self.showInboxCardView != nil) {
        [self addCardViewAfterToLayout:inboxCardView cardView:self.showInboxCardView];
    } else if (self.leftInboxCardView != nil) {
        [self addCardViewToLayout:inboxCardView cardView:self.leftInboxCardView];
    } else {
        [self addCardViewToLayout:inboxCardView];
    }
    [self initBottomShowCardView:inboxCardView rect:[self.dataSource getBottomHideRect]];
    [self.bottomInboxCardView removeFromSuperview];
    self.bottomInboxCardView = nil;
    [self initAnimate];
    [self addAnimator:@"createBackwardHideAnimator:" view:self.showInboxCardView];
    [self addAnimator:@"createLeftShowAnimator:" view:inboxCardView];
    [self startAnimate:^(BOOL finished) {
        self.bottomInboxCardView=self.showInboxCardView;
        self.showInboxCardView=inboxCardView;
        [self layoutSubviews];
        [self.delegate undoAction];
    }];
}


/**
 * 恢复向上滑动
 *
 * @param index 资源文件Index
 */
-(void)undoTop:(NSInteger)index{
    self.inboxCardView3 = self.bottomInboxCardView;
    self.bottomInboxCardView = nil;
    [self initAnimate];
    InboxCardView *tempCard=[self createCardView:index];
    __weak InboxCardView *cardView =tempCard;
    if (self.showInboxCardView != nil) {
        [self addCardViewAfterToLayout:cardView cardView:self.showInboxCardView];
    } else if (self.leftInboxCardView != nil) {
        [self addCardViewToLayout:cardView cardView:self.leftInboxCardView];
    } else {
        [self addCardViewToLayout:cardView];
    }
    [self initTopShowCardView:cardView rect:[self.dataSource getTopHideRect]];
    [self addAnimator:@"createBackwardHideAnimator:" view:self.showInboxCardView];
    [UIView animateWithDuration:0.2f animations:^{
        [self createTopShowAnimator:cardView];
    } completion:^(BOOL finished) {
        self->animateArray=nil;
        self.bottomInboxCardView=self.showInboxCardView;
        self.showInboxCardView=cardView;
        [self layoutSubviews];
        [self.delegate undoAction];
    }];
    [self startAnimate:nil];
}

/**
 * 恢复跳转position
 *
 * @param position position
 */
-(void)undoSelect:(NSInteger)position{
    [self initCardViews:position];
    [self.delegate undoSelectAction];
}

/**
 * 初始化动画数组
 */
-(void)initAnimate{
    animateArray=[[NSMutableArray alloc] init];
}
/**
 * 判断动画数组是否被初始化
 *
 * @return 状态
 */
-(BOOL)isAnimateInit{
    return animateArray!= nil;
}

/**
 * 添加动画
 *
 */
-(void)addAnimator:(NSString *)selName view:(InboxCardView *)cardView {
    if (animateArray != nil) {
        NSDictionary *dic=[NSDictionary dictionaryWithObjectsAndKeys:selName,@"sel",cardView,@"view", nil];
        [animateArray addObject:dic];
    }
}
/**
 * 开始动画
 */
-(void)startAnimate:(void (^ __nullable)(BOOL finished))isFinish{
    [UIView animateWithDuration:0.1 animations:^{
        for(int i=0;i<self->animateArray.count;i++){
            NSDictionary *dic=self->animateArray[i];
            NSString *selName=[dic objectForKey:@"sel"];
            SEL selector = NSSelectorFromString(selName);
            IMP imp = [self methodForSelector:selector];
            void(*func)(id, SEL, UIView *) = (void *)imp;
            func(self, selector, [dic objectForKey:@"view"]) ;
        }
    } completion:^(BOOL finished) {
        if(isFinish!=nil){
            self->animateArray=nil;
            isFinish(finished);
        }
      
    }];
}
/**
 * 创建从左边消失的动画
 *
 * @param cardView 动画执行的View
 */
-(void)createLeftHideAnimator:(InboxCardView*)cardView{
    if (cardView == nil) {
        return;
    }
    CGAffineTransform translate_transform = CGAffineTransformMakeTranslation(firstViewLeft,firstViewTop);
    CGAffineTransform translate_transform1 =  CGAffineTransformRotate(translate_transform, 0);
    cardView.transform = CGAffineTransformScale(translate_transform1, 1, 1);
    cardView.alpha = 1.0;
}

/**
 * 创建从左边出现的动画
 *
 * @param cardView 动画执行的View
 */
-(void)createLeftShowAnimator:(InboxCardView*)cardView{
    if (cardView == nil) {
        return;
    }
    CGFloat left=gestureViewLeft;
    if(cardView==self.leftInboxCardView){
        left=cardWidth;
    }
    CGAffineTransform translate_transform = CGAffineTransformMakeTranslation(left,gestureViewTop);
    CGAffineTransform translate_transform1 =  CGAffineTransformRotate(translate_transform, 0);
    cardView.transform = CGAffineTransformScale(translate_transform1, 1, 1);
    cardView.alpha = 1.0;
}

/**
 * 创建向后缩小消失动画
 *
 * @param cardView 使用该动画的view
 */
-(void)createBackwardHideAnimator:(InboxCardView*)cardView{
    if (cardView == nil) {
        return;
    }
    CGAffineTransform translate_transform = CGAffineTransformMakeTranslation(bottomViewLeft, bottomViewTop);
    CGAffineTransform translate_transform1 =  CGAffineTransformRotate(translate_transform, 0);
    cardView.transform = CGAffineTransformScale(translate_transform1, 0.8f,0.8f);
    cardView.alpha = 1.0;
}

/**
 * 创建从上面消失的动画
 *
 * @param cardView 动画执行的View
 * @param rect     消失的区域
 */
-(void)createTopHideAnimator:(InboxCardView*)cardView frame:(CGRect)rect {
    if (cardView == nil) {
        return;
    }
    CGFloat f1 =  rect.size.width / cardView.frame.size.width;
    CGFloat f2 = rect.size.height / cardView.frame.size.height;
    CGAffineTransform translate_transform = CGAffineTransformTranslate(cardView.transform,rect.origin.x-cardView.frame.size.width * (1.0F - f1) / 2.0F, rect.origin.y-cardView.frame.size.height * (1.0F - f2) / 2.0F);
    CGAffineTransform translate_transform1 =  CGAffineTransformRotate(translate_transform, 10.f*((CGFloat)M_PI)/180.0f);
    cardView.transform = CGAffineTransformScale(translate_transform1,f1,f2);
    cardView.alpha = 1.0f;
}

/**
 * 创建从上面出现的动画
 *
 * @param cardView 动画执行的View
 */
-(void)createTopShowAnimator:(InboxCardView*)cardView{
    if (cardView == nil) {
        return;
    }
    cardView.transform = CGAffineTransformIdentity;
    cardView.alpha = 1.0f;
}

/**
 * 初始化从顶部出现的CardView的信息
 *
 * @param cardView 出现的CardView
 * @param rect     出现的CardView的区域
 */
-(void)initTopShowCardView:(InboxCardView *)cardView rect:(CGRect)rect{
    CGFloat f1 = rect.size.width / cardView.frame.size.width;
    CGFloat f2 = rect.size.height/ cardView.frame.size.height;
    CGAffineTransform translate_transform = CGAffineTransformTranslate(cardView.transform,rect.origin.x-cardView.frame.size.width * (1.0F - f1) / 2.0F, rect.origin.y-cardView.frame.size.height * (1.0F - f2) / 2.0F);
     CGAffineTransform translate_transform1 =  CGAffineTransformRotate(translate_transform, 10.0f*((CGFloat)M_PI)/180.0f);
    cardView.transform = CGAffineTransformScale(translate_transform1,f1,f2);
    cardView.alpha = 0.0f;
    cardView.hidden=NO;
    [cardView loadData];
}

/**
 * 初始化从底部出现的CardView的信息
 *
 * @param cardView 出现的CardView
 * @param rect     出现的CardView的区域
 */
-(void)initBottomShowCardView:(InboxCardView *)cardView rect:(CGRect)rect {
    CGFloat f1 = rect.size.width / cardView.frame.size.width;
    CGFloat f2 = rect.size.height/ cardView.frame.size.height;
   CGAffineTransform translate_transform = CGAffineTransformTranslate(cardView.transform,rect.origin.x-cardView.frame.size.width * (1.0F - f1) / 2.0F, rect.origin.y-cardView.frame.size.height * (1.0F - f2) / 2.0F);
    CGAffineTransform translate_transform1 =  CGAffineTransformRotate(translate_transform, 0);
    cardView.transform = CGAffineTransformScale(translate_transform1,f1,f2);
    cardView.alpha = 0.2f;
    cardView.hidden=NO;
    [cardView loadData];
}

/**
 * 初始化底部CardView的信息
 *
 * @param cardView 初始化的View
 */
-(void)initBottomCardView:(InboxCardView*)cardView{
    cardView.frame=CGRectMake(bottomViewLeft, bottomViewTop, cardWidth, cardHeight);
    CGAffineTransform translate_transform = CGAffineTransformMakeTranslation(bottomViewLeft, bottomViewTop);
    cardView.transform=CGAffineTransformScale(translate_transform, 0.8f, 0.8f);
    [cardView setAlpha:0.0f];
    [cardView setHidden:NO];
    [cardView loadData];
}

/**
 * 初始化屏幕中间CardView的信息
 *
 * @param cardView 初始化的View
 */
-(void)initShowCardView:(InboxCardView*)cardView{
    cardView.frame=CGRectMake(gestureViewLeft, gestureViewTop, cardWidth, cardHeight);
    [cardView setAlpha:1.0f];
    [cardView setHidden:NO];
    [cardView loadData];
}

/**
 * 初始化屏幕左方的CardView的信息
 *
 * @param cardView 初始化的View
 */
-(void)initLeftCardView:(InboxCardView*)cardView{
    cardView.frame=CGRectMake(firstViewLeft, firstViewTop, cardWidth, cardHeight);
    [cardView setAlpha:1.0f];
    [cardView setHidden:NO];
    [cardView loadData];
}

/**
 *从第几个开始初始化
 **/
-(void)initFromPosition:(NSUInteger)position{
    [self initCardViews:position];
}

/**
 * 初始化CardView
 *
 * @param position 从第几个开始
 */
-(void)initCardViews:(NSInteger)position{
    [self clearCardView];
    self.bottomInboxCardView=[self createCardView:position+1];
    [self addCardViewToLayout:self.bottomInboxCardView];
    
    self.showInboxCardView=[self createCardView:position];
    [self addCardViewToLayout:self.showInboxCardView];
    
    self.leftInboxCardView=[self createCardView:position-1];
    [self addCardViewToLayout:self.leftInboxCardView];
}

/**
 * 清理所有的CardView
 */
-(void)clearCardView{
    if (self.showInboxCardView != nil) {
        [self removeCardView:self.showInboxCardView];
    }
    if (self.leftInboxCardView != nil) {
         [self removeCardView:self.leftInboxCardView];
    }
    if (self.bottomInboxCardView != nil) {
        [self removeCardView:self.bottomInboxCardView];
    }
    if (self.inboxCardView3 != nil) {
         [self removeCardView:self.inboxCardView3];
    }
    self.leftInboxCardView = nil;
    self.showInboxCardView = nil;
    self.bottomInboxCardView = nil;
    self.inboxCardView3 = nil;
}

/**
 * 从页面中移除CardView
 *
 * @param cardView 要移除的CardView
 */
-(void)removeCardView:(InboxCardView *)cardView{
    if (cardView == nil) {
        return;
    }
    [cardView removeFromSuperview];
}

/**
 * 通过position创建CardView
 *
 * @param position 第几个
 * @return 返回CardView
 */
-(InboxCardView*)createCardView:(NSInteger)position{
    id resourceData = [self getShowResoureData:position];
    if (resourceData == nil){
         return nil;
    }
    InboxCardView *cardView=[self createCardViewFromData:resourceData];
    return cardView;
}

/**
 * 通过ResourceData创建CardView
 *
 * @param resourceData 资源信息
 * @return 返回CardView
 */
-(InboxCardView*)createCardViewFromData:(id)resourceData{
    InboxCardView *createCardView = [[InboxCardView alloc] initWithFrame:CGRectMake(0, 0, cardWidth, cardHeight)];
    createCardView.imageModel=resourceData;
    createCardView.delegate=self.delegate;
    [self.delegate addViewToCardView:createCardView data:resourceData];
    [createCardView setHidden:YES];
    return createCardView;
}

/**
 * 将CardView添加到Layout中
 *
 * @param cardView cardView
 */
-(void)addCardViewToLayout:(InboxCardView*)cardView{
    if (cardView == nil) {
        return;
    }
    [cardView setTransform:CGAffineTransformIdentity];
    [self addSubview:cardView];
}
/**
 * 将CardView添加到Layout中
 *
 * @param cardView cardView
 */
-(void)addCardViewToLayout:(InboxCardView*)cardView cardView:(InboxCardView *)cardView1{
    if (cardView == nil||cardView1==nil) {
        return;
    }
    NSArray *views=[self subviews];
    for (int i = 0; i <views.count; i++) {
        if (views[i]== cardView1) {
            [cardView setTransform:CGAffineTransformIdentity];
            [self insertSubview:cardView atIndex:i];
            return;
        }
    }
}
/**
 * 在cardView2的位置的后面上插入cardView
 *
 * @param cardView 插入的CardView
 * @param cardView1 对比的CardView
 */
-(void)addCardViewAfterToLayout:(InboxCardView*)cardView cardView:(InboxCardView *)cardView1{
    if (cardView == nil || cardView1 == nil) {
        return;
    }
    [self insertSubview:cardView aboveSubview:cardView1];
}

/**
 * 获取当前显示的图片资源
 *
 * @param position 当前index
 * @return 返回图片资源
 */
-(id)getShowResoureData:(NSInteger)position{
    if (position < 0) {
        return nil;
    }
    NSMutableArray *array=[self.dataSource getSource];
    if (position < array.count) {
        return [array objectAtIndex:position];
    }
    return nil;
}

-(void)refreshShowCardView{
    if(self.showInboxCardView==nil){
        return;
    }
    [self.showInboxCardView refresh];
    [self.delegate addViewToCardView:self.showInboxCardView data:self.showInboxCardView.imageModel];
}
@end
