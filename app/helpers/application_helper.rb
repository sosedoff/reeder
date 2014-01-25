module ApplicationHelper
  def json_response(data, code=200)
    status(code)
    content_type(:json, encoding: 'utf8')
    data.to_json
  end

  def json_error(message, status=400)
    halt(status, json_response(error: message, status: status))
  end

  def render_partial(name, locals={})
    erb(name.to_sym, layout: false, locals: locals)
  end

  def present(obj, options={})
    if options[:as]
      name = "#{options.delete(:as).to_s.capitalize}Presenter"
    else
      name = Presenter.class_for(obj)
    end

    status_code = options.delete(:status) || 200
    paginate    = options.delete(:paginate)

    if paginate && obj.respond_to?(:paginate)
      obj = obj.paginate(
        page: params[:page],
        per_page: 15
      )
    end

    klass     = Kernel.const_get(name)
    presenter = present_object(obj, klass, options)

    if paginate
      json_response({
        count:    obj.total_entries,
        page:     obj.current_page,
        pages:    obj.total_pages,
        per_page: obj.per_page,
        records:  presenter
      }, status_code)
    else
      json_response(presenter, status_code)
    end
  end

  def present_object(obj, klass, options)
    if obj.respond_to?(:map)
      obj.map { |k| klass.new(k, options) }
    else
      klass.new(obj, options)
    end
  end

  def api_user
    @api_user
  end
end