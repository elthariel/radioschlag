module SlotsHelper

  def slot_time_pretty_printer(time)
    map = ['lundi', 'mardi', 'mercredi', 'jeudi', 'vendredi', 'samedi', 'dimanche']
    day = (time / (24 * 60)) % 7
    time %= 24 * 60
    hour = time / 60
    minute = time % 60
    
    #"#{day}, #{hour}:#{minute}"
    "#{map[day].capitalize}, #{sprintf('%.2d', hour)}:#{sprintf('%.2d', minute)}"
  end
end
