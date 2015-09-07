//
//  Frm_SetPlan.m
//  SFA1
//
//  Created by Ren Yong on 14-4-10.
//  Copyright (c) 2014年 Bruce.ren. All rights reserved.
//

#import "Frm_SetPlan.h"
#import "F_Color.h"
#import "Constants.h"
#import "DB.h"
#import "C_NavigationBar.h"
#import "C_ImageView.h"
#import "F_Image.h"
#import "F_Date.h"
#import "F_Font.h"
#import "F_Alert.h"
#import "NSMutableArray+Tool.h"
#import "NSMutableDictionary+Tool.h"
#import "C_DropView.h"
#import "C_Label.h"
#import "F_Template.h"
#import "F_UserData.h"
#import "C_ItemView.h"
#import "SyncWeb.h"
#import "C_GradientButton.h"
#import "Frm_PlanList.h"
#import "C_Button.h"
@interface Frm_SetPlan ()
{
    UITableView* _planListView;
    NSMutableArray* _todayPlanList;
    NSString* _selectDate;
    UIView* _DateView;
    NSMutableArray* _weekList;
    NSMutableDictionary* _date;
    NSMutableArray* _weekButtonList;
    UILabel* _selectMonth;
    int requestType;
    
    //    NSMutableDictionary*_dicClientInfo;
}
@end

@implementation Frm_SetPlan


//改变statusbar样式
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

-(id)init
{
    self = [super init];
    if(self)
    {
        //        _dicClientInfo=data;
    }
    return self;
}

