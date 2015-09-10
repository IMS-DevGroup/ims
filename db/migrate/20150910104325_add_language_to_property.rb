class AddLanguageToProperty < ActiveRecord::Migration
  def change

    add_column :properties, :language, :string

  end
end
