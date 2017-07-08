var exec = require('cordova/exec');
var channel = require('cordova/channel');

module.exports = {

    _channels: {},
    createEvent: function(type, data) {
        var event = document.createEvent('Event');
        event.initEvent(type, false, false);
        if (data) {
            for (var i in data) {
                if (data.hasOwnProperty(i)) {
                    event[i] = data[i];
                }
            }
        }
        return event;
    },

    initPrinter: function (success, error) {
        exec(success, error, "IMPPrinterPlugin", "initPrinter", null);
    },

   scanStopPrinters: function (success, error) {
        exec(success, error, "IMPPrinterPlugin", "scanStopPrinters", null);
   },
   
    setWidth: function (index, success, error) { //0: 384, 1: 576
        exec(success, error, "IMPPrinterPlugin", "setWidth", [index]);
    },
        
    printText: function (text, success, error) {
        exec(success, error, "IMPPrinterPlugin", "printText", [text]);
    },

   printTextImage: function (text, success, error) {
        exec(success, error, "IMPPrinterPlugin", "printTextImage", [text]);
   },
   
   printHex: function (text, success, error) {
       exec(success, error, "IMPPrinterPlugin", "printHex", [text]);
   },
   
   printCodeBar: function (index, text, success, error) {
       exec(success, error, "IMPPrinterPlugin", "printCodeBar", [index, text]);
   },
   
   printQrCode: function (text, success, error) {
       exec(success, error, "IMPPrinterPlugin", "printQrCode", [text]);
   },
   
   printTestPaper: function (text, success, error) {
       exec(success, error, "IMPPrinterPlugin", "printTestPaper", [text]);
   },
   
   selfTest: function (success, error) {
       exec(success, error, "IMPPrinterPlugin", "selfTest", null);
   },
   
   setFont: function (index, success, error) { //0:1x, 1:2x, 2:3x, 3:4x
       exec(success, error, "IMPPrinterPlugin", "setFont", [index]);
   },
   
   cutPaper: function (success, error) {
       exec(success, error, "IMPPrinterPlugin", "cutPaper", null);
   },
   
   beep: function (success, error) {
       exec(success, error, "IMPPrinterPlugin", "beep", null);
   },
   
   openCasher: function (success, error) {
       exec(success, error, "IMPPrinterPlugin", "openCasher", null);
   },
    
   fireEvent: function (type, data) {
       var event = this.createEvent( type, data);
       if (event && (event.type in this._channels)) {
               
           this._channels[event.type].fire(event);
       }
   },
               
    scanStartPrinters: function (eventname, f) {
        if (!(eventname in this._channels)) {
            var me = this;
            exec( function() {
                me._channels[eventname] = channel.create(eventname);
                me._channels[eventname].subscribe(f);
                }, function(err)  {
            }, "IMPPrinterPlugin", "scanStartPrinters", [eventname]);
        }
        else {
            exec( function(){this._channels[eventname].subscribe(f);}, function(err){}, "IMPPrinterPlugin", "scanStartPrinters", [eventname]);
            
        }
    },
     
    wifiConnect: function (address, eventname, f) {
       if (!(eventname in this._channels)) {
           var me = this;
           exec( function() {
                me._channels[eventname] = channel.create(eventname);
                me._channels[eventname].subscribe(f);
                }, function(err)  {
            }, "IMPPrinterPlugin", "wifiConnect", [address, eventname]);
       }
       else {
            exec( function(){this._channels[eventname].subscribe(f);}, function(err){}, "IMPPrinterPlugin", "wifiConnect", [address, eventname]);
           
       }
    },
               
    bluetoothConnect: function (index, eventname, f) {
        if (!(eventname in this._channels)) {
            var me = this;
            exec( function() {
                me._channels[eventname] = channel.create(eventname);
                me._channels[eventname].subscribe(f);
                }, function(err)  {
            }, "IMPPrinterPlugin", "bluetoothConnect", [index, eventname]);
        }
        else {
            exec( function(){this._channels[eventname].subscribe(f);}, function(err){}, "IMPPrinterPlugin", "bluetoothConnect", [index, eventname]);
            
        }
    },

       disconnectPrinter: function (eventname, f) {
           if (!(eventname in this._channels)) {
               var me = this;
               exec( function() {
                    me._channels[eventname] = channel.create(eventname);
                    me._channels[eventname].subscribe(f);
                    }, function(err)  {
                    }, "IMPPrinterPlugin", "disconnectPrinter", [eventname]);
           }
           else {
               exec( function(){this._channels[eventname].subscribe(f);}, function(err){}, "IMPPrinterPlugin", "disconnectPrinter", [eventname]);
               
           }
       },
       
    };
