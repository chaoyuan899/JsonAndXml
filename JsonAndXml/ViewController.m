//
//  ViewController.m
//  JsonAndXml
//
//  Created by aaron on 14-5-30.
//  Copyright (c) 2014年 The Technology Studio. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
{
    NSMutableDictionary *_dictionary;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _dictionary = [[NSMutableDictionary alloc] init];
    [_dictionary setValue:@"Anthony" forKey:@"First Name"];
    [_dictionary setValue:@"Robbins" forKey:@"Last Name"];
    [_dictionary setValue:[NSNumber numberWithUnsignedInteger:51] forKey:@"Age"];
    NSArray *arrayOfAnthonysChildren = [[NSArray alloc] initWithObjects:
                                        @"Anthony's Son 1",
                                        @"Anthony's Daughter 1",
                                        @"Anthony's Son 2",
                                        @"Anthony's Son 3",
                                        @"Anthony's Daughter 2",
                                        nil];
    [_dictionary setValue:arrayOfAnthonysChildren forKey:@"children"];
    
    
}

-(void)jsonToDictionaryOrArray{
   
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:_dictionary options:NSJSONWritingPrettyPrinted error:&error];
    
    if ([jsonData length] > 0 && error == nil) {
        NSLog(@"Successfully serizlized the dictionary into data = %@",jsonData);
        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        NSLog(@"JSON String = %@",jsonString);
    }else if ([jsonData length] == 0 && error == nil){
        NSLog(@"No data was returned after serialization.");
    }else if (error != nil){
        NSLog(@"An error happened = %@",error);
    }

    
}



-(void)dictionaryOrArrayToJson{
    
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:_dictionary options:NSJSONWritingPrettyPrinted error:&error];
    
    if ([jsonData length] > 0 && error == nil) {
        NSLog(@"Successfully serialized the dictionary into data.");
        
        //now try to deserialize the JSON object into a dictionary
        error = nil;
        id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&error];
        if (jsonData != nil && error == nil) {
            NSLog(@"Successfully deserialized...");
            if ([jsonObject isKindOfClass:[NSDictionary class]]) {
                NSDictionary *deserializedDictionary = (NSDictionary*)jsonObject;
                NSLog(@"Deserialized JSON Dictionary = %@",deserializedDictionary);
            }else if ([jsonObject isKindOfClass:[NSArray class]]){
                NSArray *deserializedArray = (NSArray*)jsonObject;
                NSLog(@"Deserialized JSON Array = %@",deserializedArray);
            }else{
                
            }
        }else if(error != nil){
            NSLog(@"An error happened while deserializing the JSON data.");
        }
    }else if ([jsonData length] == 0 && error == nil){
        NSLog(@"No data was returned after serialization");
    }else if (error != nil){
        NSLog(@"An error happened = %@",error);
    }
}

@end
