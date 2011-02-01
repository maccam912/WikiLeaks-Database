class ChangeSubjectOptions < ActiveRecord::Migration
  def self.up
    change_column(:cables, :subject, :string, :limit => 65536)
  end

  def self.down
  end
end
