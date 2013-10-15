//
//  NLBindingFilesystem.m
//  NodelikeDemo
//
//  Created by Sam Rijs on 10/13/13.
//  Copyright (c) 2013 Sam Rijs. All rights reserved.
//

#import "NLBindingFilesystem.h"

#import "uv.h"

@implementation NLBindingFilesystem

- (id)init {

    self = [super init];

    NSLog(@"libuv version: %s", uv_version_string());

    _Stats = [JSValue valueWithNewObjectInContext:[JSContext currentContext]];
    _Stats[@"prototype"] = [JSValue valueWithNewObjectInContext:[JSContext currentContext]];

    return self;

}

- (id)binding {
    return self;
}

- (id)open:(NSString *)path withFlags:(NSNumber *)flags andMode:(NSNumber *)mode andCallback:(JSValue *)cb {
    uv_fs_t *req = malloc(sizeof(uv_fs_t));
    int error = uv_fs_open(uv_default_loop(), req,
                           [path cStringUsingEncoding:NSUTF8StringEncoding],
                           [flags intValue], [mode intValue], nil);
    NSLog(@"%@", cb);
    if (![cb isUndefined]) {
        [cb callWithArguments:@[[NSNumber numberWithInt:error]]];
        return nil;
    }
    
    return [NSNumber numberWithInt:error];
}

@end
