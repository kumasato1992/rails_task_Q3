require 'csv'
namespace :import_csv do
  desc "CSVデータをインポートするタスク"
  task users: :environment do
    path = "db/csv_data/csv_data.csv"
    list = []
    CSV.foreach(path, headers: true) do |row|
      list << row.to_h
    end
    p "インポート処理を開始".red
    begin
      User.transaction do
        User.create!(list)
      end
      p "インポート完了！！".green
    rescue => e
      p "#{e.class}: #{e.message}"
      p "-------------------------"
      p e.backtrace
      p "-------------------------"
      p "インポートに失敗"
    end
  end
end
