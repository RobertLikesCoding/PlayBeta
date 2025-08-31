class SetDefaultForSIdInSubmissions < ActiveRecord::Migration[8.0]
  def change
    change_column_default :submissions, :s_id, "gen_random_uuid()"
  end
end
