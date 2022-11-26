package com.example.login


import android.Manifest
import android.app.AlertDialog
import android.bluetooth.BluetoothAdapter
import android.content.Intent
import android.content.ServiceConnection
import android.content.pm.PackageManager
import android.location.LocationManager
import android.os.RemoteException
import android.provider.Settings
import android.util.Log
import android.widget.Toast
import androidx.annotation.NonNull
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import com.google.gson.Gson
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.FlutterPlugin.FlutterPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import org.altbeacon.beacon.*

class MainActivity : FlutterActivity(), FlutterPlugin, MethodCallHandler,
    BeaconConsumer,
    RangeNotifier, MonitorNotifier {

    private val RC_COARSE_LOCATION = 1
    private val REQUEST_ENABLE_BLUETOOTH = 1
    private val DEFAULT_SCAN_PERIOD_MS = 6000L
    private val ALL_BEACONS_REGION = "AllBeaconsRegion"

    private val CHANNEL = "bluetooth_ble"



    private var mBeaconManager: BeaconManager? = null

    private var mRegion: Region? = null


    private var channel: MethodChannel? = null

    var resultChannel: MethodChannel.Result? = null

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        if(resultCode==RC_COARSE_LOCATION) {
            prepareDetection();
        }
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        mBeaconManager =
            BeaconManager.getInstanceForApplication(applicationContext)
        mBeaconManager!!.beaconParsers
            .add(BeaconParser().setBeaconLayout(BeaconParser.EDDYSTONE_UID_LAYOUT))

        val identifiers = ArrayList<Identifier>()

        mRegion = Region(ALL_BEACONS_REGION, identifiers)



        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
            // This method is invoked on the main thread.
                call, result ->
            resultChannel = result
            if (call.method == "getBeacon") {
                if (!isPermissionGranted(Manifest.permission.ACCESS_COARSE_LOCATION)!!) {
                    reqPermission(
                        Manifest.permission.ACCESS_COARSE_LOCATION, RC_COARSE_LOCATION
                    )
                } else {
                    prepareDetection()
                }
            } else {
                result.notImplemented()
            }
        }
    }

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPluginBinding) {



        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "bluetooth_ble")
        channel!!.setMethodCallHandler(this)

        mBeaconManager =
            BeaconManager.getInstanceForApplication(flutterPluginBinding.applicationContext)
        mBeaconManager!!.beaconParsers
            .add(BeaconParser().setBeaconLayout(BeaconParser.EDDYSTONE_UID_LAYOUT))

        val identifiers = ArrayList<Identifier>()

        mRegion = Region(ALL_BEACONS_REGION, identifiers)

    }


    override fun onDetachedFromEngine(binding: FlutterPluginBinding) {
        channel!!.setMethodCallHandler(null)

    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        resultChannel = result
        if (call.method == "getBeacon") {
            if (!isPermissionGranted(Manifest.permission.ACCESS_COARSE_LOCATION)!!) {
                reqPermission(
                    Manifest.permission.ACCESS_COARSE_LOCATION, RC_COARSE_LOCATION
                )
            } else {
                prepareDetection()
            }
        } else {
            result.notImplemented()
        }
    }

    override fun unbindService(conn: ServiceConnection) {
        super.unbindService(conn)
    }

    override fun bindService(service: Intent?, conn: ServiceConnection, flags: Int): Boolean {
        return super.bindService(service, conn, flags)
    }

    override fun onBeaconServiceConnect() {
        mBeaconManager!!.addRangeNotifier(this)
        try {
            mBeaconManager!!.startRangingBeaconsInRegion(mRegion!!)
        } catch (e: RemoteException) {
            e.printStackTrace()
        }
    }

    override fun didRangeBeaconsInRegion(beacons: MutableCollection<Beacon>?, region: Region?) {
        val gson = Gson()
        if (beacons!!.isEmpty()) {
            val beaconSensor = BeaconSensor()
            try {
                mBeaconManager!!.stopMonitoringBeaconsInRegion(mRegion!!)
            } catch (e: RemoteException) {
                e.printStackTrace()
            }
            mBeaconManager!!.removeAllRangeNotifiers()
            if (mBeaconManager!!.isBound(this)) {
                mBeaconManager!!.unbind(this)
            }
            Log.d("---------------",""+gson.toJson(beaconSensor))
            resultChannel!!.success(gson.toJson(beaconSensor))
        } else {
            val beacon = beacons.iterator().next()
            val beaconSensor = BeaconSensor(
                beacon.bluetoothAddress,
                beacon.bluetoothName,
                beacon.distance,
                beacon.id1.toString(),
                beacon.id2.toString()
            )
            val json =
                "{\"bluetoothAddress\":\"" + beacon.bluetoothAddress + "\",\"bluetoothName\":\"" + beacon.bluetoothName + "\",\"nameSpaceId\":\"" + beacon.id1 + "\",\"instanceId\":\"" + beacon.id2 + "\"}"
            try {
                mBeaconManager!!.stopMonitoringBeaconsInRegion(mRegion!!)
            } catch (e: RemoteException) {
                e.printStackTrace()
            }
            mBeaconManager!!.removeAllRangeNotifiers()
            if (mBeaconManager!!.isBound(this)) {
                mBeaconManager!!.unbind(this)
            }
            resultChannel!!.success(json)
        }


    }

    private fun stopDetectingBeacons() {
        try {
            mBeaconManager!!.stopMonitoringBeaconsInRegion(mRegion!!)
        } catch (e: RemoteException) {
            e.printStackTrace()
        }
        mBeaconManager!!.removeAllRangeNotifiers()
        mBeaconManager!!.unbind(this)
    }

    private fun startDetectingBeacons() {
//        mBeaconManager!!.foregroundScanPeriod = DEFAULT_SCAN_PERIOD_MS
        mBeaconManager!!.bind(this)
    }

    private fun isLocationEnabled(): Boolean {
        val lm = activity.getSystemService(LOCATION_SERVICE) as LocationManager
        var networkLocationEnabled = false
        var gpsLocationEnabled = false
        try {
            networkLocationEnabled = lm.isProviderEnabled(LocationManager.NETWORK_PROVIDER)
            gpsLocationEnabled = lm.isProviderEnabled(LocationManager.GPS_PROVIDER)
        } catch (ex: Exception) {
            Log.d("TAG", "Excepción al obtener información de localización")
        }
        return networkLocationEnabled || gpsLocationEnabled
    }

    private fun prepareDetection() {
        if (!isLocationEnabled()) {
            askToTurnOnLocation()
        } else {
            val mBluetoothAdapter = BluetoothAdapter.getDefaultAdapter()
            if (mBluetoothAdapter == null) {

                // Toast.makeText(activity, "Cet appareil ne prend pas en charge le Bluetooth, il n'est pas possible de rechercher des balises", Toast.LENGTH_SHORT).show();
            } else if (mBluetoothAdapter.isEnabled) {
                startDetectingBeacons()
            } else {
                //  Toast.makeText(activity, "Bluetooth", Toast.LENGTH_SHORT).show();
                if (ActivityCompat.checkSelfPermission(
                        this,
                        Manifest.permission.BLUETOOTH_CONNECT
                    ) != PackageManager.PERMISSION_GRANTED
                ) {
                    // TODO: Consider calling
                    //    ActivityCompat#requestPermissions
                    // here to request the missing permissions, and then overriding
                    //   public void onRequestPermissionsResult(int requestCode, String[] permissions,
                    //                                          int[] grantResults)
                    // to handle the case where the user grants the permission. See the documentation
                    // for ActivityCompat#requestPermissions for more details.
                    return
                }
                mBluetoothAdapter.enable()
                startDetectingBeacons()
            }
        }
    }
    private fun askToTurnOnLocation() {

        // Notificar al usuario
        val dialog = AlertDialog.Builder(activity)
        dialog.setMessage("Localisation en mode haute précision non activé")
        dialog.setPositiveButton(
            "Ouvrir les paramètres de localisation"
        ) { paramDialogInterface, paramInt -> // TODO Auto-generated method stub
            val myIntent =
                Intent(Settings.ACTION_LOCATION_SOURCE_SETTINGS)
            activity.startActivity(myIntent)
        }
        dialog.show()
    }


    override fun didEnterRegion(region: Region?) {

    }


    override fun didExitRegion(region: Region?) {

    }


    override fun didDetermineStateForRegion(state: Int, region: Region?) {

    }

    private fun isPermissionGranted(permissionName: String?): Boolean? {
        return ContextCompat.checkSelfPermission(
            activity,
            permissionName!!
        ) == PackageManager.PERMISSION_GRANTED
    }

    private fun reqPermission(permissionName: String, requestCode: Int) {
        ActivityCompat.requestPermissions(activity, arrayOf(permissionName), requestCode)
    }
}
