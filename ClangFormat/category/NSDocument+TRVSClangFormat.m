//
//  NSDocument+TRVSClangFormat.m
//  ClangFormat
//
//  Created by Travis Jeffery on 1/11/14.
//  Copyright (c) 2014 Travis Jeffery. All rights reserved.
//

#import <objc/runtime.h>
#import "NSDocument+TRVSClangFormat.h"
#import "TRVSFormatter.h"
#import "TRVSXcode.h"

static BOOL trvs_formatOnSave;

@implementation NSDocument (TRVSClangFormat)

- (void)trvs_saveDocumentWithDelegate:(id)delegate
                      didSaveSelector:(SEL)didSaveSelector
                          contextInfo:(void *)contextInfo {
  if ([self trvs_shouldFormatBeforeSaving])
    [[TRVSFormatter sharedFormatter]
        formatDocument:(IDESourceCodeDocument *)self];

  // 调用 saveDocumentWithDelegate:didSaveSelector:contextInfo:
  [self trvs_saveDocumentWithDelegate:delegate
                      didSaveSelector:didSaveSelector
                          contextInfo:contextInfo];
}

/**
 *  在class加载时交换两个方法的实现
 */
+ (void)load {
  SEL orginalSEL =
      @selector(saveDocumentWithDelegate:didSaveSelector:contextInfo:);
  Method original = class_getInstanceMethod(self, orginalSEL);

  SEL swizzleSEL =
      @selector(trvs_saveDocumentWithDelegate:didSaveSelector:contextInfo:);
  Method swizzle = class_getInstanceMethod(self, swizzleSEL);

  method_exchangeImplementations(original, swizzle);
}

+ (void)trvs_setformatOnSave:(BOOL)formatOnSave {
  trvs_formatOnSave = formatOnSave;
}

+ (BOOL)trvs_formatOnSave {
  return trvs_formatOnSave;
}

- (BOOL)trvs_shouldFormatBeforeSaving {
  return [[self class] trvs_formatOnSave] && [self trvs_shouldFormat] &&
         [TRVSXcode sourceCodeDocument] == self;
}

- (BOOL)trvs_shouldFormat {
  return
      [[NSSet setWithObjects:@"c", @"h", @"cpp", @"cc", @"cxx", @"hh", @"hpp",
                             @"hxx", @"ipp", @"m", @"mm", @"metal", nil]
          containsObject:[[[self fileURL] pathExtension] lowercaseString]];
}

@end
