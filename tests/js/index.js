/*
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements.  See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership.  The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance https://i.diawi.com/gc87tE
 * with the License.  You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied.  See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */
var app = {
    // Application Constructor
    initialize: function() {
        document.addEventListener('deviceready', this.onDeviceReady.bind(this), false);
    },

    // deviceready Event Handler
    //
    // Bind any cordova events here. Common events are:
    // 'pause', 'resume', etc.
    onDeviceReady: function() {
        window.impprinter.initPrinter(function(data){
            alert("init printer success");
        },
        function errorHandler(err){
            console.log(err);
        });

        var initPrinter = document.getElementById('initPrinter');
        
        var scanStartPrinters = document.getElementById('scanStartPrinters');
        var scanStopPrinters = document.getElementById('scanStopPrinters');
        var wifiConnect = document.getElementById('wifiConnect');
        var bluetoothConnect = document.getElementById('bluetoothConnect');
        var disconnectPrinter = document.getElementById('disconnectPrinter');
        var setWidth = document.getElementById('setWidth');
        var printText = document.getElementById('printText');
        var printTextImage = document.getElementById('printTextImage');
        var printHex = document.getElementById('printHex');
        var printCodeBar = document.getElementById('printCodeBar');
        var printQrCode = document.getElementById('printQrCode');
        var printTestPaper = document.getElementById('printTestPaper');
        var selfTest = document.getElementById('selfTest');
        var setFont = document.getElementById('setFont');
        var cutPaper = document.getElementById('cutPaper');
        var beep = document.getElementById('beep');
        var openCasher = document.getElementById('openCasher');
        
        scanStopPrinters.addEventListener('click', function() {
              window.impprinter.scanStopPrinters(function(data){
                 alert("Stop scan printer");

            });
        });
        
        setWidth.addEventListener('click', function() {
            window.impprinter.setWidth(0, function(data){
                alert("setWidth success");
            },
            function errorHandler(err){
                console.log(err);
                alert(JSON.stringify(err));

            });
        });
        
        printText.addEventListener('click', function() {
            window.impprinter.printText('Hello, IMPPrinter', function(data){
                alert("printText success");
                                        document.getElementById("camera_list").innerHTML = JSON.stringify(data);

            },
            function errorHandler(err){
                console.log(err);
               alert(JSON.stringify(err));
            });
        });
        
        printTextImage.addEventListener('click', function() {
            window.impprinter.printTextImage('Hello, IMPPrinter', function(data){
            alert("printTextImage success");
            },
            function errorHandler(err){
            console.log(err);
            alert(JSON.stringify(err));
            });
        });

        printHex.addEventListener('click', function() {
            window.impprinter.printHex('Hello, IMPPrinter', function(data){
            alert("printHex success");
                                       document.getElementById("camera_list").innerHTML = JSON.stringify(data);

            },
            function errorHandler(err){
            console.log(err);
            alert(JSON.stringify(err));
            });
        });

        printCodeBar.addEventListener('click', function() {
            window.impprinter.printCodeBar(1, 'Hello, IMPPrinter', function(data){
            alert("printCodeBar success");
                                           document.getElementById("camera_list").innerHTML = JSON.stringify(data);

            },
            function errorHandler(err){
            console.log(err);
            alert(JSON.stringify(err));
            });
        });

        printQrCode.addEventListener('click', function() {
            window.impprinter.printQrCode('Hello, IMPPrinter', function(data){
            alert("printQrCode success");
                                          document.getElementById("camera_list").innerHTML = JSON.stringify(data);

            },
            function errorHandler(err){
            console.log(err);
            alert(JSON.stringify(err));
            });
        });

        printTestPaper.addEventListener('click', function() {
            window.impprinter.printTestPaper('Hello, IMPPrinter', function(data){
            alert("printTestPaper success");
                                             document.getElementById("camera_list").innerHTML = JSON.stringify(data);

            },
            function errorHandler(err){
            console.log(err);
            alert(JSON.stringify(err));
            });
        });

        selfTest.addEventListener('click', function() {
            window.impprinter.selfTest(function(data){
            alert("selfTest success");
                                       document.getElementById("camera_list").innerHTML = JSON.stringify(data);

            },
            function errorHandler(err){
            console.log(err);
            alert(JSON.stringify(err));
            });
        });

        setFont.addEventListener('click', function() {
            window.impprinter.setFont(0, function(data){
            alert("setFont success");
                                      document.getElementById("camera_list").innerHTML = JSON.stringify(data);

            },
            function errorHandler(err){
            console.log(err);
            alert(JSON.stringify(err));
            });
        });

        cutPaper.addEventListener('click', function() {
            window.impprinter.cutPaper(function(data){
            alert("cutPaper success");
                                       document.getElementById("camera_list").innerHTML = JSON.stringify(data);

            },
            function errorHandler(err){
            console.log(err);
            alert(JSON.stringify(err));
            });
        });

        beep.addEventListener('click', function() {
            window.impprinter.beep(function(data){
            alert("beep success");
                                   document.getElementById("camera_list").innerHTML = JSON.stringify(data);

            },
            function errorHandler(err){
            console.log(err);
            alert(JSON.stringify(err));
            });
        });

        openCasher.addEventListener('click', function() {
            window.impprinter.openCasher(function(data){
            alert("openCasher success");
                                         document.getElementById("camera_list").innerHTML = JSON.stringify(data);

            },
            function errorHandler(err){
            console.log(err);
            alert(JSON.stringify(err));
            });
        });

        wifiConnect.addEventListener('click', function() {
            window.impprinter.wifiConnect('192.168.100.1', 'wificonnect', function(data){
                document.getElementById("camera_list").innerHTML = JSON.stringify(data);
            },
            function errorHandler(err){
            console.log(err);
            alert(JSON.stringify(err));
            });
        });

        bluetoothConnect.addEventListener('click', function() {
            window.impprinter.bluetoothConnect(0, 'bluetoothconnect', function(data){
                document.getElementById("camera_list").innerHTML = JSON.stringify(data);
            },
            function errorHandler(err){
            console.log(err);
            alert(JSON.stringify(err));
            });
        });

        disconnectPrinter.addEventListener('click', function() {
            window.impprinter.disconnectPrinter('disconnect', function(data){
                    document.getElementById("camera_list").innerHTML = JSON.stringify(data);
                              
            },
            function errorHandler(err){
                console.log(err);
                alert(JSON.stringify(err));
            });
        });

        scanStartPrinters.addEventListener('click', function() {
            document.getElementById("camera_list").innerHTML = "";
                                           
            window.impprinter.scanStartPrinters('scanstart',function(data){
                document.getElementById("camera_list").insertAdjacentHTML('beforeend',JSON.stringify(data));
            },
            function errorHandler(err){
                console.log(err);
                alert(JSON.stringify(err));

            });
        });

    },

    // Update DOM on a Received Event
    receivedEvent: function(id) {
        
    }
};

app.initialize();
