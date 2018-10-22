//
//  SandboxAccessor.m
//  SandboxAccessorDemo
//
//  Created by smallmuou on 22/10/2018.
//  Copyright © 2018 smallmuou. All rights reserved.
//

#import "SandboxAccessor.h"
#import "mongoose.h"

@interface SandboxAccessor() {
    struct mg_mgr           _manager;
    struct mg_connection*   _connection;
    BOOL                    _enabled;
}

@property (nonatomic, assign) short port;

@end

@implementation SandboxAccessor

+ (instancetype)shareAccessor {
    static SandboxAccessor* accessor = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        accessor = [[SandboxAccessor alloc] init];
        accessor.port = 28686;
    });
    return accessor;
}

static struct mg_serve_http_opts gSandboxAccessorHttpOptions;

static void requestHandler(struct mg_connection *nc, int ev, void *p) {
    if (ev == MG_EV_HTTP_REQUEST) {
        mg_serve_http(nc, (struct http_message *) p, gSandboxAccessorHttpOptions);
    }
}

- (void)enable:(NSError * __autoreleasing *)error {
    if (_enabled) return;
    _enabled = YES;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        mg_mgr_init(&_manager, NULL);
        NSString* portString = [NSString stringWithFormat:@"%d", self.port];
        
        _connection = mg_bind(&_manager, [portString UTF8String], requestHandler);
        if (_connection == NULL) {
            *error = [[NSError alloc] initWithDomain:@"xyz.smallmuou.SandboxAccessor" code:100 userInfo:@{NSLocalizedDescriptionKey:@"Failed to bind port 28686"}];
            _enabled = NO;
            return;
        }
        
        // Set up HTTP server parameters
        mg_set_protocol_http_websocket(_connection);
        gSandboxAccessorHttpOptions.document_root = [NSHomeDirectory() UTF8String];
        gSandboxAccessorHttpOptions.enable_directory_listing = "yes";
        
        while (_enabled) {
            mg_mgr_poll(&_manager, 1000);
        }
        mg_mgr_free(&_manager);
    });
}

- (void)disable {
    _enabled = NO;
}

@end
