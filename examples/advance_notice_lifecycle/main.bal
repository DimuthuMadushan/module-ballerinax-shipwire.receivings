// Creates an advance ship notice and optionally cancels it afterwards.

import ballerina/io;
import ballerinax/shipwire.receivings;

configurable string username = ?;
configurable string password = ?;
configurable int:Signed32 warehouseId = ?;
configurable int productId = ?;
configurable int quantity = ?;
configurable boolean cancelAfterCreate = false;

public function main() returns error? {
    receivings:Client shipwire = check new ({auth: {username, password}});

    receivings:CreateReceivingRequest request = {
        arrangement: {'type: "none"},
        shipFrom: {address1: "1 Main St", city: "Austin", state: "TX", postalCode: "78701", country: "US"},
        options: {warehouseId},
        shipments: {length: 10.5, width: 8.0, weight: 12.0, 'type: "box"},
        items: [{productId, quantity}]
    };
    receivings:CreateReceivingResponse created = check shipwire->createReceiving(request);
    string? location = created.resourceLocation;
    if location is () {
        return error("Shipwire did not return a location for the new receiving");
    }
    io:println("Created receiving: ", location);

    if cancelAfterCreate {
        int slash = location.lastIndexOf("/") ?: -1;
        string id = location.substring(slash + 1);
        receivings:CancelReceivingResponse cancelled = check shipwire->cancelReceiving(id);
        io:println("Cancelled: ", cancelled.message ?: "ok");
    }
}
