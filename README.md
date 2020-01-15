# Castle Test Cases

This repository contains scripts to showcase Castle via various scenario tests using cURL. 

They are intended to be run with zsh.

## Make the Dependencies Executable

There are several scripts in the `helpers` folder which must be made executable in order to be run as dependencies of the test case scripts:

```
chmod a+x ./helpers/*
```

## Running the Test Cases

First, set your CASTLE_API_SECRET in your local environment:

```
export CASTLE_API_SECRET={your api secret}
```

Run the test cases individually with zsh:

```
zsh ./forgetful_user.sh
```

### Usage of `/helpers` Scripts and Flags

The `authenticate.sh` and `track.sh` scripts in the `helpers` folder have flags that allow specifying event context data:

```
-e  Event Name
-u  User ID
-i  Context IP Address
-b  Context User Agent (b for Browser)
-h  Context Headers
```

Example Use:
```
zsh ./helpers/track.sh -e '$login.failed' -u '1234' -i '11.11.11.11' -b 'Chrome_v1.11' -h '{"Accept": "text/html","Accept-Language":"en-us,en;q=0.5"}'
```