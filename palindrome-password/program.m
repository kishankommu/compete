#import <Foundation/Foundation.h>

int main(int argc, const char* argv[]){
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    printf("Hello World");
    [pool drain];
    return 0;
}
