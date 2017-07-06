//
//  ViewController.m
//  ZiJiangPrinterDemo
//
//  Created by aduo on 5/30/16.
//
//

#import "IMPPrinterPlugin.h"
#import "PrinterSDK.h"
#import <Cordova/CDVAvailability.h>

@interface IMPPrinterPlugin ()
{
    NSMutableArray* _printerArray;
    NSMutableArray* _printerDataArray;
}
@property (retain)NSString* callbackId;
@property (nonatomic, strong) NSString * eventName;

@end

@implementation IMPPrinterPlugin

-(void)pluginInitialize
{

}

- (void)fireEvent:(NSString *)eventName data:(NSString*)data
{
    NSDictionary *dic = @{@"data":data};
    NSError *error;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:(NSJSONWritingOptions)0 error:&error];
    NSString *jsonDataString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    NSString *func = [NSString stringWithFormat:@"window.impprinter.fireEvent('%@', %@);", eventName, jsonDataString];
    
    [self.commandDelegate evalJs:func];
}

- (void)initPrinter:(CDVInvokedUrlCommand*)command{
    // Do any additional setup after loading the view, typically from a nib.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handlePrinterConnectedNotification:) name:PrinterConnectedNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handlePrinterDisconnectedNotification:) name:PrinterDisconnectedNotification object:nil];
    
    [PrinterSDK defaultPrinterSDK];
    
    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)wifiConnect:(CDVInvokedUrlCommand*)command
{
    _callbackId = command.callbackId;
    
    NSString *address = command.arguments[0];
    _eventName = command.arguments[1];
    
    [[PrinterSDK defaultPrinterSDK] connectIP:address];
    
    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}


- (void)scanStartPrinters:(CDVInvokedUrlCommand*)command
{
    _eventName = command.arguments[0];
    
    /*NSDictionary *dic = @{@"data":@{@"name":@"printer", @"uuid": @"123456"}};
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:(NSJSONWritingOptions)0 error:&error];
    NSString *jsonDataString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    
    NSString *func = [NSString stringWithFormat:@"window.impprinter.fireEvent('%@', %@);", _eventName, jsonDataString];
    
    [self.commandDelegate evalJs:func];*/
    
    if(_printerArray != nil)
       [_printerArray removeAllObjects];
    
    [[PrinterSDK defaultPrinterSDK] scanPrintersWithCompletion:^(Printer* printer)
     {
         if (nil == _printerArray)
         {
             _printerArray = [[NSMutableArray alloc] initWithCapacity:1];
         }
         
         [_printerArray addObject:printer];
         
         NSDictionary *dic = @{@"data":@{@"name":printer.name, @"uuid": printer.UUIDString}};
         NSError *error;
         NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:(NSJSONWritingOptions)0 error:&error];
         NSString *jsonDataString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
         
         
         NSString *func = [NSString stringWithFormat:@"window.impprinter.fireEvent('%@', %@);", _eventName, jsonDataString];
         
         [self.commandDelegate evalJs:func];
         
     }];
    
    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)bluetoothConnect:(CDVInvokedUrlCommand*)command
{
    _callbackId = command.callbackId;
    NSArray *arguments = [command arguments];
    int indexPrinter = [[arguments objectAtIndex:0] intValue];
    _eventName = command.arguments[1];

    Printer* printer = [_printerArray objectAtIndex:indexPrinter];
    [[PrinterSDK defaultPrinterSDK] connectBT:printer];
    
    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}


- (void)scanStopPrinters:(CDVInvokedUrlCommand*)command
{
    [[PrinterSDK defaultPrinterSDK] stopScanPrinters];
    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];

}

- (void)handlePrinterConnectedNotification:(NSNotification*)notification
{
    [self fireEvent:_eventName data:@"Connected"];

}

- (void)handlePrinterDisconnectedNotification:(NSNotification*)notification
{
    [self fireEvent:_eventName data:@"Not Connected"];
}

- (void)disconnectPrinter:(CDVInvokedUrlCommand*)command
{
    [[PrinterSDK defaultPrinterSDK] disconnect];
    NSArray *arguments = [command arguments];
    _eventName = [arguments objectAtIndex:0];
    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];

}

