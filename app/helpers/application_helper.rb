module ApplicationHelper

  def button(url, name)
    "<a class='nav-buttons' href=#{h(url)}>#{h(name)}</a>".html_safe
  end

  def label(label_for, label)
    "<div style='flex-basis: 40%;'><label for=#{h(label_for)}>#{label}: </label></div>".html_safe
  end

  def input(name, id, value='', type='text')
    "<div style='flex-basis: 60%; margin-bottom: 20px'><input type='#{h(type)}' name='#{h(name)}' id='#{h(id)}' value='#{h(value)}'></div>".html_safe
  end

  def radio_input(name, id, value='', radio_value)
    checked = 'checked' if value == radio_value
    "<div style='flex-basis: 60%; margin-bottom: 20px'><input type='radio' name='#{h(name)}' value='#{h(radio_value)}' id='#{h(id)}' #{h(checked)} ></div>".html_safe
  end

  def ugly_lyrics(lyrics)
    '♫  '+lyrics.split("\n").join("♫  ")
  end
end
