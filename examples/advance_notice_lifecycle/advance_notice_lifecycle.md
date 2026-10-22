# Advance notice lifecycle

This example creates an advance ship notice for a Shipwire warehouse and, when enabled, cancels it again. Cancellation is off by default, so the receiving is only cancelled when you opt in.

## Prerequisites

- Ballerina Swan Lake 2201.12.0 or later
- A Shipwire account with access to the receivings API
- Create a `Config.toml` in this directory:
  ```toml
  username = "<Shipwire username>"
  password = "<Shipwire password>"
  warehouseId = <Warehouse ID>
  productId = <Product ID>
  quantity = <Quantity>
  cancelAfterCreate = false
  ```

## Run the example

```bash
bal run
```
