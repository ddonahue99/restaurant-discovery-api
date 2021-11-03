# Restaurant Discovery API

* Ruby version: 3.0.2
* Rails version: 6.1.4.1

## Setup

Create .env file (see similar .env.example included in the repo but change credentials)

Add your google maps key to your config/credentials.yml.enc file:


```
docker-compose run web credentials:edit
google_places_api:[YOUR_KEY_HERE]
```

## Build docker

```
docker build -t restaurant-discovery-api .
docker-compose -f docker-compose.yml up --build
docker-compose run web rails db:migrate
docker-compose run web rails db:seed
```

## Use the following User credentials for basic auth:

Email: `paul@arrakis.com`

Password: `gomjabbar`

## API testing
`http://localhost:3000/api/search`

Params:

`keyword` [String]

`location` [Object]

### Examples:

keyword: pizza

location: {"south": "-34.627041", "west": "-58.479310", "north":"-34.625743", "east": "-199.478704"}
