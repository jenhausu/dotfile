function google -d "Search things on Google."
    set text (echo $argv | awk '{gsub(/ /,"\\ ");print}')
    open -a Safari https://www.google.com/search\?q=$text
end
