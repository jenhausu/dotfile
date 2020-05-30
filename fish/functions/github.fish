function github -d "Search something on Github."
    set text (echo $argv | awk '{gsub(/ /,"\\ ");print}')
    open -a Safari https://github.com/search?q=$text
end
