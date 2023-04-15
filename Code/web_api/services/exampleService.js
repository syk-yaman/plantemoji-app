//Import other services within this app
import {InfluxDB} from '@influxdata/influxdb-client'
import {url, token, org} from '../env.mjs'

const queryApi = new InfluxDB({url, token}).getQueryApi(org)
const fluxQuery =
  'from(bucket:"my-bucket") |> range(start: -1d) |> filter(fn: (r) => r._measurement == "temperature")'

export default async function getExample(){

    collectRows();

    return "test";
}

async function collectRows() {
    console.log('\n*** CollectRows ***')
    const data = await queryApi.collectRows(
      fluxQuery //, you can also specify a row mapper as a second argument
    )
    data.forEach((x) => console.log(JSON.stringify(x)))
    console.log('\nCollect ROWS SUCCESS')
  }