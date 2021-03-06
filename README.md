[![Build status](https://build.appcenter.ms/v0.1/apps/bc4775f1-1a4d-4676-ad6f-7e038cd690e8/branches/production/badge)](https://appcenter.ms)
[![Build Status](https://app.bitrise.io/app/a1f4dc85786b90d9/status.svg?token=Kf56YdP3hqzjSqVvMnhz2g)](https://app.bitrise.io/app/a1f4dc85786b90d9)
[![Maintainability](https://api.codeclimate.com/v1/badges/0e80a0e7245040297d96/maintainability)](https://codeclimate.com/github/amadeu01/the-movie-db-client/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/0e80a0e7245040297d96/test_coverage)](https://codeclimate.com/github/amadeu01/the-movie-db-client/test_coverage)

# The Movie DB iOS Client

This is a client for [The Movie DB](www.themoviedb.org). It will show the Movies.

The main features of this application are:

1. Show a list of the movies which will be to Premier.
2. When selected, the movie section should show the details about the movie, such as:
    1. Short description
    2. Genre of the movie
    3. Show have the movie cover
    4. The release date.
3. Shoulb be posible to access the movies offline.
4. Should be possible to update the data about the movies
5. Should be possible to search a movie
6. Should be possible to navigate on the list of movies.


## How to run

1. Clone the project

```bash
git clone https://github.com/amadeu01/the-movie-db-client.git the-movie-db-client
cd the-movie-db-client
carthage update --platform iOS
open The\ Movie\ DB\ Client.xcodeproj/
```

2. Run command to generate *Secrets.swift* example

```swift
cd the-movie-db-client
make secrets
```

### Carthage

[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that builds your dependencies and provides you with binary frameworks.

You can install Carthage with [Homebrew](http://brew.sh/) using the following command:

```bash
$ brew update
$ brew install carthage
```

Run `carthage update` to build the frameworks.


### Author

:name_badge: Amadeu Cavalcante Filho

:email: amadeu01@gmail.com 
