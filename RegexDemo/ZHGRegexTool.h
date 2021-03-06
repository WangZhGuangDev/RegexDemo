//
//  ZHGRegexTool
//
//  Created by DDing_Work on 2017/9/4.
//  Copyright © 2017年 DDing_Work. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZHGRegexTool : NSObject

/**
 验证手机号

 @param phoneNumber 手机号
 @return 手机号格式是否正确
 */
+(BOOL)regexWithMobileNumber:(NSString *)phoneNumber;

/**
 验证复杂密码：类似QQ 支持数字、字母、符号6-20位,必须包含其中至少两种

 @param password 密码
 @return 密码格式是否正确
 */
+(BOOL)regexWithPasswordComplex:(NSString *)password;

/**
 验证简单密码： 支持数字、字母6-20位
 
 @param password 密码
 @return 密码格式是否正确
 */
+(BOOL)regexWithPasswordSimple:(NSString *)password;

/**
 验证邮箱

 @param email 邮箱地址
 @return 邮箱格式是否正确
 */
+(BOOL)regexWithEmailAddress:(NSString *)email;

/**
 验证网址

 @param url 网址
 @return 网址是否正确
 */
+(BOOL)regexWithUrl:(NSString *)url;


/**
 简单验证身份证号
 
 @param identityCard 身份证
 @return 身份证号码格式是否正确
 */
+(BOOL)regexWithIdentityCardSimple:(NSString *)identityCard;

/**
 精确验证身份证号

 @param identityCard 身份证
 @return 身份证号码格式是否正确
 */
+(BOOL)regexWithIdentityCardPrecise:(NSString *)identityCard;

/**
 验证车牌号码

 @param carNumber 车牌号码
 @return 车牌号码是否正确
 */
+(BOOL)regexWithCarNumber:(NSString *)carNumber;

/**
 验证车型

 @param carType 车型
 @return 车型是否正确
 */
+(BOOL)regexWithCarType:(NSString *)carType;

/**
 验证银行卡号

 @param bankCardNumber 银行卡号
 @return 银行卡号是否正确
 */
+(BOOL)regexWithBankCardNumber:(NSString *)bankCardNumber;

/**
 验证 ip 地址

 @param ipString ip地址
 @return ip地址是否正确
 */
+ (BOOL)regexWithIPAddess:(NSString *)ipString;

/**
 验证用户名：采用了和简单密码一样的规则，字母和数字组合，具体使用情况自行修改

 @param userName 用户名
 @return 用户名是否正确
 */
+(BOOL)regexWithUserName:(NSString *)userName;

/**
 验证昵称：限制了只能中文，具体使用情况自行修改
 
 @param nickname 昵称：中文
 @return 昵称格式是否正确
 */
+(BOOL)regexWithNickname:(NSString *)nickname;

@end
