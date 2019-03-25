//
//  ViewController.m
//  corebluetooth
//
//  Created by kobayashitakahiro on 2019/03/23.
//  Copyright © 2019 kobayashitakahiro. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<CBPeripheralManagerDelegate>
@end

@implementation ViewController
{
    CBPeripheralManager *_pm;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    _pm = [[CBPeripheralManager alloc] initWithDelegate:self queue:nil]; // nilでmain queue
    


}


- (void)peripheralManagerDidUpdateState:(nonnull CBPeripheralManager *)peripheral {
    NSLog(@"UpdateState = %ld", (long)_pm.state);
    if (_pm.state == CBManagerStatePoweredOn) {
        // serviceの作成
        CBUUID *characteristicUUID = [CBUUID UUIDWithString:@"0AD8449D-7E12-491F-A10E-76B4E9F7F395"];
        CBUUID *characteristicUUID2 = [CBUUID UUIDWithString:@"AEE6A08E-2ECC-4668-8FA3-9E610C07FDED"];

        CBCharacteristicProperties cp = (CBCharacteristicPropertyRead | CBCharacteristicPropertyWrite | CBCharacteristicPropertyNotify);
        CBAttributePermissions permissions = (CBAttributePermissionsReadable | CBAttributePermissionsWriteable);

        CBCharacteristic *_chara = [[CBMutableCharacteristic alloc]
                                    initWithType:characteristicUUID
                                    properties:cp
                                    value:nil
                                    permissions:permissions];
        
        CBCharacteristic *_chara2 = [[CBMutableCharacteristic alloc]
                                    initWithType:characteristicUUID2
                                    properties:cp
                                    value:nil
                                    permissions:permissions];
        CBUUID *serviceId = [CBUUID UUIDWithString:@"39F8D962-30EA-45BC-9CA2-A0DB2658F083"];
        CBMutableService *_service = [[CBMutableService alloc]
                                      initWithType:serviceId
                                      primary:YES];
        _service.characteristics = @[_chara, _chara2];
        
        [_pm addService:_service];
        
#if 0
        NSUUID *uuid = [[NSUUID alloc] initWithUUIDString:@"39F8D962-30EA-45BC-9CA2-A0DB2658F083"];
        
        CLBeaconRegion *bb = [[CLBeaconRegion alloc] initWithProximityUUID:uuid
                                                                     major:1
                              minor:1
                                                                identifier:@"koba"];
        NSMutableDictionary *peripheralData = [bb peripheralDataWithMeasuredPower:nil];
#endif
        CBUUID *serviceId2 = [CBUUID UUIDWithString:@"E925AD98-C023-4CB0-B145-A48046A80CDF"];
        NSDictionary *dic = @{
                              CBAdvertisementDataLocalNameKey:@"sunset",
                              CBAdvertisementDataServiceUUIDsKey:@[serviceId2],
                              
                              
                              
                              };
        [_pm startAdvertising:dic];
    }
}

- (void)peripheralManagerDidStartAdvertising:(CBPeripheralManager *)peripheral
                                       error:(NSError *)error
{
    NSLog(@"Done advertise %@", peripheral);
    if (error) {
        NSLog(@"error code = %ld", error.code);
    }
}

- (void)peripheralManager:(CBPeripheralManager *)peripheral
            didAddService:(CBService *)service
                    error:(NSError *)error
{
    if (error) {
        NSLog(@"サービス追加失敗！ error:%@", error);
        return;
    }
    
    NSLog(@"サービス追加成功！ service:%@", service);
}

