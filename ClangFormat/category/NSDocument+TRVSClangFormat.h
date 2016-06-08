//
//  NSDocument+TRVSClangFormat.h
//  ClangFormat
//
//  Created by Travis Jeffery on 1/11/14.
//  Copyright (c) 2014 Travis Jeffery. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface NSDocument (TRVSClangFormat)

/**
 *  获取保存时自动格式化标识
 *
 *  @return <#return value description#>
 */
+ (BOOL)trvs_formatOnSave;

/**
 *  设置保存时自动格式化
 *
 *  @param formatOnSave 保存变量
 */
+ (void)trvs_setformatOnSave:(BOOL)formatOnSave;

/**
 *  判断文件是否需要格式化，以文件后缀是不是指定的代码文件为准
 *
 *  @return 是否需要格式化操作，true：需要；false：不需要
 */
- (BOOL)trvs_shouldFormat;

@end
