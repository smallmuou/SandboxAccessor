//
//  SandboxAccessor.h
//  SandboxAccessorDemo
//
//  Created by smallmuou on 22/10/2018.
//  Copyright © 2018 smallmuou. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * 沙盒访问器
 *
 * 1. #import "SandboxAccessor.h"
 *
 * 2. [[SandboxAccessor shareAccessor] enable:nil]
 *
 * 3. 电脑连接手机所在网络，访问地址: http://手机IP:28686
 */

@interface SandboxAccessor : NSObject

/** 单例 */
+ (instancetype)shareAccessor;


/**
 * 开启沙盒访问，可通过访问http://本机IP:28686
 *
 * error 错误
 */
- (void)enable:(NSError * __autoreleasing *)error;

/** 关闭沙盒访问 */
- (void)disable;

@end
