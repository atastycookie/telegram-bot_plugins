function run(msg, matches)
    local receiver = get_receiver(msg)
    print('receiver: '..receiver)
    return "Да, хозяин, только по ебалу не бей!!!1"
end

return {
    description = "bot sends pong", 
    usage = "!ping",
    patterns = {"^!ping$"}, 
    run = run 
}
