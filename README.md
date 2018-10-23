# SandboxAccessor

> SandboxAccessor is a lib based on mongoose to access sandbox more easier.

## Startup

```

Step1：import header
#import "SandboxAccessor.h"

Step2: enable
NSError* error = nil;    
[[SandboxAccessor shareAccessor] enable:&error];

if (!error) {
    NSLog(@"SandboxAccessor enabled. You can use web browser to access url: http://myip:28686");
}
```

## Access

* Lookup ip of phone. 
* Connect to wifi which phone connected.
* open web browse, and access url: http://the-phone-ip:28686

## Note

Please add #ifdef __OBJC__  #endif in pch file.

```objc
 #ifdef __OBJC__

 #import ....
 #import ....
 #import ....

 #endif
 ``` 

## LICENCE 

MIT