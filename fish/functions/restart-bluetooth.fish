function restart-bluetooth --wraps='blueutil -p 0 && sleep 1 && blueutil -p 1' --description 'alias restart-bluetooth blueutil -p 0 && sleep 1 && blueutil -p 1'
  blueutil -p 0 && sleep 1 && blueutil -p 1 $argv
        
end
