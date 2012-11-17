# encoding: utf-8

module ApplicationHelper
  def torrent_stats(torrent)
    date = Time.at(torrent.addedDate).strftime("%Y-%m-%d %H:%M")
    percent = "%02.2f" % (torrent.percentDone * 100)
    size = number_to_human_size(torrent.totalSize)
    download_rate = number_to_human_size(torrent.rateDownload)
    upload_rate = number_to_human_size(torrent.rateUpload)

    "#{size} #{date} #{percent}% ↓#{download_rate}/s ↑#{upload_rate}/s"
  end

  def torrent_file_stats(file)
    downloaded = number_to_human_size(file.bytesCompleted)
    size = number_to_human_size(file.length)

    "#{downloaded} of #{size}"
  end

  def torrent_file_downloaded(file)
    file.bytesCompleted == file.length
  end

  def twitterized_type(type)
    case type
      when :alert
        "alert alert-error"
      when :notice
        "alert alert-success"
      else
        type.to_s
    end
  end
end
