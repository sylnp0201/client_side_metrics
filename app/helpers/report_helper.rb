module ReportHelper
  Url = Utils::Url
  def with_query_str(str, request)
    query_hash = Url.query_to_hash request.query_string
    new_query  = Url.query_to_hash str
    result_hash = query_hash.merge new_query
    "/?#{Url.hash_to_query(result_hash)}"
  end
end
