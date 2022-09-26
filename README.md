
# File-Based NoSQL CLI tool In Ruby

This tool makes use of JSON structure to store a record.
I will give you a walk-through with an example for familiarising its functionalities.

## Introduction
Executables for this tool are located in the  `bin`  directory .
You have to pass the commands along with the required arguments for performing every operation.

When you execute with or without any `commands`, it creates a *db.json* file in the present working directory with the following scaffold.

```
{
	"collections": {}
}
```

## Collections

Collections are similar to tables. 
Users can store multiple collections in a database.
Each collection is an array of records (key-value pairs).
We need to create a collection and specify the collection while adding the records.
All the operations implemented here are mostly on collections.

### Creating a collection

`.bin/cli collection collection_name`, creates a collection with the specified name.

If you run `./bin/cli collection Users`, *db.json* will be like this

```
{
  "collections": {
    "Users": [

    ]
  }
}
```

### Adding Records into the Specified Collection

`./bin/cli create collection_name valid_json_in_single_quotes `, adds key-value pairs into a collection that exist.

You can also pass multiple key-value pairs like shown in below.

If you run `./bin/cli create Users '{"name":"Sanjay", "username":"sanjaii", "age": "25"}' '{"name":"Uday", "username":"uday123", "age": "23"}'`,  it will produce *db.json* like this

```json
{
  "collections": {
    "Users": [
      {
        "name": "Sanjay",
        "username": "sanjaii",
        "age": "25"
      },
      {
        "name": "Uday",
        "username": "uday123",
        "age": "23"
      }
    ]
  }
}
```

### Search for a value in a collection

`./bin/cli search collection_name value`, returns an array of records contains the given value.

If you run `./bin/cli search Users Sanjay`, It gives back all the records containing the value `Sanjay`

```ruby
	[{"name"=>"Sanjay", "username"=>"sanjaii", "age"=>"25"}]
```

### Select records from a collection

`./bin/cli select collection_name name username`, output all the records which contain the particular keys

If you run `./bin/cli select Users name username`, it produces the following output

```ruby
[{"name"=>"Uday", "username"=>"uday123"}, {"name"=>"Sanjay", "username"=>"sanjaii"}]
 ```

### Destroy records from a collection

`./bin/cli destroy collection_name key value`, delete all the records containing the given key-value pair.

If you run `./bin/cli destroy Users name Sanjay`, it will result in output similar to this:

```
I, [2022-09-26T11:54:55.541645 #98815]  INFO -- : Deleted all the records with key:name and value:Sanjay if there any
I, [2022-09-26T11:54:55.541705 #98815]  INFO -- : Updated collection: [
  {
    "name": "Uday",
    "username": "uday123",
    "age": "23"
  }
]
```
