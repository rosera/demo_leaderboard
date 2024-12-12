# Demo Leaderboard 

A quick demo showing how to create a simple in-memory leaderboard.
The demo uses an external endpoint to provide leaderboard information.
To refresh the board, pull down on the list, at which point it will read the endpoint.

## Endpoint

Use a simple [quizzrr in-memory backend](https://github.com/rosera/quizzrr_leaderboard/blob/main/README.md) to manage the handling of the information to be presented.
Optionally this can be extended to use a database as a backend depending on requirements.

The Flutter application expects the information to be presented in the following JSON format:

```json
[
  {"game":"test","name":"Carol","score":300},
  {"game":"test","name":"Bobby","score":200},
  {"game":"test","name":"Abbie","score":100}
]
```

## Basic Leaderboard

The leaderboard will display the information presented by the endpoint as a sorted list.

![leaderboard_main](https://github.com/rosera/demo_leaderboard/blob/main/screenshots/leaderboard-screenshot.png "Mobile App")

## Packages

| Package                  | Description               |
|--------------------------|---------------------------|
| http                     | HTTP access methods       |