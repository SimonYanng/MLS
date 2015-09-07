//
//  C_MutiPickerView.m
//  SFA1
//
//  Created by Ren Yong on 14-4-11.
//  Copyright (c) 2014年 Bruce.ren. All rights reserved.
//

#import "C_MutiPickerView.h"
#import "F_Color.h"
#import "DB.h"
#import "NSMutableDictionary+Tool.h"
#import "NSMutableArray+Tool.h"
#import "F_Font.h"
@interface C_MutiPickerView()
{
    UITableView* _pickView;
    NSMutableDictionary* _data;
    D_UIItem* _item;
    NSMutableArray* _diclist;
    
    NSMutableDictionary *_selectDic;
}
@end
@implementation C_MutiPickerView

@synthesize delegate=_delegate;

- (id)initWithFrame:(CGRect)frame item:(D_UIItem*)item data:(NSMutableDictionary*)data
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor=col_Black1();
        _data = data;
        _item = item;
        if(item.isSurverItem)
            _diclist = [[DB instance] fieldListBy:[NSMutableString stringWithFormat:@"SELECT serverid as value,value as labelname  FROM t_psq_options where questionid='%@'",item.dicId]];
        else
            _diclist = [[DB instance] dictList:item.dicId];
        [self initSelectDic];
        [self initTableView];
    }
    return self;
}

-(void)initSelectDic
{
    _selectDic= [NSMutableDictionary dictionary];
    NSString* value=[_data getString:_item.dataKey];
    NSRange range;
    for (int i=0; i<[_diclist count]; i++) {
        
        range=[value rangeOfString:[NSString stringWithFormat:@"%@,",[self result:i] ]];
        if(range.length>0){
            [_selectDic putBool:YES key:[self result:i]];
        }
        else
            [_selectDic putBool:NO key:[self result:i]];
    }
}

-(NSString*)result:(int)index
{
    return [[_diclist dictAt:index] getString:DICTVALUE];
}

-(void)initTableView
{
    _pickView=[[UITableView alloc] initWithFrame:CGRectMake(0,self.frame.size.height, self.frame.size.width, 300) style:UITableViewStylePlain];
    [_pickView setSeparatorColor:col_Background()];
    _pickView.delegate = self;
    _pickView.dataSource = self;
    _pickView.showsVerticalScrollIndicator=NO;
    [self addSubview:_pickView];
}

- (void)showInView:(UIView *) view
{
    [view addSubview:self];
    [UIView animateWithDuration:0.3 animations:^{
        _pickView.frame = CGRectMake(0, self.frame.size.height-300,self.frame.size.width,300);
    }];
}

- (void)cancelPicker
{
    [UIView animateWithDuration:0.3
                     animations:^
     {
         _pickView.frame = CGRectMake(0, self.frame.size.height,self.frame.size.width,300);
     }
                     completion:^(BOOL finished){
                         [self removeFromSuperview];
                     }];
}

-(void)cancelClicked:(id)sender
{
    
    //    if(_delegate)
    //        [_delegate delegate_selected];
    //    [self cancelPicker];

    
    [self cancelPicker];
}

-(void)okClicked:(id)sender
{
    [self setData];
    if(_delegate)
        [_delegate delegate_selected];
    [self cancelPicker];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSMutableDictionary* field=[_diclist dictAt:indexPath.row];
    static NSString* identifier=@"Cell";
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(!cell)
        cell=[[UITableViewCell  alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    
    cell.textLabel.text=[field getString:@"labelname"];
    
    if ([_selectDic getBool:[field getString:DICTVALUE]])
        cell.accessoryType=UITableViewCellAccessoryCheckmark;
    else
        cell.accessoryType=UITableViewCellAccessoryNone;
    
    if (indexPath.row % 2)
    {
        [cell setBackgroundColor:col_Background()];
    }else {
        [cell setBackgroundColor:col_ClearColor()];
    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_diclist count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableDictionary* field=[_diclist dictAt:indexPath.row];
    
    if ([_selectDic getBool:[field getString:DICTVALUE]])
        [_selectDic putBool:NO key:[field getString:DICTVALUE]];
    else
        [_selectDic putBool:YES key:[field getString:DICTVALUE]];
    [_pickView reloadData];
}

-(void)setData
{
    
    NSMutableString *value = [NSMutableString stringWithFormat:@""];
    for(NSString *key in _selectDic) {
        if([_selectDic getBool:key])
        {
            [value appendString:key];
            [value appendString:@","];
        }
    }
    NSLog(@"%@",value);
    [_data put:value key:_item.dataKey];
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    CGRect screenRect = [[UIScreen mainScreen] applicationFrame];
    UIView* headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenRect.size.width, 40)];
    headerView.autoresizesSubviews = YES;
    headerView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    headerView.userInteractionEnabled = YES;
    headerView.backgroundColor=col_Background();
    headerView.hidden = NO;
    headerView.multipleTouchEnabled = NO;
    headerView.opaque = NO;
    headerView.contentMode = UIViewContentModeScaleToFill;
    
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(55, 0, 210, 40)];
    label.backgroundColor = col_ClearColor();
    label.text=_item.caption;
    label.font = fontBysize(13);
    label.textAlignment=NSTextAlignmentCenter;
    [label setAdjustsFontSizeToFitWidth:YES];
    [headerView addSubview:label];
    
    UIButton* button = [[UIButton alloc] initWithFrame:CGRectMake(5, 5, 40, 30)];
//    button.backgroundColor = col_Button();
    [button setTitle:@"取消" forState:UIControlStateNormal];
    [button setTitleColor:col_Button() forState:UIControlStateNormal];
    button.titleLabel.font = fontBysize(12);
    button.layer.cornerRadius=CORNERRADIUS;
    [button.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [button addTarget:self action:@selector(cancelClicked:) forControlEvents:UIControlEventTouchDown];
    [headerView addSubview:button];
    
    button = [[UIButton alloc] initWithFrame:CGRectMake(270, 5, 40, 30)];
//    button.backgroundColor = col_Button();
    [button setTitle:@"确定" forState:UIControlStateNormal];
    [button setTitleColor:col_Button() forState:UIControlStateNormal];
    button.titleLabel.font = fontBysize(12);
    button.layer.cornerRadius=CORNERRADIUS;
    [button.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [button addTarget:self action:@selector(okClicked:) forControlEvents:UIControlEventTouchDown];
    [headerView addSubview:button];
    return headerView;
    
}

//设置section的标题的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

//设置cell的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return CELLHEIGHT;
}

@end
