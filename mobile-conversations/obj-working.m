//
//  main.m
//  objectiveCtests
//
//  Created by alok pepakayala on 13/05/15.
//  Copyright (c) 2015 alok pepakayala. All rights reserved.
//

#import <Foundation/Foundation.h>

NSInteger SortCalls(id a,  id b, void* context);

@interface Call : NSObject
@property long long int Price;
@property long long int Recharge;
@property long long int Delta;
- (void) debug;
+ (Call *) makewithPrice:(long long int)pr andRc:(long long int)rc;
@end

@implementation Call
- (void) debug{
    printf("[%lld %lld   %lld]\n",self.Price,self.Recharge,self.Delta);
}
+ (Call*) makewithPrice:(long long int)pr andRc:(long long int)rc{
    Call* temp = [[Call alloc] init];
    temp.Price = pr;
    temp.Recharge = rc;
    temp.Delta = rc - pr;
    return temp;
}
@end


@interface CallList : NSObject;
@property NSMutableArray* Calls;
- (void)addCall:(Call*)cl;
- (void)debug;
- (void)sortByPriceAsc;
- (void)sortByPriceDsc;
- (void)sortByRechargeDsc;
- (long long int)minCostforOrder;
- (long long int)endBalforOrder;
- (long long int)firstOnePrice;
+ (CallList*) create;
@end


@implementation CallList
+ (CallList*)create{
    CallList* tmpCalllist = [[CallList alloc] init];
    NSMutableArray* temp = [NSMutableArray array];
    tmpCalllist.Calls = temp;
    return tmpCalllist;
}
- (void)addCall:(Call*)cl{
    [self.Calls addObject:cl];
}
-(void)debug{
    for (Call* x in self.Calls) {
        [x debug];
    }
}
- (long long int)firstOnePrice{
    if ([self.Calls count] >= 1) {
        return [(Call*)self.Calls[0] Price];
    }else{
        return 0;
    }
}
- (long long int)minCostforOrder{
    long long int minCost = [self firstOnePrice];
    long long int curentBal = minCost;
    long long int extra = 0;

    for (Call* x in self.Calls) {
        if ([x Price] > curentBal) {
            extra = [x Price] - curentBal;
            minCost += extra;
            curentBal += extra;
        }
        curentBal = curentBal + [x Delta];
    }
    return minCost;
}
- (long long int)endBalforOrder{
    long long int minCost = [self firstOnePrice];
    long long int curentBal = minCost;
    long long int extra = 0;
    
    for (Call* x in self.Calls) {
        if ([x Price] > curentBal) {
            extra = [x Price] - curentBal;
            minCost += extra;
            curentBal += extra;
        }
        curentBal = curentBal + [x Delta];
    }
    return curentBal;
}
-(void)sortByPriceAsc{
    self.Calls = (NSMutableArray*)[self.Calls sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
        NSNumber *first = [NSNumber numberWithLongLong:[(Call*)a Price]];
        NSNumber *second = [NSNumber numberWithLongLong:[(Call*)b Price]];
        NSComparisonResult result =  [first compare:second];
        return  result;
    }];
}
-(void)sortByPriceDsc{
    self.Calls = (NSMutableArray*)[self.Calls sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
        NSNumber *first = [NSNumber numberWithLongLong:[(Call*)a Price]];
        NSNumber *second = [NSNumber numberWithLongLong:[(Call*)b Price]];
        NSComparisonResult result =  [second compare:first];
        return  result;
    }];
}
-(void)sortByRechargeDsc{
    self.Calls = (NSMutableArray*)[self.Calls sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
        NSNumber *first = [NSNumber numberWithLongLong:[(Call*)a Recharge]];
        NSNumber *second = [NSNumber numberWithLongLong:[(Call*)b Recharge]];
        NSComparisonResult result =  [second compare:first];
        return  result;
    }];
}
@end

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        long long int N,Ti,Xi,iterate;
        CallList* posCalls = [CallList create];
        CallList* nocCalls = [CallList create];
        CallList* negCalls = [CallList create];
        
        scanf("%lld",&N);
        for (iterate = 1; iterate <= N; iterate++) {
            scanf("%lld %lld",&Ti,&Xi);
            Call* newCall = [Call makewithPrice:Ti andRc:Xi];
            //[newCall debug];
            if([newCall Delta] > 0){
                [posCalls addCall:newCall];
            }else if([newCall Delta] == 0){
                [nocCalls addCall:newCall];
            }else{
                [negCalls addCall:newCall];
            }
        }
        
        [posCalls sortByPriceAsc];
        [nocCalls sortByPriceDsc];
        [negCalls sortByRechargeDsc];
        
        
        printf("POS %lld %lld:\n",[posCalls minCostforOrder],[posCalls endBalforOrder]);
        [posCalls debug];
        
        printf("NOC %lld:\n",[nocCalls firstOnePrice]);
        [nocCalls debug];
        
        printf("NEG %lld %lld:\n",[negCalls minCostforOrder],[negCalls endBalforOrder]);
        [negCalls debug];

        
        if ([posCalls minCostforOrder] == 0) {
            if([nocCalls firstOnePrice] >= [negCalls minCostforOrder]){
                printf("%lld", [nocCalls firstOnePrice]);
            }else{
                printf("%lld", [negCalls minCostforOrder]);
            }
        } else {
            if (([posCalls minCostforOrder] >= [nocCalls firstOnePrice]) && ([posCalls minCostforOrder] >= [negCalls minCostforOrder]) ) {
                printf("%lld", [posCalls minCostforOrder]);
            } else {
                if (([posCalls endBalforOrder] >= [nocCalls firstOnePrice]) && ([posCalls endBalforOrder] >= [negCalls minCostforOrder]) ) {
                    printf("%lld",  [posCalls minCostforOrder]);
                } else {
                    if([nocCalls firstOnePrice] >= [negCalls minCostforOrder]){
                        printf("%lld",  [posCalls minCostforOrder] + ([nocCalls firstOnePrice] - [posCalls endBalforOrder]));
                    }else{
                        printf("%lld", [posCalls minCostforOrder] + ([negCalls minCostforOrder] - [posCalls endBalforOrder]));
                    }
                }
            }
        }
        
        
    }
    
    return 0;
}
