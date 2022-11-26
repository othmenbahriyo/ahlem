package com.example.login;

public class BeaconSensor {
    private String bluetoothAddress;
    private String bluetoothName;
    private double distance;
    private String nameSpaceId;
    private String instanceId;

    public String getBluetoothAddress() {
        return bluetoothAddress;
    }

    public void setBluetoothAddress(String bluetoothAddress) {
        this.bluetoothAddress = bluetoothAddress;
    }

    public String getBluetoothName() {
        return bluetoothName;
    }

    public void setBluetoothName(String bluetoothName) {
        this.bluetoothName = bluetoothName;
    }

    public double getDistance() {
        return distance;
    }

    public void setDistance(double distance) {
        this.distance = distance;
    }

    public String getNameSpaceId() {
        return nameSpaceId;
    }

    public void setNameSpaceId(String nameSpaceId) {
        this.nameSpaceId = nameSpaceId;
    }

    public String getInstanceId() {
        return instanceId;
    }

    public void setInstanceId(String instanceId) {
        this.instanceId = instanceId;
    }

    public BeaconSensor() {
    }

    public BeaconSensor(String bluetoothAddress, String bluetoothName, double distance, String nameSpaceId, String instanceId) {
        this.bluetoothAddress = bluetoothAddress;
        this.bluetoothName = bluetoothName;
        this.distance = distance;
        this.nameSpaceId = nameSpaceId;
        this.instanceId = instanceId;
    }

//    @Override
//    public String toString() {
//        return new GsonBuilder().create().toJson(this, BeaconSensor.class);
//    }

}
