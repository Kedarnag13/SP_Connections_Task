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

#### Create Connection (Send friend Request)
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

#### Listing all friends for a user
Request:
```
EndPoint - https://quiet-scrubland-64639.herokuapp.com/list_friends_for_a_user
Method - POST
Body(as Raw) - {"email": "enter user email"}
Content Type - application/json
```
Response:
```
{
    "success": true,
    "friends": [
        {
            "id": 2,
            "email": "user email 1",
            "created_at": "2018-07-25T13:15:41.997Z",
            "updated_at": "2018-07-25T13:15:41.997Z"
        },
        {
            "id": 3,
            "email": "user email 2",
            "created_at": "2018-07-25T13:15:44.955Z",
            "updated_at": "2018-07-25T13:15:44.955Z"
        }
    ],
    "count": 2
}
```

#### Mutual Friends
Request:
```
EndPoint - https://quiet-scrubland-64639.herokuapp.com/mutual_friends
Method - POST
Body(as Raw) - {"friends": ["sender_email","target_email"] }
Content Type - application/json
```
Response:
```
{
    "success": true,
    "friends": [
        {
            "id": 2,
            "email": "user email 1",
            "created_at": "2018-07-25T13:15:41.997Z",
            "updated_at": "2018-07-25T13:15:41.997Z"
        }
    ],
    "count": 1
}
```

#### Block updates for an Email Address
Request:
```
EndPoint - https://quiet-scrubland-64639.herokuapp.com/block_updates_for_a_user
Method - POST
Body(as Raw) - {"requestor": "user email 1", "target": "user email 2"}
Content Type - application/json
```
Response:
```
{
    "success": true
}
```

#### Get list of emails who can receive updates
```
EndPoint - https://quiet-scrubland-64639.herokuapp.com/get_list_of_emails_who_can_receive_updates
Method - POST
Body(as Raw) - {"sender": "user email 1", "text": "Hello user email 2"}
Content Type - application/json
```
Response:
```
{
    "success": true,
    "recipients": [
        {
            "id": 3,
            "email": "user email 2",
            "created_at": "2018-07-25T13:15:44.955Z",
            "updated_at": "2018-07-25T13:15:44.955Z"
        }
    ]
}
```