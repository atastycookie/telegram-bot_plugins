function run(msg, matches)
  url = "http://fucking-great-advice.ru/api"

  second_match = trim(matches[2])
  if second_match ~= "" then
    url = url .. "/random_by_tag/" .. second_match
  else
    url = url .. "/random"
  end

  if trim(matches[1]) == "цензурный" then
    url = url .. "/censored"
  end

  print("url is " .. url)

  b = http.request(url)
  return cleanup_html(json:decode(b).text)
end

function trim(s)
  return (s:gsub("^%s*(.-)%s*$", "%1"))
end


function cleanup_html(text)
  -- list of strings to replace (the order is important to avoid conflicts)
  local cleaner = {
    { "&nbsp;", " " },
    { "&amp;", "&" }, -- decode ampersands
    { "&#151;", "-" }, -- em dash
    { "&#146;", "'" }, -- right single quote
    { "&#147;", "\"" }, -- left double quote
    { "&#148;", "\"" }, -- right double quote
    { "&#150;", "-" }, -- en dash
    { "&#160;", " " }, -- non-breaking space
    { "<br ?/?>", "\n" }, -- all <br> tags whether terminated or not (<br> <br/> <br />) become new lines
    { "</p>", "\n" }, -- ends of paragraphs become new lines
    { "(%b<>)", "" }, -- all other html elements are completely removed (must be done last)
    { "\r", "\n" }, -- return carriage become new lines
    { "[\n\n]+", "\n" }, -- reduce all multiple new lines with a single new line
    { "^\n*", "" }, -- trim new lines from the start...
    { "\n*$", "" }, -- ... and end
  }

  -- clean html from the string
  for i=1, #cleaner do
    local cleans = cleaner[i]
    text = string.gsub(text, cleans[1], cleans[2])
  end

  return text
end

return {
  description = "Fucking Great Advices",
  usage = "(цензурный) совет (кому)!",
  patterns = {"(.*)совет(.*)!"},
  run = run
}

