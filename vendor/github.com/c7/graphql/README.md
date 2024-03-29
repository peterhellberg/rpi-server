# graphql

[![Build Status](https://travis-ci.org/c7/graphql.svg?branch=master)](https://travis-ci.org/c7/graphql)
[![Go Report Card](https://goreportcard.com/badge/github.com/c7/graphql?style=flat)](https://goreportcard.com/report/github.com/c7/graphql)
[![GoDoc](https://img.shields.io/badge/godoc-reference-blue.svg?style=flat)](https://godoc.org/github.com/c7/graphql)
[![License Apache](https://img.shields.io/badge/license-Apache-lightgrey.svg?style=flat)](https://github.com/c7/graphql#license-apache)

A GraphQL client with no third party dependencies.

Initial version based on <https://github.com/machinebox/graphql>

## Installation

```
go get github.com/c7/graphql
```

## Usage

```go
package main

import (
	"context"
	"encoding/json"
	"os"

	"github.com/c7/graphql"
)

func main() {
	gql := graphql.NewClient("https://swapi.graph.cool")

	ctx := context.Background()

	req := graphql.NewRequest(`
		query {
		  allStarships(filter: { crew_gt: 5, crew_lt: 10 }, orderBy: crew_ASC) {
		    name
		    crew
		  }
		}
	`)

	var resp struct {
		AllStarships []struct {
			Name string
			Crew int
		}
	}

	if err := gql.Run(ctx, req, &resp); err != nil {
		panic(err)
	}

	json.NewEncoder(os.Stdout).Encode(resp)
}
```

```json
{
  "AllStarships": [
    {
      "Name": "Imperial shuttle",
      "Crew": 6
    },
    {
      "Name": "Rebel transport",
      "Crew": 6
    },
    {
      "Name": "Naboo Royal Starship",
      "Crew": 8
    },
    {
      "Name": "Republic Cruiser",
      "Crew": 9
    }
  ]
}
```

<img src="https://assets.c7.se/svg/viking-gopher.svg" align="right" width="30%" height="300">

## License (Apache)

Copyright 2020 [Code7 Interactive](https://c7.se)

> Licensed under the Apache License, Version 2.0 (the "License");
> you may not use this file except in compliance with the License.
> You may obtain a copy of the License at
>
>   http://www.apache.org/licenses/LICENSE-2.0
>
> Unless required by applicable law or agreed to in writing, software
> distributed under the License is distributed on an "AS IS" BASIS,
> WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
> See the License for the specific language governing permissions and
> limitations under the License.
