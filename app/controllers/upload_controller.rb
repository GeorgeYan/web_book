class UploadController < ApplicationController

  TEMP_DIR = "/tmp"

  def index

  end


  def upload

    upload_io = params[:zip]
    file_path = Rails.root.join('public', 'uploads',
                                upload_io.original_filename)
    File.open(file_path, 'wb') do |file|
      file.write upload_io.read
    end

    analyze_zip_file file_path

  end

  private

  def analyze_zip_file file_path
    tmp_dir = File.join(TEMP_DIR, File.basename(file_path))
    File.exist?(tmp_dir) ? FileUtils.rm_rf(tmp_dir) : nil
    Dir.mkdir(tmp_dir)

    begin
      `unzip #{file_path} -d #{tmp_dir}`
    rescue => e
      logger.error(e.to_s)
    end

    Dir.foreach(tmp_dir) do |file|
      if File.basename(file).to_s =~ /.*\.xml$/ then
        BookReaderHelper::Reader.new(File.join(tmp_dir, file)).book.save()
      end
    end

    FileUtils.rm_rf tmp_dir
  end

end