- (void)setWidth:(CDVInvokedUrlCommand*)command
{
    _callbackId = command.callbackId;
    NSArray *arguments = [command arguments];
    int widthType = [[arguments objectAtIndex:0] intValue];

    
    [[PrinterSDK defaultPrinterSDK] setPrintWidth:0 == widthType ? 384 : 576];

    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];

}

- (void)printText:(CDVInvokedUrlCommand*)command
{
    _callbackId = command.callbackId;
    NSArray *arguments = [command arguments];
    NSString *printingText = [arguments objectAtIndex:0];
    
    [[PrinterSDK defaultPrinterSDK] printText:printingText];
    
    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];

}

- (void)printTextImage:(CDVInvokedUrlCommand*)command
{
    _callbackId = command.callbackId;
    NSArray *arguments = [command arguments];
    NSString *printingText = [arguments objectAtIndex:0];
    
    [[PrinterSDK defaultPrinterSDK] printTextImage:printingText];
    
    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];

}

- (void)printHex:(CDVInvokedUrlCommand*)command
{
    _callbackId = command.callbackId;
    NSArray *arguments = [command arguments];
    NSString *printingText = [arguments objectAtIndex:0];
    
    [[PrinterSDK defaultPrinterSDK] sendHex:[printingText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
    
    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];

}

- (void)printCodeBar:(CDVInvokedUrlCommand*)command
{
    /*UIActionSheet* sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel", @"Cancel") destructiveButtonTitle:nil otherButtonTitles:@"UPC-A", @"UPC-E", @"JAN13", @"JAN8", @"CODE39", @"ITF", @"CODABAR", @"CODE93", @"CODE128", nil];
    sheet.tag = 2;
    [sheet showInView:self.view];*/
    _callbackId = command.callbackId;
    NSArray *arguments = [command arguments];
    int barType = [[arguments objectAtIndex:0] intValue];

    NSString *printingText = [arguments objectAtIndex:1];
    
    if (barType >= 9)
    {
        CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];

        return;
    }
    
    [[PrinterSDK defaultPrinterSDK] printCodeBar:[printingText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] type:(CodeBarType)barType];
    
    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];

}

- (void)printQrCode:(CDVInvokedUrlCommand*)command
{
    _callbackId = command.callbackId;
    NSArray *arguments = [command arguments];
    NSString *printingText = [arguments objectAtIndex:0];
    
    [[PrinterSDK defaultPrinterSDK] printQrCode:[printingText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
    
    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];

}

- (void)cutPaper:(CDVInvokedUrlCommand*)command
{
    [[PrinterSDK defaultPrinterSDK] cutPaper];
    
    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];

}

- (void)beep:(CDVInvokedUrlCommand*)command
{
    [[PrinterSDK defaultPrinterSDK] beep];
    
    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];

}

- (void)openCasher:(CDVInvokedUrlCommand*)command
{
    [[PrinterSDK defaultPrinterSDK] openCasher];
    
    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];

}

- (void)setFont:(CDVInvokedUrlCommand*)command
{
    /*UIActionSheet* sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel", @"Cancel") destructiveButtonTitle:nil otherButtonTitles:@"1x", @"2x", @"3x", @"4x", nil];
    sheet.tag = 1;
    [sheet showInView:self.view];*/
    _callbackId = command.callbackId;
    NSArray *arguments = [command arguments];
    int fontSize = [[arguments objectAtIndex:0] intValue];

    if (fontSize >= 4)
    {
        CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];

        return;
    }
    
    
    [[PrinterSDK defaultPrinterSDK] setFontSizeMultiple:fontSize];
    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];

}

- (void)printTestPaper:(CDVInvokedUrlCommand*)command
{
    [[PrinterSDK defaultPrinterSDK] printTestPaper];
    
    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];

}

- (void)selfTest:(CDVInvokedUrlCommand*)command
{
    [[PrinterSDK defaultPrinterSDK] selfTest];
    
    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];

}

@end
