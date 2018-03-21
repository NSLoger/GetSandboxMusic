//
//  BaseModel.h
//  BluetoothHeadset
//
//  Created by 王刚 on 2018/3/15.
//  Copyright © 2018年 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseModel : NSObject

//将字典内的复制给申明的响应属性
-(instancetype)initWithDict:(NSMutableDictionary *)dict;
+(instancetype)modelWithDict:(NSMutableDictionary *)dict;

@end
