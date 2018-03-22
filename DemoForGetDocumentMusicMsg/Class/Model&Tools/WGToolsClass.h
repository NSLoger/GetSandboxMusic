//
//  WGToolsClass.h
//  HeadPhone
//
//  Created by 王刚 on 2018/3/14.
//  Copyright © 2018年 iOS-iMac. All rights reserved.
//
//                                吃蘑菇变大
//                               ==========
//                            //·           \\
//                         //·····           ··\\
//                      //········          ······\\
//                   //···········           ········\\
//                //  ···········    ·····     ····     \\
//             //       ·······    ·········               \\
//            ((                  ···········               ))
//             ==============================================
//                         //                  \\
//                        //   -            -   \\
//                       //   ( )          ( )   \\
//                      //     -            -     \\
//                     //           ----           \\
//                    ((____________________________))
//

#import <Foundation/Foundation.h>

@interface WGToolsClass : NSObject

/**
 * @brief                   获取本地音乐列表信息
 * @return                  本地音乐列表信息
 */
+(NSArray *)getLocalMusicListMsg;

/**
 * @brief                   获取存在沙盒种的音乐
 */
+(NSArray *)getDucumentMusicListMsg;

/**
* @brief                    获取APP中自带的音乐文件的相关信息
 */
+(NSArray *)getApplicationMusicListMsg;

@end
