class Resource::Filter

  def filter(scope, query_params)
    if query_params[:amount].present?
      scope = scope.where("amount >= ?", query_params[:amount])
    end
    scope
  end

end