# Hubble Census

A `Census` is the operation of importing data into Hubble.

A `UniverseCensus` is kicked off by a Hubble user and imports data into a Universe.

A `VoterCensus` is started by a Hubble employee and upserts Person data and voter history.
They can also be automatically started via an upload to an S3 bucket.

## Architecture

```txt
 ┌────────┐    ┌────────┐    ┌─────────────┐
 │Raw Data│───▶│ Mapper │─┐  │  Processor  │
 └────────┘    └────────┘ │  │┌───────────┐│
                          │  ││ Operation ││
                          └─▶│└───────────┘│
                             │┌───────────┐│
                             ││ Operation ││
                             │└───────────┘│
                             └─────────────┘
```

A `Mapper` parses raw data from `CensusRow` into a consistent format.

The `Processor` accepts a `Mapper` and controls _what_ needs to happen with the data that's being imported.
It'll then run one or more `Operation` to import the `CensusRow`.
