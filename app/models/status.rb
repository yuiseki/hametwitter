class Status < ActiveRecord::Base
  set_table_name "twitter_yuiseki"
  set_primary_key "status_id"
  def count
    connection.select_rows(<<-SQL)
      SELECT count(*) AS count
      FROM twitter_yuiseki
    SQL
  end

end
