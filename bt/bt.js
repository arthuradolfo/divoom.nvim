const TIMEBOX_ADDRESS = process.argv[2];
var btSerial = new (require('bluetooth-serial-port')).BluetoothSerialPort();
var Divoom = require('node-divoom-timebox-evo');

btSerial.findSerialPortChannel(TIMEBOX_ADDRESS, function(channel) {
  btSerial.connect(TIMEBOX_ADDRESS, channel, function() {
    console.log('connected');

    setTimeout(function() {
      var d = (new Divoom.TimeboxEvo()).createRequest('picture');
      d.read(process.argv[3]).then(result => {
        result.asBinaryBuffer().forEach(elt => {
          btSerial.write(elt,
            function(err, bytesWritten) {
              console.log(elt)
              if (err) console.log("Some error: " + err);
            });
        });
      }).catch(err => {
        throw err;
      }).then(response => {
        setTimeout(function() { btSerial.close() }, 1000);
      });
    }, 1000);
  }, function () {
    console.log('cannot connect');
  });
}, function() {
  console.log('found nothing');
});




