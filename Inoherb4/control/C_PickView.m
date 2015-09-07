//
//  C_PickView.m
//  SFA1
//
//  Created by Ren Yong on 14-4-11.
//  Copyright (c) 2014年 Bruce.ren. All rights reserved.
//

#import "C_PickView.h"
#import "F_Color.h"
#import "DB.h"
#import "NSMutableDictionary+Tool.h"
#import "NSMutableArray+Tool.h"
#import "F_Font.h"
@interface C_PickView()
{
    UITableView* _pickView;
    NSMutableDictionary* _data;
    D_UIItem* _item;
    NSMutableArray* _diclist;
}
@end
@implementation C_PickView
@synthesize delegate=_delegate;

- (id)initWithFrame:(CGRect)frame item:(D_UIItem*)item data:(NSMutableDictionary*)data
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor=col_Black1();
        [self setUserInteractionEnabled:YES];
        _data = data;
        _item = item;
        if(item.isSurverItem)
            _diclist = [[DB instance] fieldListBy:[NSMutableString stringWithFormat:@"SELECT serverid as value,value as labelname  FROM t_psq_options where questionid='%@'",item.dicId]];
        
       else if([item.caption isEqualToString:@"分数"])
              _diclist = [[DB instance] dictList:[data getString:@"dictvalue"]];
        else
        {
            if([item.dataKey isEqualToString:@"CityId"])
            {
                 _diclist = [[DB instance] dictList:item.dicId link:[data getString:@"DistrictId"]];
            }
            else
                _diclist = [[DB instance] dictList:item.dicId];
        }
        [self initTableView];
    }
    return self;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint points = [touch locationInView:self];
    if (points.x >= self.frame.origin.x && points.y >= self.frame.origin.x && points.x <= self.frame.size.width && points.y <= self.frame.size.height)
    {
        [self cancelPicker];
    }
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
    [UIView animateWithDuration:0.5 animations:^{
        _pickView.frame = CGRectMake(0, self.frame.size.height-300,self.frame.size.width,300);
    }];
}


- (void)cancelPicker
{
    [UIView animateWithDuration:0.5
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

    if ([[field getString:@"value"] isEqualToString:[_data getString:_item.dataKey]])
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
//    NSMutableDictionary* field=[_diclist dictAt:indexPath.row];
    
    [self setData:[_diclist dictAt:indexPath.row]];
    if(_delegate)
        [_delegate delegate_selected];
    [self cancelPicker];
}

-(void)setData:(NSMutableDictionary*)field
{
    [_data put:[field getString:@"value"] key:_item.dataKey];
    
    if([_item.dataKey isEqualToString:@"chanceid"])
    {
        [_data put:@"" key:@"IsDeal"];
    }
    else if([_item.dataKey isEqualToString:@"DistrictId"])
    {
        [_data put:@"" key:@"CityId"];
    }
   else if([_item.caption isEqualToString:@"分数"])
   {
       [_data put:[field getString:@"labelname"] key:@"int5"];
   }
//    [_data put:[field getString:@"labelname"] key:[NSString stringWithFormat:@"%@+-name",_item.dataKey]];
}




- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    CGRect screenRect = self.frame;
    UIView* headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenRect.size.width, 40)];
    headerView.autoresizesSubviews = YES;
    headerView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    headerView.userInteractionEnabled = YES;
    headerView.backgroundColor=col_Background();
    headerView.hidden = NO;
    headerView.multipleTouchEnabled = NO;
    headerView.opaque = NO;
    headerView.contentMode = UIViewContentModeScaleToFill;
    
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, screenRect.size.width-50, 40)];
    label.backgroundColor = col_ClearColor();
    label.text=_item.caption;
    label.textAlignment=NSTextAlignmentCenter;
    label.font = fontBysize(15);
    [label setAdjustsFontSizeToFitWidth:YES];
    [headerView addSubview:label];
    
    UIButton* button = [[UIButton alloc] initWithFrame:CGRectMake(screenRect.size.width-30-20, 5, 40, 30)];
//    button.backgroundColor = col_Button();
    [button setTitle:@"取消" forState:UIControlStateNormal];
    [button setTitleColor:col_Button() forState:UIControlStateNormal];
    button.titleLabel.font = fontBysize(15);
    button.layer.cornerRadius=CORNERRADIUS;
    [button.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [button addTarget:self action:@selector(cancelClicked:) forControlEvents:UIControlEventTouchDown];
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
