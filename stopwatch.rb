require 'curses'

module Curses
  def self.program
    main_screen = init_screen
    noecho
    cbreak
    curs_set(0)
    main_screen.keypad = true
    yield main_screen
  end
end

def secstr(sec)
  sprintf("%3d:%05.2f", sec/60, sec%60)
end

Curses.program do |scr|
  t2 = t1 = Time.now
  while true do
    c = scr.getch
    t3 = Time.now
    scr.addstr "#{t2} #{secstr(t3-t2)} #{secstr(t3-t1)}\n"
    t1 = t2
    t2 = t3
    break if c == ?q
  end
end
