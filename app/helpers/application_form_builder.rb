class ApplicationFormBuilder < ActionView::Helpers::FormBuilder
  def pick_errors(attribute)
    return nil if @object.nil? || (messages = @object.errors.messages[attribute]).nil?
    lis = messages.collect do |message|
      %{<li>#{message}</li>}
    end.join

    %{<ul class="errors">#{lis}</ul>}.html_safe
  end

  def text_area(attribute, options={})
    return super if options[:no_errors]

    super + pick_errors(attribute)
  end

  def file_field(attribute, options={})
    return super if options[:no_errors]

    super + pick_errors(attribute)
  end

  def select(attribute, options = {}, html_options = {})
    super + pick_errors(attribute)
  end

  def collection_select(attribute, collection, value_method, text_method, options = {}, html_options = {})
    super + pick_errors(attribute)
  end

end
