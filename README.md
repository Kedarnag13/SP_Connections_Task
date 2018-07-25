## API Documentation

The API's designed here are for:

  - signing up the user
  - creating connections
  - listing - connections, mutual friends
  - subscribe/unsubscribe for updates

#### Sign Up
Request:
```
EndPoint - https://quiet-scrubland-64639.herokuapp.com/sign_up
Method - POST
Body(as Raw) - {"user": {"email": "enter user email"}}
Content Type - application/json
```
Response:
```
{
    "message": "User created Successfully!",
    "status": 200,
    "success": true
}
```

#### Create Connection (Send friend Request
Request:
```
EndPoint - https://quiet-scrubland-64639.herokuapp.com/create_connection
Method - POST
Body(as Raw) - {"friends": ["sender_email","target_email"] }
Content Type - application/json
```
Response:
```
{
    "success": true
}
```