-(void)initUI
{
    self.view.backgroundColor = col_Background();
    C_NavigationBar* bar=[[C_NavigationBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, SYSTITLEHEIGHT) title:@"计划"];
    [self.view addSubview:bar];
    C_GradientButton* btn_Back=[[C_GradientButton alloc] initWithFrame:CGRectMake(0, 0, 60, 30) buttonId:-1];
    [btn_Back setTitle:@"" forState:UIControlStateNormal];
    [btn_Back useImgStyle];
    [btn_Back addTarget:self action:@selector(backClicked:) forControlEvents:UIControlEventTouchUpInside];
    [bar addLeftButton:btn_Back];
    
    C_GradientButton* btn_Submit=[[C_GradientButton alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
    
    [btn_Submit setTitle:@"设定" forState:UIControlStateNormal];
    [btn_Submit useAddHocStyle];
    [btn_Submit addTarget:self action:@selector(addPlanClicked:) forControlEvents:UIControlEventTouchUpInside];
    [bar addRightButton:btn_Submit];
    
    [self initDateView];
    [self initPlanList];
}

-(void)backClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)addPlanClicked:(id)sender
{
//   NSString* date= [ [DB instance]valueBy:[NSString stringWithFormat:@"SELECT date('%@','%d days') as date",today(),7 ] key:@"date"];
//    NSLog(@"%@",date);
//    NSMutableArray* arry=weekBeginAndEnd(date);
//    NSLog(@"%@",[arry dictAt:0]);
    if([_selectDate compare:today() ]!=NSOrderedDescending)
        toast_showInfoMsg(@"不能设定今天前的计划", 100);
    else
    {
        Frm_PlanList * nextFrm = [[Frm_PlanList alloc] initWithDate:_selectDate];
        [self.navigationController pushViewController:nextFrm animated:YES];
    }
}

-(void)initPlanList
{
    _planListView=[[UITableView alloc] initWithFrame:CGRectMake(0,SYSTITLEHEIGHT+90, self.view.frame.size.width, self.view.frame.size.height-90-SYSTITLEHEIGHT) style:UITableViewStylePlain];
    [_planListView setSeparatorColor:col_Background()];
    _planListView.delegate = self;
    _planListView.dataSource = self;
    
    //    infoView.userInteractionEnabled=YES;
    
    
    [self.view addSubview:_planListView];
}

-(void)initDateView
{
    _DateView=[[UIView alloc] initWithFrame:CGRectMake(0,SYSTITLEHEIGHT, self.view.frame.size.width, 90)];
    _DateView.backgroundColor=col_Background();
  
    [self.view addSubview:_DateView];
    
    [self initMonth];
    [self initDate];
}

-(void)handleSwipeFrom:(id)sender
{
    NSLog(@"滑动");
    if ([sender direction]==UISwipeGestureRecognizerDirectionLeft )
    {
        [self lastWeek];
    }
    else
        [self forwardWeek];
    
    
}

-(void)initMonth
{
    C_GradientButton* back=[[C_GradientButton alloc] initWithFrame:CGRectMake(70,5, 40, 20) ];
    [back addTarget:self action:@selector(lastMonth:) forControlEvents:UIControlEventTouchUpInside];
    [back setBackgroundColor:[UIColor clearColor]];
    C_ImageView *backView = [[C_ImageView alloc] initWithFrame:CGRectMake(12, 2, 16, 16) image:[UIImage imageNamed:@"backed.png"]];
    [back addSubview:backView];
    [_DateView addSubview:back];
    
    _selectMonth=[[UILabel alloc] initWithFrame:CGRectMake(110,5, 100, 20)];
    _selectMonth.text=thisMohth();
    _selectMonth.font=fontBysize(14);
    _selectMonth.textAlignment=NSTextAlignmentCenter;
    [_DateView addSubview:_selectMonth];
    
    C_GradientButton* forword=[[C_GradientButton alloc] initWithFrame:CGRectMake(210,5, 40, 20) ];
    [forword addTarget:self action:@selector(forwardMonth:) forControlEvents:UIControlEventTouchUpInside];
    [forword setBackgroundColor:[UIColor clearColor]];
    backView = [[C_ImageView alloc] initWithFrame:CGRectMake(12, 2, 16, 16) image:[UIImage imageNamed:@"forward.png"]];
    [forword addSubview:backView];
    [_DateView addSubview:forword];
    
    C_GradientButton* today=[[C_GradientButton alloc] initWithFrame:CGRectMake(280,1, 25, 25)];
    [today setTitle:@"今天" forState:UIControlStateNormal];
    [today useAddHocStyle];
    [today addTarget:self action:@selector(todayClick:) forControlEvents:UIControlEventTouchUpInside];
    [today.titleLabel setFont:fontBysize(10)];//设置显示字体
    //    [today setTitleColor:col_Black() forState:UIControlStateNormal];
    [_DateView addSubview:today];
}

-(void)lastMonth:(id)sender
{
    _selectDate=[[DB instance] valueBy:[NSString stringWithFormat:@"select date('%@','-1 month','start of month') as date",_selectDate] key:@"date"];
    NSLog(@"选择日期:%@",_selectDate);
    _weekList=weekBeginAndEnd(_selectDate);
    [self renewData];
}

-(void)forwardMonth:(id)sender
{
    _selectDate=[[DB instance] valueBy:[NSString stringWithFormat:@"select date('%@','+1 month','start of month') as date",_selectDate] key:@"date"];
    NSLog(@"选择日期:%@",_selectDate);
    _weekList=weekBeginAndEnd(_selectDate);
    [self renewData];
}

-(void)initDate
{
    C_GradientButton* back=[[C_GradientButton alloc] initWithFrame:CGRectMake(5,55, 20, 20) ];
    [back addTarget:self action:@selector(lastWeek) forControlEvents:UIControlEventTouchUpInside];
    [back setBackgroundColor:[UIColor clearColor]];
    C_ImageView *backView = [[C_ImageView alloc] initWithFrame:CGRectMake(2, 2, 16, 16) image:[UIImage imageNamed:@"fastbacked.png"]];
    [back addSubview:backView];
    [_DateView addSubview:back];
    
    C_GradientButton* forword=[[C_GradientButton alloc] initWithFrame:CGRectMake(295,55, 20, 20) ];
    [forword addTarget:self action:@selector(forwardWeek) forControlEvents:UIControlEventTouchUpInside];
    [forword setBackgroundColor:[UIColor clearColor]];
    backView = [[C_ImageView alloc] initWithFrame:CGRectMake(2, 2, 16, 16) image:[UIImage imageNamed:@"fastforward.png"]];
    [forword addSubview:backView];
    [_DateView addSubview:forword];
    
    [self initWeek];
    [self initWeekdata];
}

-(void)lastWeek
{
    _selectDate=lastAndnextWeek(_selectDate,0);
    NSLog(@"选择日期:%@",_selectDate);
    _weekList=weekBeginAndEnd(_selectDate);
    [self renewData];
}

-(void)forwardWeek
{
    _selectDate=lastAndnextWeek(_selectDate,1);;
    NSLog(@"选择日期:%@",_selectDate);
    _weekList=weekBeginAndEnd(_selectDate);
    [self renewData];
}
-(void)initWeekdata
{
    UILabel* dateLabel;
    for (int i=0;i<7;i++)
    {
        dateLabel=[[UILabel alloc] initWithFrame:CGRectMake(3+(30+5)*(i+1),35, 30, 15)];
        dateLabel.text=[self weekdata:i ];
        dateLabel.font=fontBysize(10);
        //        dateLabel.layer.
        dateLabel.textAlignment=NSTextAlignmentCenter;
        [_DateView addSubview:dateLabel];
    }
}

-(NSString*) weekdata:(int)index
{
    switch (index) {
        case 0:
            return @"周一";
        case 1:
            return @"周二";
        case 2:
            return @"周三";
        case 3:
            return @"周四";
        case 4:
            return @"周五";
        case 5:
            return @"周六";
        case 6:
            return @"周日";
            
        default:
            return @"";
    }
}
-(void)initWeek
{
    _weekList=weekBeginAndEnd(_selectDate);
    C_Button* dateButton;
    _weekButtonList=[[NSMutableArray alloc] init];
    
    int index=0;
    for (NSMutableDictionary* date in _weekList)
    {
        index++;
        dateButton=[[C_Button alloc] initWithFrame:CGRectMake(3+(30+5)*index,50, 30, 30) ];
        
        dateButton.layer.cornerRadius = CORNERRADIUS;
        UIColor *color =UIColorFromRGB(0x08a2cc);
        [dateButton.titleLabel setFont:fontBysize(14)];
        
        [dateButton setTitle:[date getString:@"date"] forState:UIControlStateNormal];
        [dateButton addTarget:self action:@selector(selectDate:) forControlEvents:UIControlEventTouchUpInside];
        dateButton.tag=index;
        if(![date getBool:@"selected"])
        {
            [dateButton setBackgroundColor:[UIColor whiteColor]];
            [dateButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
        else
        {
            [dateButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [dateButton setBackgroundColor:color];
        }
        [_weekButtonList addObject:dateButton];
        [_DateView addSubview:dateButton];
    }
    
}

-(void)renewButton
{
    NSMutableDictionary* date;
    
    for (C_Button * button in _weekButtonList ) {
        
        date=[_weekList dictAt:(button.tag-1)];
        [button setTitle:[date getString:@"date"] forState:UIControlStateNormal];//设置显示内容
        
        if ([[[_weekList dictAt:(button.tag-1)] getString:@"wholedate"] isEqualToString:_selectDate]) {
            UIColor *color =UIColorFromRGB(0x08a2cc);
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [button setBackgroundColor:color];
        }
        else
        {
            [button setBackgroundColor:[UIColor whiteColor]];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
        
    }
}

-(void)todayClick:(id)sender
{
    _selectDate=today();
    NSLog(@"选择日期:%@",_selectDate);
    _weekList=weekBeginAndEnd(_selectDate);
    [self renewData];
}

-(void)viewDidAppear:(BOOL)animated
{
    [self loadPlan];
    [_planListView reloadData];
}

-(void)renewData
{
    _selectMonth.text=[_selectDate substringToIndex:7];
    [self renewButton];
    //    [self resetRpt];
    [self loadPlan];
    [_planListView reloadData];
}

-(void)loadPlan
{
    NSMutableDictionary* data=[NSMutableDictionary dictionary];
    [data put:_selectDate key:@"date"];
    _todayPlanList=[[DB instance] fieldListBy:[NSMutableString stringWithFormat:@"select t.serverid as serverid, t.fullname as terminalname from (select * from  T_Visit_Plan_Detail where visittime ='%@' and isdel=0 and issubmit!=2)plan left join t_outlet_main t on plan.clientid=t.serverid",[data getString:@"date"]]];
}

-(void)selectDate:(id)sender
{
    _selectDate=[[_weekList dictAt:((C_GradientButton*)sender).tag-1] getString:@"wholedate"];
    NSLog(@"选择日期:%@",_selectDate);
    [self renewData];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _selectDate=today();
    [self loadPlan];
    [self initUI ];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableViewdelegate&&TableViewdataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableDictionary* field=[_todayPlanList dictAt:indexPath.row];
    static NSString* identifier=@"Cell";
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(!cell)
        cell=[[UITableViewCell  alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    
    cell.textLabel.text=[field getString:@"terminalname"];
    cell.textLabel.font=fontBysize(14);
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
    
    return [_todayPlanList count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

//设置section的标题
- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    CGRect screenRect = [[UIScreen mainScreen] applicationFrame];
    UIView* headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenRect.size.width, 40)];
    headView.autoresizesSubviews = YES;
    headView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    headView.userInteractionEnabled = YES;
    
    //    headView.backgroundColor=col_Background();
    headView.hidden = NO;
    headView.multipleTouchEnabled = NO;
    headView.opaque = NO;
    headView.contentMode = UIViewContentModeScaleToFill;
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = CGRectMake(0, 0, screenRect.size.width, 40);
    UIColor *endColor =UIColorFromRGB(0xD9ECF1);
    gradient.colors = [NSArray arrayWithObjects:(id)[endColor CGColor],
                       (id)[endColor CGColor],nil];
    [headView.layer insertSublayer:gradient atIndex:0];
    
    C_Label* lable=[[C_Label alloc] initWithFrame: CGRectMake(0, 0,screenRect.size.width, 40)  label:@"  客户"];
    lable.backgroundColor=col_ClearColor();
    lable.textAlignment=NSTextAlignmentLeft;
    lable.textColor=[ UIColor blackColor ];
    [headView addSubview:lable];
    
    return headView;
    
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
    return 50;
}

@end
