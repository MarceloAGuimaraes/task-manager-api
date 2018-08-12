module RequestSpecHelper
    def json_body
       @json_body ||= JSON.parse(response.body, simbolize_names: true)
    end
end