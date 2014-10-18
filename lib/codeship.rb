class Codeship
  def initialize(api_key)
    @api_key = api_key
  end

  def projects
    return @projects if @projects.present?

    response = http_request.get(projects_uri).response
    @projects = if response.code == '200'
      JSON.parse(response.body)['projects']
    else
      []
    end
  end

  def project(uuid)
    response = http_request.get(project_uri(uuid)).response

    if response.code == '200'
      JSON.parse(response.body)
    else
      []
    end
  end

  private

  def projects_uri
    URI.parse "https://www.codeship.io/api/v1/projects.json?api_key=#{@api_key}"
  end

  def project_uri(uuid)
    URI.parse "https://www.codeship.io/api/v1/projects/#{uuid}.json?api_key=#{@api_key}"
  end

  def http_request
    http = Net::HTTP.new 'www.codeship.io', 443
    http.use_ssl = true
    http
  end
end
