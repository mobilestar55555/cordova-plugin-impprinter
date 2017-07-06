//
//  ViewController.h
//  ZiJiangPrinterDemo
//
//  Created by aduo on 5/30/16.
//
//

#import <Cordova/CDVPlugin.h>
#import "PrinterSDK.h"

@interface IMPPrinterPlugin : CDVPlugin
- (void)initPrinter:(CDVInvokedUrlCommand*)command;

- (void)wifiConnect:(CDVInvokedUrlCommand*)command;

- (void)disconnectPrinter:(CDVInvokedUrlCommand*)command;

- (void)scanStartPrinters:(CDVInvokedUrlCommand*)command;
- (void)bluetoothConnect:(CDVInvokedUrlCommand*)command;

- (void)scanStopPrinters:(CDVInvokedUrlCommand*)command;


- (void)setWidth:(CDVInvokedUrlCommand*)command;

- (void)printText:(CDVInvokedUrlCommand*)command;
- (void)printTextImage:(CDVInvokedUrlCommand*)command;
- (void)printHex:(CDVInvokedUrlCommand*)command;
- (void)printCodeBar:(CDVInvokedUrlCommand*)command;
- (void)printQrCode:(CDVInvokedUrlCommand*)command;

- (void)printTestPaper:(CDVInvokedUrlCommand*)command;
- (void)selfTest:(CDVInvokedUrlCommand*)command;

- (void)setFont:(CDVInvokedUrlCommand*)command;

- (void)cutPaper:(CDVInvokedUrlCommand*)command;
- (void)beep:(CDVInvokedUrlCommand*)command;
- (void)openCasher:(CDVInvokedUrlCommand*)command;

@end

