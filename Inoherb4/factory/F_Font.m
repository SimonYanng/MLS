//
//  F_Font.m
//  SFA
//
//  Created by Ren Yong on 13-10-24.
//  Copyright (c) 2013年 Bruce.ren. All rights reserved.
//

#import "F_Font.h"

UIFont* font_Caption()
{
    //    UIFont* font=[[UIFont alloc]init];
    //    font.systemFontSize=15.0;
    //    font.
    
    return [UIFont fontWithName:@"Helvetica" size:18.0];
    //    return [UIFont systemFontOfSize:15.0];
}

UIFont* font_Label()
{
    return [UIFont fontWithName:@"Helvetica" size:13.0];
}

UIFont* font_NavLabel()
{
    return [UIFont fontWithName:@"Helvetica" size:16.0];
}

UIFont* fontBysize(float size)
{
    //    return [UIFont fontWithName:@"Helvetica" size:size];
    return [UIFont systemFontOfSize:size];
}

UIFont* fontByBoldsize(float size)
{
    return [UIFont boldSystemFontOfSize:size];
    //    return [UIFont systemFontOfSize:15.0];
}

/**
	<#Description#> 内容的字体
	@returns <#return value description#>
 */
UIFont* font_Item()
{
    return [UIFont fontWithName:@"Helvetica" size:17.0];
    //    return [UIFont systemFontOfSize:15.0];
}

UIFont* font_CheckBox()
{
    return [UIFont fontWithName:@"Helvetica" size:12.0];
    //    return [UIFont systemFontOfSize:15.0];
}

UIFont* font_Text()
{
    return [UIFont fontWithName:@"Helvetica" size:12.0];
    //    return [UIFont systemFontOfSize:15.0];
}


UIFont* font_SysTitle()
{
    return [UIFont fontWithName:@"Helvetica" size:18.0];
    //    return [UIFont systemFontOfSize:15.0];
}

UIFont* font_LoginButton()
{
    return [UIFont fontWithName:@"Helvetica" size:17.0];
    //    return [UIFont systemFontOfSize:15.0];
}

UIFont* font_NavButton()
{
    return [UIFont fontWithName:@"Helvetica" size:14.0];
    //    return [UIFont systemFontOfSize:15.0];
}

UIFont* font_RptButton()
{
    return [UIFont fontWithName:@"Helvetica" size:10.0];
    //    return [UIFont systemFontOfSize:15.0];
}