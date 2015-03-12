function shuffleArray(array)
  randseed = os.time()
  math.randomseed(randseed)
  local arrayCount = #array
  for i = arrayCount, 2, -1 do
    local j = math.random(1, i)
    array[i], array[j] = array[j], array[i]
  end
  return array
end

local intro_words = {
  "Безусловно ",
  "Вероятно, ",
  "Видимо, ",
  "Все-таки, ",
  "Думается, ",
  "Кажется, ",
  "Конечно, ",
  "Наверное, ",
  "Непременно ",
  "Несомненно, ",
  "Очевидно, ",
  "Разумеется, ",
  "Скорее всего, "
}

function run(msg, matches)
  intro = shuffleArray(intro_words)
  choice = matches[math.random(2)]
  return intro_words[1]..choice
end

return {
  description = "Coin!",
  usage = "!coin [one] or [another]",
  patterns = {
    "(.*) !или (.*)",
    "(.*) !or (.*)"
  },
  run = run
}
