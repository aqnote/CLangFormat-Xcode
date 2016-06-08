//
//  TRVSFormatter.h
//  ClangFormat
//
//  Created by Travis Jeffery on 1/9/14.
//  Copyright (c) 2014 Travis Jeffery. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class IDESourceCodeDocument;

@interface TRVSFormatter : NSObject

/**
 *  使用的格式化方式, 见TRVSClangFormat styles
 */
@property(nonatomic, copy) NSString *style;

/**
 *  可运行的文件路径，取的插件resource中的clang-format可运行文件
 */
@property(nonatomic, copy) NSString *exec;

/**
 *  是否使用系统中的clang-format可运行文件
 */
@property(nonatomic) BOOL isSysExec;

+ (instancetype)sharedFormatter;

- (instancetype)initWithStyle:(NSString *)style
                         exec:(NSString *)exec
                    isSysExec:(BOOL)isSysExec;

- (void)formatActiveFile;

- (void)formatSelectedCharacters;

- (void)formatSelectedFiles;

- (void)formatDocument:(IDESourceCodeDocument *)document;

@end
