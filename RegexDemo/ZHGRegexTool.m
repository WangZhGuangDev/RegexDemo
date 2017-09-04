//
//  RegexTool.m
//  MD5文件校验
//
//  Created by DDing_Work on 2017/9/4.
//  Copyright © 2017年 DDing_Work. All rights reserved.
//

#import "ZHGRegexTool.h"

@implementation ZHGRegexTool

/**
 正则验证手机号
 */
+(BOOL)regexWithMobileNumber:(NSString *)phoneNumber {
    /**
     
     中国移动新增了 198 开头的号码选择，中国电信是 199 开头，中国联通则是 166 开头
     注：新号段是2017年8月13日工信部向三大运营商批准的，不过在写此正则的时候还没有正式发布，等以后正式发布了，在正则里添加上即可
     新号段发布前三大运营商的手机号段：
     中国移动：134、135、136、137、138、139、150、151、152、157 ( TD ) 、158、159、182、183、184、187、178、188、147 ( 数据卡号段 ) 、1705 ( 虚拟运营商移动号段 )
     
     中国联通：130、131、132、145 ( 数据卡号段 ) 155、156、176、185、186、1709 ( 虚拟运营商联通号段 )
     
     中国电信：133、153、177、180、181、189、 ( 1349 卫通 ) 、1700 ( 虚拟运营商电信号段 )
     
     */
    //130-139 150-153 155-159 180-189 145 147 170 171 173 176 177 178
    NSString *phoneRegex = @"^((13[0-9])|(14[57])|(15[^4,\\D])|(17[01678])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:phoneNumber];
}

/**
 正则验证复杂密码：类似QQ 支持数字、字母、符号6-20位,必须包含其中至少两种
 */
+(BOOL)regexWithPasswordComplex:(NSString *)password {
    // 类似QQ 支持数字、字母、符号6-20位,必须包含其中至少两种
    NSString *passWordRegex = @"^(?=.*[a-zA-Z0-9].*)(?=.*[a-zA-Z\\W].*)(?=.*[0-9\\W].*).{6,20}$";
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", passWordRegex];
    BOOL isMatch = [predicate evaluateWithObject:password];
    return isMatch;
}

/**
 正则验证简单密码： 支持数字、字母6-20位
 */
+(BOOL)regexWithPasswordSimple:(NSString *)password {
    /**
     @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,20}$" ：此正则限定6到20位数字和字母的组合，两者必须同时存在，只有数字或只有字母会判定失败，
     @"^[A-Za-z0-9]{6,20}$" ：此表达式只限定6到20位数字或字母或者二者组合
    
         具体使用哪一种视要求而定
     */
    
    NSString * regex = @"^[A-Za-z0-9]{6,20}$"; // 设定长度 为 6~20位;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [predicate evaluateWithObject:password];
    return isMatch;
}

/**
 正则验证邮箱
 */
+(BOOL)regexWithEmailAddress:(NSString *)email {
  
//    NSString *emailRegex = @"^[\\w-]+(\\.[\\w-]+)*@[\\w-]+(\\.[\\w-]+)+$";
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";

    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [predicate evaluateWithObject:email];
}

/**
 验证网址
 */
+(BOOL)regexWithUrl:(NSString *)url {
    NSString *urlRegex = @"((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", urlRegex];
    
    return [predicate evaluateWithObject:url];
}

/**
 验证身份证：简单
 */
+(BOOL)regexWithIdentityCardSimple:(NSString *)identityCard {
    BOOL flag;
    if (identityCard.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:identityCard];
}
/**
 验证身份证：精确
 */
