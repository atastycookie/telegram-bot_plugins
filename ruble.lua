function run(msg, matches)
  b = http.request("https://query.yahooapis.com/v1/public/yql?q=select+*+from+yahoo.finance.xchange+where+pair+=+%22USDRUB,EURRUB%22&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys&callback=")
  exchange_rates = json:decode(b)
  print("Yahoo returns", exchange_rates)

  local usd_rate = exchange_rates.query.results.rate[1].Rate
  local usd_str = "1 доллар стоит целых " .. usd_rate .. " рублей!"

  local eur_rate = exchange_rates.query.results.rate[2].Rate
  local eur_str = "а 1 евро стоит целых " .. eur_rate .. " рублей!"

  return usd_str .. '\n' .. eur_str
end

return {
  description = "Ruble to us dollar and euro exchange rates",
  usage = "ок, рубль!",
  patterns = {"^ок, рубль!$"},
  run = run
}

