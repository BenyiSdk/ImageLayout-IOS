//
//  ViewController.m
//  TestSlideBix
//
//  Created by by on 2018/5/28.
//  Copyright © 2018年 小kk. All rights reserved.
//

#import "ViewController.h"
#import "InboxActivityLayout.h"
@interface ViewController ()<InboxActivityLayoutDataSource,InboxActivityLayoutActionDelegate,UITableViewDelegate,UITableViewDataSource>
@property InboxActivityLayout *inboxLayout;
@property NSMutableArray *array;
@property NSMutableArray *topArray;
@property NSUInteger showIndex;
@property UIImageView *undo;
@property UIImageView *trash;
@property UITextView *bottomView;
@property BOOL isList;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor blackColor];
    _isList=NO;
    UIImage *undoImage=[UIImage imageNamed:@"undo_button_108x108.png"];
    _undo=[[UIImageView alloc] initWithImage:undoImage];
    _undo.layer.masksToBounds = YES;
    //自适应图片宽高比例
    _undo.contentMode = UIViewContentModeScaleAspectFit;
    _undo.frame=CGRectMake(10, 0, 54, 54);
    [self.view addSubview:_undo];
    
    UIImage *trashImage=[UIImage imageNamed:@"trash_can_112x112.png"];
    _trash=[[UIImageView alloc] initWithImage:trashImage];
    _trash.layer.masksToBounds = YES;
    //自适应图片宽高比例
    _trash.contentMode = UIViewContentModeScaleAspectFit;
    _trash.frame=CGRectMake(321, 0, 54, 54);
    _trash.userInteractionEnabled=YES;
    [self.view addSubview:_trash];
    
    _bottomView=[[UITextView alloc] initWithFrame:CGRectMake(170, UIScreen.mainScreen.bounds.size.height-30, 30, 30)];
    [_bottomView setText:@"test"];
    [self.view addSubview:_bottomView];
    
    _inboxLayout=[[InboxActivityLayout alloc] initWithFrame:CGRectMake(0, 54, UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height-84)];
    _inboxLayout.dataSource=self;
    _inboxLayout.delegate=self;
    _inboxLayout.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:_inboxLayout];
    _array=[[NSMutableArray alloc] init];
    _topArray=[[NSMutableArray alloc] init];
    _showIndex=0;
    for(int i=0;i<5;i++){
        [_array addObject:[NSString stringWithFormat:@"%d",i]];
    }
    UITapGestureRecognizer *tapGesturRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    
    [_trash addGestureRecognizer:tapGesturRecognizer];
}

-(void)tapAction:(id)tap{
    _isList=!_isList;
    [self.inboxLayout refreshShowCardView];
    [self.inboxLayout layoutSubviews];
}
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [_inboxLayout initFromPosition:self.showIndex];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}
-(NSMutableArray *)getSource{
    return _array;
}

- (NSUInteger)getShowIndex{
    return _showIndex;
}
- (void)nextAction{
    _showIndex++;
}
- (void)prevAction{
    _showIndex--;
}
-(void)topAction{
    [_topArray addObject:[_array objectAtIndex:_showIndex]];
    [_array removeObjectAtIndex:_showIndex];
    [UIView animateWithDuration:0.05 animations:^{
        self->_trash.transform=CGAffineTransformMakeScale(1.16, 1.16);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.05 animations:^{
            self->_trash.transform=CGAffineTransformMakeScale(1, 1);
        }];
    }];
}
-(void)bottomAction{
    [self importPhoto:@""];
}
-(void)bottomAction:(NSString *)name{
    
}
-(void)importPhoto:(NSString *)floder{
    if([_inboxLayout isReady]){
        return;
    }
    NSString *model=_array[_showIndex];
    [_array removeObject:model];
    [_inboxLayout bottomPhotoToFloder:@""];
}
- (CGRect)getTopHideRect{
    return  _trash.frame;
}
-(CGRect)getBottomHideRect{
    return _bottomView.frame;
}

- (void)addViewToCardView:(UIView *)cardView data:(id)data{
    NSArray *views=[cardView subviews];
    for(int i=0;i<views.count;i++){
        [(UIView *)views[i] removeFromSuperview];
    }
    NSInteger index=[_array indexOfObject:data];
    if(_isList&&index%2==0){
        UITableView *uitableView=[[UITableView alloc] initWithFrame:cardView.frame];
        uitableView.dataSource=self;
        uitableView.delegate=self;
        uitableView.userInteractionEnabled=NO;
        [uitableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"idd"];
        [cardView addSubview:uitableView];
    }else{
        UIImageView *imageView=[[UIImageView alloc] initWithFrame:cardView.frame];
        [cardView addSubview:imageView];
    }
}
- (void)loadResourceToCardView:(id)data view:(UIView *)view{
    UIView *v=[[view subviews] objectAtIndex:0];
    if([v isKindOfClass:[UIImageView class]]){
         NSString *imageName=data;
         [((UIImageView *)v) setImage:[UIImage imageNamed:imageName]];
    }else{
        
    }
}
-(void)sigleClick:(UIView *)cardView data:(id)data{
    NSLog(@"111");
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _topArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //从队列中取出单元格
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"idd" forIndexPath:indexPath];
    //为单元格的label设置数据
     cell.imageView.image = [UIImage imageNamed:[_topArray objectAtIndex:indexPath.row]];
    return cell;
}
@end
