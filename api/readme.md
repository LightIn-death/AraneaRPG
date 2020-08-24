# API for AraneaRPG
> This is my first API, everything is not perfect, and their is a lot of rework to make

## PHP post based API for my flutter app.

### The basic use of the API is to send a request to the index.php path with the desired post argument. The response will be a JSON message.

> :warning: the post request is composed to the action parameter (in order to tel the API what the reqest is for), et the action's specific parameter. :warning:

| Action | Available Argument | Response |
|:-----:|:-----:|:-----:|
|register| pseudo (str) <br> email (str) <br> password (str) <br> age (int) <br> sex (bool)| User Type + Token|
|login| email (str) <br> password (str) | User Type + Token|
|del_account| pseudo (str) <br>||
|get_random_account| pseudo (str) <br>||
|launch_battle| pseudo (str) <br>||
|get_convs| pseudo (str) <br>||
|get_skills| pseudo (str) <br>||
|add_skill_point| pseudo (str) <br>||
|get_profile| pseudo (str) <br>||
|send_message| pseudo (str) <br>||
|get_messages| pseudo (str) <br>||
|upload_profile_pic| pseudo (str) <br>||
|update_profile| pseudo (str) <br>||


