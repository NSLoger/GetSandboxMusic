//
//  BaseModel.m
//  BluetoothHeadset
//
//  Created by 王刚 on 2018/3/15.
//  Copyright © 2018年 Admin. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel

-(instancetype)initWithDict:(NSMutableDictionary *)dict{
    self = [super init];
    if (self) {
        
    }
    return self;
}

+(instancetype)modelWithDict:(NSMutableDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}

@end