+(BOOL)regexWithIdentityCardPrecise:(NSString *)identityCard {
    return [self accurateVerifyIDCardNumber:identityCard];
}
#pragma mark - 算法相关
//精确的身份证号码有效性检测
+ (BOOL)accurateVerifyIDCardNumber:(NSString *)value {
    value = [value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    int length =0;
    if (!value) {
        return NO;
    } else {
        length = (int)value.length;
        
        if (length !=15 && length !=18) {
            return NO;
        }
    }
    // 省份代码
    NSArray *provinceArray =@[@"11",@"12", @"13",@"14", @"15",@"21", @"22",@"23", @"31",@"32", @"33",@"34", @"35",@"36", @"37",@"41", @"42",@"43", @"44",@"45", @"46",@"50", @"51",@"52", @"53",@"54", @"61",@"62", @"63",@"64", @"65",@"71", @"81",@"82", @"91"];
    
    NSString *valueStart2 = [value substringToIndex:2];
    BOOL areaFlag = NO;
    for (NSString *areaCode in provinceArray) {
        if ([areaCode isEqualToString:valueStart2]) {
            areaFlag =YES;
            break;
        }
    }
    
    if (!areaFlag) {
        return false;
    }
    
    
    NSRegularExpression *regularExpression;
    NSUInteger numberofMatch;
    
    int year =0;
    switch (length) {
        case 15:
            year = [value substringWithRange:NSMakeRange(6,2)].intValue +1900;
            
            if (year %4 ==0 || (year %100 ==0 && year %4 ==0)) {
                
                regularExpression = [[NSRegularExpression alloc] initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}$"
                                                                         options:NSRegularExpressionCaseInsensitive
                                                                           error:nil];//测试出生日期的合法性
            }else {
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}$"
                                                                        options:NSRegularExpressionCaseInsensitive
                                                                          error:nil];//测试出生日期的合法性
            }
            numberofMatch = [regularExpression numberOfMatchesInString:value
                                                               options:NSMatchingReportProgress
                                                                 range:NSMakeRange(0, value.length)];
            
            if(numberofMatch >0) {
                return YES;
            }else {
                return NO;
            }
        case 18:
            year = [value substringWithRange:NSMakeRange(6,4)].intValue;
            if (year %4 ==0 || (year %100 ==0 && year %4 ==0)) {
                
                regularExpression = [[NSRegularExpression alloc] initWithPattern:@"^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}[0-9Xx]$"
                                                                         options:NSRegularExpressionCaseInsensitive
                                                                           error:nil];//测试出生日期的合法性
            }else {
                regularExpression = [[NSRegularExpression alloc] initWithPattern:@"^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}[0-9Xx]$"
                                                                         options:NSRegularExpressionCaseInsensitive
                                                                           error:nil];//测试出生日期的合法性
            }
            numberofMatch = [regularExpression numberOfMatchesInString:value
                                                               options:NSMatchingReportProgress
                                                                 range:NSMakeRange(0, value.length)];
            
            if(numberofMatch >0) {
                int S = ([value substringWithRange:NSMakeRange(0,1)].intValue + [value substringWithRange:NSMakeRange(10,1)].intValue) *7 + ([value substringWithRange:NSMakeRange(1,1)].intValue + [value substringWithRange:NSMakeRange(11,1)].intValue) *9 + ([value substringWithRange:NSMakeRange(2,1)].intValue + [value substringWithRange:NSMakeRange(12,1)].intValue) *10 + ([value substringWithRange:NSMakeRange(3,1)].intValue + [value substringWithRange:NSMakeRange(13,1)].intValue) *5 + ([value substringWithRange:NSMakeRange(4,1)].intValue + [value substringWithRange:NSMakeRange(14,1)].intValue) *8 + ([value substringWithRange:NSMakeRange(5,1)].intValue + [value substringWithRange:NSMakeRange(15,1)].intValue) *4 + ([value substringWithRange:NSMakeRange(6,1)].intValue + [value substringWithRange:NSMakeRange(16,1)].intValue) *2 + [value substringWithRange:NSMakeRange(7,1)].intValue *1 + [value substringWithRange:NSMakeRange(8,1)].intValue *6 + [value substringWithRange:NSMakeRange(9,1)].intValue *3;
                int Y = S %11;
                NSString *M =@"F";
                NSString *JYM =@"10X98765432";
                M = [JYM substringWithRange:NSMakeRange(Y,1)];// 判断校验位
                if ([M isEqualToString:[value substringWithRange:NSMakeRange(17,1)]]) {
                    return YES;// 检测ID的校验位
                } else {
                    return NO;
                }
                
            } else {
                return NO;
            }
        default:
            return NO;
    }
}


/**
 正则验证车牌号码
 */
+(BOOL)regexWithCarNumber:(NSString *)carNumber {
    
    
    NSString *carNORegex = @"^[\u4e00-\u9fa5]{1}[a-zA-Z]{1}[a-zA-Z_0-9]{4}[a-zA-Z_0-9_\u4e00-\u9fa5]$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carNORegex];
    return [predicate evaluateWithObject:carNumber];
    
    //以下是网上另外一种写法
//    NSString * carNORegex = @"^[蒙|冀|黑|宁|云|皖|苏|桂|琼|湘|吉|闽|贵|辽|沪|粤|浙|青|鲁|津|京|藏|甘|川|新|赣|豫|晋|陕|鄂|渝]{1}[a-zA-Z]{1}[a-zA-Z_0-9]{5}$";
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", carNORegex];
//    return [predicate evaluateWithObject:carNumber];
}

/**
 正则验证车型
 
 @param carType 车型
 @return 车型是否正确
 */
+(BOOL)regexWithCarType:(NSString *)carType {
    NSString *CarTypeRegex = @"^[\u4E00-\u9FFF]+$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",CarTypeRegex];
    return [predicate evaluateWithObject:carType];
}


