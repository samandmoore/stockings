class ButtonRadioInput < SimpleForm::Inputs::CollectionRadioButtonsInput
  def input
    out = '<div class="btn-group" data-toggle="buttons">'
    label_method, value_method = detect_collection_methods
    collection.each do |item|
      value = item.send(value_method)
      label = item.send(label_method)
      active = ''
      active = ' active' unless
          out =~ / active/ ||
          input_html_options[:value] != value &&
          item != collection.last
      input_html_options[:value] = value unless active.empty?
      btn = 'btn'
      btn = "btn btn-#{item.third}" unless item.third.nil?
      out << <<-HTML
        <label class="#{btn} #{active}">
          <input type="radio" value="#{value}" name="match[#{attribute_name}]">#{label}</input>
        </label>
      HTML
    end
    out << "</div>"
    out.html_safe
  end
end