- (void)peripheralManager:(CBPeripheralManager *)peripheral
    didReceiveReadRequest:(CBATTRequest *)request
{
    
    NSLog(@"didReceiveReadRequest");
    NSLog(@"request = %@", request);
    
    char a[2560] = "ABCDEFGHIJKLMNOPQRSTABCDEFGHIJKLMNOPQRSTABCDEFGHIJKLMNOPQRSTABCDEFGHIJKLMNOPQRSTABCDEFGHIJKLMNOPQRSTABCDEFGHIJKLMNOPQRSTABCDEFGHIJKLMNOPQRSTABCDEFGHIJKLMNOPQRSTABCDEFGHIJKLMNOPQRSTABCDEFGHIJKLMNOPQRSTABCDEFGHIJKLMNOPQRSTABCDEFGHIJKLMNOPQRSTABCDEFGHIJKLMNOPQRSTABCDEFGHIJKLMNOPQRSTABCDEFGHIJKLMNOPQRSTABCDEFGHIJKLMNOPQRSTABCDEFGHIJKLMNOPQRSTABCDEFGHIJKLMNOPQRSTABCDEFGHIJKLMNOPQRSTABCDEFGHIJKLMNOPQRSTABCDEFGHIJKLMNOPQRSTABCDEFGHIJKLMNOPQRSTABCDEFGHIJKLMNOPQRSTABCDEFGHIJKLMNOPQRSTABCDEFGHIJKLMNOPQRSTABCDEFGHIJKLMNOPQRSTABCDEFGHIJKLMNOPQRSTABCDEFGHIJKLMNOPQRSTABCDEFGHIJKLMNOPQRSTABCDEFGHIJKLMNOPQRSTABCDEFGHIJKLMNOPQRSTABCDEFGHIJKLMNOPQRSTABCDEFGHIJKLMNOPQRSTABCDEFGHIJKLMNOPQRSTABCDEFGHIJKLMNOPQRSTABCDEFGHIJKLMNOPQRSTABCDEFGHIJKLMNOPQRSTABCDEFGHIJKLMNOPQRSTABCDEFGHIJKLMNOPQRSTABCDEFGHIJKLMNOPQRSTABCDEFGHIJKLMNOPQRSTABCDEFGHIJKLMNOPQRSTABCDEFGHIJKLMNOPQRSTABCDEFGHIJKLMNOPQRSTABCDEFGHIJKLMNOPQRSTABCDEFGHIJKLMNOPQRSTABCDEFGHIJKLMNOPQRSTABCDEFGHIJKLMNOPQRSTABCDEFGHIJKLMNOPQRSTABCDEFGHIJKLMNOPQRSTABCDEFGHIJKLMNOPQRSTABCDEFGHIJKLMNOPQRSTABCDEFGHIJKLMNOPQRSTABCDEFGHIJKLMNOPQRSTABCDEFGHIJKLMNOPQRSTABCDEFGHIJKLMNOPQRSTABCDEFGHIJKLMNOPQRSTABCDEFGHIJKLMNOPQRSTABCDEFGHIJKLMNOPQRSTABCDEFGHIJKLMNOPQRSTABCDEFGHIJKLMNOPQRSTABCDEFGHIJKLMNOPQRSTABCDEFGHIJKLMNOPQRSTABCDEFGHIJKLMNOPQRSTABCDEFGHIJKLMNOPQRSTABCDEFGHIJKLMNOPQRSTABCDEFGHIJKLMNOPQRSTABCDEFGHIJKLMNOPQRSTABCDEFGHIJKLMNOPQRSTABCDEFGHIJKLMNOPQRSTABCDEFGHIJKLMNOPQRSTABCDEFGHIJKLMNOPQRSTABCDEFGHIJKLMNOPQRSTABCDEFGHIJKLMNOPQRSTABCDEFGHIJKLMNOPQRSTABCDEFGHIJKLMNOPQRSTABCDEFGHIJKLMNOPQRSTABCDEFGHIJKLMNOPQRSTABCDEFGHIJKLMNOPQRSTABCDEFGHIJKLMNOPQRSTABCDEFGHIJKLMNOPQRSTABCDEFGHIJKLMNOPQRSTABCDEFGHIJKLMNOPQRSTABCDEFGHIJKLMNOPQRSTABCDEFGHIJKLMNOPQRSTABCDEFGHIJKLMNOPQRSTABCDEFGHIJKLMNOPQRSTABCDEFGHIJKLMNOPQRSTABCDEFGHIJKLMNOPQRSTABCDEFGHIJKLMNOPQRSTABCDEFGHIJKLMNOPQRSTABCDEFGHIJKLMNOPQRSTABCDEFGHIJKLMNOPQRSTABCDEFGHIJKLMNOPQRSTABCDEFGHIJKLMNOPQRSTABCDEFGHIJKLMNOPQRSTABCDEFGHIJKLMNOPQRSTABCDEFGHIJKLMNOPQRSTABCDEFGHIJKLMNOPQRSTABCDEFGHIJKLMNOPQRSTABCDEFGHIJKLMNOPQRSTABCDEFGHIJKLMNOPQRSTABCDEFGHIJKLMNOPQRSTABCDEFGHIJKLMNOPQRSTABCDEFGHIJKLMNOPQRSTABCDEFGHIJKLMNOPQRSTABCDEFGHIJKLMNOPQRSTABCDEFGHIJKLMNOPQRSTABCDEFGHIJKLMNOPQRSTABCDEFGHIJKLMNOPQRSTABCDEFGHIJKLMNOPQRSTABCDEFGHIJKLMNOPQRSTABCDEFGHIJKLMNOPQRSTABCDEFGHIJKLMNOPQRSTABCDEFGHIJKLMNOPQRSTABCDEFGHIJKLMNOPQRSTABCDEFGHIJKLMNOPQRSTABCDEFGHIJKLMNOPQRSTABCDEFGHIJKLMNOPQRSTABCDEFGHIJKLMNOPQRSTABCDEFGHIJKLMNOPQRSTABCDEFGHIJKLMNOPQRSTABCDEFGHIJKLMNOPQRSTABCDEFGHIJKLMNOPQRSTABCDEFGHIJKLMNOPQRSTABCDEFGHIJKLMNOPQRSTABCDEFGHIJKLMNOPQRSTABCDEFGHIJKLMNOPQRST";
    request.value = [[NSData alloc] initWithBytes:&a length:sizeof(a)];
    [_pm respondToRequest:request withResult:CBATTErrorSuccess];
    
}
@end
