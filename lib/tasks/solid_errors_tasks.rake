namespace :solid_errors do
  desc "Copy and run migrations from Solid Errors"
  task install_migrations: :environment do
    source = File.expand_path("../../solid_errors/db/migrate", __FILE__)
    destination = File.join(Rails.root, "db", "migrate")

    Dir.glob("#{source}/*.rb").each do |migration|
      original_filename = File.basename(migration)
      timestamp = Time.now.strftime('%Y%m%d%H%M%S_')
      filename_with_timestamp = "#{timestamp}#{original_filename}"

      unless File.exist?(File.join(destination, filename_with_timestamp))
        puts "Copying #{original_filename} to #{filename_with_timestamp} from Solid Errors to Rails application"
        FileUtils.cp(migration, File.join(destination, filename_with_timestamp))
      end
    end
  end
end
