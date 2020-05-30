function youtube -d "Search something on Youtube."
    set text (echo $argv | awk '{gsub(/ /,"\\ ");print}')
    open -a Safari https://www.youtube.com/results\?search_query=$text
end
