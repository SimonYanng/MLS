//
//  F_Image.m
//  SFA
//
//  Created by Ren Yong on 13-10-24.
//  Copyright (c) 2013年 Bruce.ren. All rights reserved.
//

#import "F_Image.h"

UIImage* img_Checked()
{
    return [UIImage imageNamed:@"checked.png"];
}

UIImage* img_UnChecked()
{
    return [UIImage imageNamed:@"unchecked.png"];
}

UIImage* img_TopLine()
{
    return [UIImage imageNamed:@"top_line.png"];
}

UIImage* img_ButtomLine()
{
    return [UIImage imageNamed:@"line.png"];
}

UIImage* img_Accessory()
{
    return [UIImage imageNamed:@"accessory.png"];
}

UIImage* img_Camera()
{
    return [UIImage imageNamed:@"camera.png"];
}

UIImage* img_MustInput()
{
    return [UIImage imageNamed:@"mustinput.png"];
}

UIImage* img_Pin()
{
    return [UIImage imageNamed:@"pin.png"];
}

UIImage* img_Number()
{
    return [UIImage imageNamed:@"number.png"];
}

UIImage* img_Back()
{
    return [UIImage imageNamed:@"back.png"];
}

UIImage* img_MenuPhoto()
{
    return [UIImage imageNamed:@"menuphoto.png"];
}

UIImage* img_UnCall()
{
    return [UIImage imageNamed:@"unchecked.png"];
}

UIImage* img_Basic()
{
    return [UIImage imageNamed:@"basicinfo.png"];
}

UIImage* img_Product()
{
    return [UIImage imageNamed:@"productinfo.png"];
}

UIImage* img_Photo()
{
    return [UIImage imageNamed:@"camera_nav.png"];
}

UIImage* img_DefoultImg()
{
    return [UIImage imageNamed:@"logo.png"];
}

UIImage* img_Add()
{
    return [UIImage imageNamed:@"addsku.png"];
}

UIImage* img_Triangle()
{
    return [UIImage imageNamed:@"triangle.png"];
}

UIImage* imgbyId(int imgId)
{
    switch (imgId) {
            
        case -1:
            return  [UIImage imageNamed:@"back_df"];
        case -2:
            return  [UIImage imageNamed:@"login0.png"];
            
        case 1:
            return  img_Basic();
        case 2:
            return img_Product();
        case 3:
            return  img_Photo();
            
        case 11:
            return [UIImage imageNamed:@"plan_1.png"];
        case 12:
            return [UIImage imageNamed:@"place_1.png"];
        case 13:
            return [UIImage imageNamed:@"data_1.png"];
        case 14:
            return [UIImage imageNamed:@"mail_1.png"];
        case 15:
            return [UIImage imageNamed:@"key_1.png"];
            
        case 16:
            return [UIImage imageNamed:@"key_1.png"];
        case 17:
            return [UIImage imageNamed:@"key_1.png"];
        case 18:
            return [UIImage imageNamed:@"key_1.png"];
        case 19:
            return [UIImage imageNamed:@"key_1.png"];
        case 20:
            return [UIImage imageNamed:@"signature.png"];
        case 99:
            return [UIImage imageNamed:@"kq.png"];
        case 100:
            return [UIImage imageNamed:@"drgz.png"];
        case 101:
            return [UIImage imageNamed:@"jh.png"];
        case 102:
            return [UIImage imageNamed:@"zbbf.png"];
        case 103:
            return [UIImage imageNamed:@"gz.png"];
        case 104:
            return [UIImage imageNamed:@"gg.png"];
        case 105:
            return [UIImage imageNamed:@"dzzl.png"];
        case 106:
            return [UIImage imageNamed:@"xtsz.png"];
        case 107:
            return [UIImage imageNamed:@"gx.png"];
        case 108:
            return [UIImage imageNamed:@"huigu.png"];
        default:
            return [UIImage imageNamed:@"basicinfo.png"];
    }
}

UIImage* imgSelectbyId(int imgId)
{
    switch (imgId) {
            
        case -1:
            return  [UIImage imageNamed:@"back_sel"];
            
        case -2:
            return  [UIImage imageNamed:@"login1.png"];
        case 11:
            return [UIImage imageNamed:@"plan_0.png"];
        case 12:
            return [UIImage imageNamed:@"place_0.png"];
        case 13:
            return [UIImage imageNamed:@"data_0.png"];
        case 14:
            return [UIImage imageNamed:@"mail_0.png"];
        case 15:
            return [UIImage imageNamed:@"key_0.png"];
        case 16:
        return [UIImage imageNamed:@"key_0.png"];
        case 17:
        return [UIImage imageNamed:@"key_0.png"];
        case 18:
        return [UIImage imageNamed:@"key_0.png"];
        
        case 99:
            return [UIImage imageNamed:@"kq.png"];
        case 100:
            return [UIImage imageNamed:@"drgz.png"];
        case 101:
            return [UIImage imageNamed:@"jh.png"];
        case 102:
            return [UIImage imageNamed:@"zbbf.png"];
        case 103:
            return [UIImage imageNamed:@"gz.png"];
        case 104:
            return [UIImage imageNamed:@"gg.png"];
        case 105:
            return [UIImage imageNamed:@"dzzl.png"];
        case 106:
            return [UIImage imageNamed:@"xtsz.png"];
        case 107:
            return [UIImage imageNamed:@"gx.png"];
        case 108:
            return [UIImage imageNamed:@"huigu.png"];
        default:
            return [UIImage imageNamed:@"basicinfo.png"];
    }
}