/** 银行卡号有效性问题Luhn算法
 * 现行 16 位银联卡现行卡号开头 6 位是 622126～622925 之间的，7 到 15 位是银行自定义的，
 * 可能是发卡分行，发卡网点，发卡序号，第 16 位是校验码。
 * 16 位卡号校验位采用 Luhm 校验方法计算：
 * 1，将未带校验位的 15 位卡号从右依次编号 1 到 15，位于奇数位号上的数字乘以 2
 * 2，将奇位乘积的个十位全部相加，再加上所有偶数位上的数字
 * 3，将加法和加上校验位能被 10 整除。
 */
+(BOOL)regexWithBankCardNumber:(NSString *)bankCardNumber {
    
    NSString * lastNum = [[bankCardNumber substringFromIndex:(bankCardNumber.length-1)] copy];//取出最后一位
    NSString * forwardNum = [[bankCardNumber substringToIndex:(bankCardNumber.length -1)] copy];//前15或18位
    
    NSMutableArray * forwardArr = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i=0; i<forwardNum.length; i++) {
        NSString * subStr = [forwardNum substringWithRange:NSMakeRange(i, 1)];
        [forwardArr addObject:subStr];
    }
    
    NSMutableArray * forwardDescArr = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i = (int)(forwardArr.count-1); i> -1; i--) {//前15位或者前18位倒序存进数组
        [forwardDescArr addObject:forwardArr[i]];
    }
    
    NSMutableArray * arrOddNum = [[NSMutableArray alloc] initWithCapacity:0];//奇数位*2的积 < 9
    NSMutableArray * arrOddNum2 = [[NSMutableArray alloc] initWithCapacity:0];//奇数位*2的积 > 9
    NSMutableArray * arrEvenNum = [[NSMutableArray alloc] initWithCapacity:0];//偶数位数组
    
    for (int i=0; i< forwardDescArr.count; i++) {
        NSInteger num = [forwardDescArr[i] intValue];
        if (i%2) {//偶数位
            [arrEvenNum addObject:[NSNumber numberWithInteger:num]];
        }else{//奇数位
            if (num * 2 < 9) {
                [arrOddNum addObject:[NSNumber numberWithInteger:num * 2]];
            }else{
                NSInteger decadeNum = (num * 2) / 10;
                NSInteger unitNum = (num * 2) % 10;
                [arrOddNum2 addObject:[NSNumber numberWithInteger:unitNum]];
                [arrOddNum2 addObject:[NSNumber numberWithInteger:decadeNum]];
            }
        }
    }
    
    __block NSInteger sumOddNumTotal = 0;
    [arrOddNum enumerateObjectsUsingBlock:^(NSNumber * obj, NSUInteger idx, BOOL *stop) {
        sumOddNumTotal += [obj integerValue];
    }];
    
    __block NSInteger sumOddNum2Total = 0;
    [arrOddNum2 enumerateObjectsUsingBlock:^(NSNumber * obj, NSUInteger idx, BOOL *stop) {
        sumOddNum2Total += [obj integerValue];
    }];
    
    __block NSInteger sumEvenNumTotal =0 ;
    [arrEvenNum enumerateObjectsUsingBlock:^(NSNumber * obj, NSUInteger idx, BOOL *stop) {
        sumEvenNumTotal += [obj integerValue];
    }];
    
    NSInteger lastNumber = [lastNum integerValue];
    
    NSInteger luhmTotal = lastNumber + sumEvenNumTotal + sumOddNum2Total + sumOddNumTotal;
    
    return (luhmTotal%10 ==0) ? YES : NO;
}

/**
 正则ip地址
 */
+ (BOOL)regexWithIPAddess:(NSString *)ipString {
    NSString *regex = [NSString stringWithFormat:@"^(\\d{1,3})\\.(\\d{1,3})\\.(\\d{1,3})\\.(\\d{1,3})$"];
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    BOOL isMatch = [pre evaluateWithObject:ipString];
    
    if (isMatch) {
        NSArray *componds = [ipString componentsSeparatedByString:@","];
        
        BOOL isResult = YES;
        for (NSString *s in componds) {
            if (s.integerValue > 255) {
                isResult = NO;
                break;
            }
        }
        return isResult;
    }
    
    return NO;
}
/**
 正则验证用户名
 */
+(BOOL)regexWithUserName:(NSString *)userName {
    NSString * regex = @"^[A-Za-z0-9]{6,20}$"; // 设定长度 为 6~20位;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:userName];
}


/**
 正则验证昵称
 */
+(BOOL)regexWithNickname:(NSString *)nickname {
    NSString *nicknameRegex = @"^[\u4e00-\u9fa5]{4,8}$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",nicknameRegex];
    return [passWordPredicate evaluateWithObject:nickname];
}
@end
